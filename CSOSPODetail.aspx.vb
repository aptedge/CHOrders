Imports System.Threading
Imports System.Globalization
Imports System.Configuration
Imports System.Data.Odbc
Imports Turningpoint.Shared
Imports Turningpoint.Data
Imports System.Collections
Imports System.Collections.Generic
Imports System.Data
Imports System.IO
Imports Winnovative.WnvHtmlConvert

Partial Class PODetail
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
    Dim nPO As String
    Dim sDate As String
    Dim sAmt As String
    Dim sVendor As String

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

        If ConfigurationManager.AppSettings("WelcomePage").ToString() = "welcome2.aspx" Then
            header.Visible = True
        Else
            header_new.Visible = True
            page_header_tp.setHeader("PO Detail")
        End If

        If Not IsPostBack Then
            nPO = Request.QueryString("no")

            Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()
            Dim poHeader As POHeader = tpsData.GetPOHeader(nPO)

            header_po_no.Text = nPO
            header_po_date.Text = poHeader.Date
            header_vendor.Text = poHeader.VendorName
            header_dea_no.Text = poHeader.DEABlankNo
            header_po_amt.Text = FormatCurrency(poHeader.Amount, 2)

            ViewState("SortExpression") = "ITDESC"
            ViewState("sort_asc") = True
            Session("SortExpression") = ViewState("SortExpression")
            Session("sort_asc") = True

            loadPODetails()
        End If
    End Sub

    Public Sub loadPODetails()
        Dim dt As DataTable = New DataTable

        Dim OdbcConnection As New OdbcConnection(ConfigurationManager.ConnectionStrings("TurningpointSystem").ConnectionString)

        Try
            OdbcConnection.Open()
            oCmd = New System.Data.Odbc.OdbcCommand
            oCmd.Connection = OdbcConnection

            oCmd.CommandText = "SELECT D.*, I.* " & _
                                   " FROM FPPODTL D" & _
                                   " LEFT JOIN FPITMMAW I ON PODITM=ITMNUM AND LWDITM='Y'" & _
                                   " WHERE PODNUM = " & nPO & " ORDER BY ITDESC"

            Dim DA As System.Data.Odbc.OdbcDataAdapter = New System.Data.Odbc.OdbcDataAdapter(oCmd)

            DA.Fill(dt)

            item_list.AllowPaging = False

            For Each dr As DataRow In dt.Rows
                Try
                    Dim sNDC As String = Right(dr("ITMNDC").ToString, 11)
                    sNDC = Left(sNDC, 5) + "-" + sNDC.Substring(5, 4) + "-" + Right(sNDC, 2)
                    dr("ITMNDC") = sNDC
                Catch
                End Try
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

        Session("SortExpression") = e.SortExpression
        Session("sort_asc") = True

        item_list.CurrentPageIndex = 0
        loadPODetails()
    End Sub

    Private Sub item_list_PageIndexChanged(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles item_list.PageIndexChanged
        item_list.CurrentPageIndex = e.NewPageIndex
        loadPODetails()
    End Sub

    Function TPSDateToString(ByVal tpsDate As String) As String
        Dim sDate As String

        If tpsDate = "" Or tpsDate = "0" Then
            Return ""
        End If

        sDate = tpsDate.Substring(3, 2) & "/" & tpsDate.Substring(5, 2) & "/" & tpsDate.Substring(1, 2)
        Return sDate
    End Function

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
    End Sub

End Class

