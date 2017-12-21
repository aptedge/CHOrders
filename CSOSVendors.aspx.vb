Imports System.Threading
Imports System.Globalization
Imports System.Configuration
Imports System.Data.Odbc
Imports Turningpoint.Shared
Imports Turningpoint.Data
Imports System.Collections
Imports System.Collections.Generic
Imports System.Data

Partial Class CSOSVendors
    Inherits System.Web.UI.Page
    Dim oDR As System.Data.Odbc.OdbcDataReader
    Dim oCmd As System.Data.Odbc.OdbcCommand

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub


    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Dim sCust As String

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Page.MaintainScrollPositionOnPostBack = True

        Dim usr As UserDetail = Session("UserDetails")
        Try
            sCust = usr.TPSCustomerNumber
        Catch
        End Try

        If sCust = "" Then
            Response.Redirect("login.aspx")
        End If

        page_header_tp.setHeader("CSOS Vendors")

        If Not IsPostBack Then
            ViewState("SortExpression") = "VNDLNM"
            ViewState("sort_asc") = True

            LoadVendors()
        End If
    End Sub

    Public Sub LoadVendors()
        Dim OdbcConnection As New OdbcConnection(ConfigurationManager.ConnectionStrings("TurningpointSystem").ConnectionString)

        Try
            OdbcConnection.Open()
            oCmd = New System.Data.Odbc.OdbcCommand
            oCmd.Connection = OdbcConnection
            oCmd.CommandText = "SELECT V.*, 1 as show_activate FROM FPVNDMAS V WHERE VNDDEA > '' AND VNDSTS = 'A' "

            If cb_csos_only.Checked Then
                oCmd.CommandText += " AND VNSLDS = 'Y' "
            End If

            Dim nVendor As Integer = 0
            Try
                Integer.TryParse(vendor_number.Text, nVendor)
            Catch
            End Try

            If nVendor > 0 Then
                oCmd.CommandText += " AND VNDNUM = " & nVendor
            End If

            oCmd.CommandText += " ORDER BY VNDLNM "

            Dim DA As System.Data.Odbc.OdbcDataAdapter = New System.Data.Odbc.OdbcDataAdapter(oCmd)
            Dim dt As DataTable = New DataTable

            DA.Fill(dt)

            For Each dr As DataRow In dt.Rows
                If dr("VNSLDS").ToString.Trim = "Y" Then
                    dr("show_activate") = 0
                End If
            Next

            Dim dv As DataView = New DataView(dt)

            If ViewState("sort_asc") Then
                dv.Sort = ViewState("SortExpression") & " asc"
            Else
                dv.Sort = ViewState("SortExpression") & " desc"
            End If

            item_list.DataSource = dv
            item_list.DataBind()
        Catch ex As Exception
        Finally
            OdbcConnection.Close()
        End Try
    End Sub

    Private Sub item_list_SortCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridSortCommandEventArgs) Handles item_list.SortCommand
        ' Response.Write(e.SortExpression)
        If ViewState("SortExpression") = e.SortExpression Then
            ViewState("sort_asc") = Not ViewState("sort_asc")
        Else
            ViewState("SortExpression") = e.SortExpression
            ViewState("sort_asc") = True
        End If

        LoadVendors()
    End Sub

    Protected Sub item_list_ItemCommand(source As Object, e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles item_list.ItemCommand
        If e.CommandName = "activate" Then
            ActivateVendor(e.CommandArgument)
            LoadVendors()
        End If
    End Sub

    Private Sub ActivateVendor(ByVal sVendorId As String)
        Dim OdbcConnection As New OdbcConnection(ConfigurationManager.ConnectionStrings("TurningpointSystem").ConnectionString)
        Dim oCmd As OdbcCommand

        Try
            OdbcConnection.Open()

            oCmd = New OdbcCommand
            oCmd.Connection = OdbcConnection
            oCmd.CommandText = "insert into FPWPPOH " & _
                                " select POMNUM, 'I', POMVND, POMBLN, '', 0, '', '', '', '', 0 from FPPOHDR " & _
                                " where POMVND = " & sVendorId & _
                                " and POMSTS = 'O' " & _
                                " and POMNUM not in (select WPMNUM from FPWPPOH) "
            oCmd.ExecuteNonQuery()

            oCmd = New OdbcCommand
            oCmd.Connection = OdbcConnection
            oCmd.CommandText = "update FPVNDMAS set VNSLDS = 'Y' where VNDNUM = " & sVendorId
            oCmd.ExecuteNonQuery()
        Catch ex As Exception
        Finally
            OdbcConnection.Close()
        End Try
    End Sub

    Protected Sub search_button_Click(sender As Object, e As EventArgs) Handles search_button.Click
        LoadVendors()
    End Sub
End Class

