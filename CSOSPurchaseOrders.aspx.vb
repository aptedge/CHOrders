Imports System.Threading
Imports System.Globalization
Imports System.Configuration
Imports System.Data.Odbc
Imports Turningpoint.Shared
Imports Turningpoint.Data
Imports System.Collections
Imports System.Collections.Generic
Imports System.Data

Partial Class InvoiceHistory
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

        page_header_tp.setHeader("Purchase Orders")

        If Not IsPostBack Then
            ViewState("SortExpression") = "POMDAT"
            ViewState("sort_asc") = False

            LoadPurchaseOrders()
        End If
    End Sub

    Public Sub LoadPurchaseOrders()
        Dim OdbcConnection As New OdbcConnection(ConfigurationManager.ConnectionStrings("TurningpointSystem").ConnectionString)

        Try
            OdbcConnection.Open()
            oCmd = New System.Data.Odbc.OdbcCommand
            oCmd.Connection = OdbcConnection
            oCmd.CommandText = "SELECT P.*, V.*, H.*, '' as PODate, '' as Status, 0 as show_resend FROM FPWPPOH P " & _
               " LEFT JOIN FPVNDMAS V ON VNDNUM = WPMVND " & _
               " LEFT JOIN FPPOHDR H ON POMNUM = WPMNUM "

            If cb_open_only.Checked Then
                oCmd.CommandText += " WHERE WPSTAT IN ('O', 'I') "
            Else
                oCmd.CommandText += " WHERE WPSTAT > '' "
            End If

            Dim nPO As Integer = 0
            Try
                Integer.TryParse(inv_number.Text, nPO)
            Catch
            End Try

            If nPO > 0 Then
                oCmd.CommandText += " AND WPMNUM = " & nPO
            End If

            Dim sStartDate As String = ""
            Dim sEndDate As String = ""

            If Not date_start.IsNull And date_start.IsDate Then
                sStartDate = createCYYMMDDFromDateTime(date_start.SelectedDate)
            End If
            If Not date_end.IsNull And date_end.IsDate Then
                sEndDate = createCYYMMDDFromDateTime(date_end.SelectedDate)
            End If

            If sStartDate > "" Then
                If sEndDate = "" Then
                    oCmd.CommandText += " AND POMDAT = " & sStartDate
                Else
                    oCmd.CommandText += " AND POMDAT BETWEEN " & sStartDate & " AND " & sEndDate
                End If
            End If

            oCmd.CommandText += " ORDER BY POMNUM desc"

            Dim DA As System.Data.Odbc.OdbcDataAdapter = New System.Data.Odbc.OdbcDataAdapter(oCmd)
            Dim dt As DataTable = New DataTable

            DA.Fill(dt)

            If dt.Rows.Count < item_list.PageSize Then
                item_list.AllowPaging = False
            Else
                item_list.AllowPaging = True
            End If

            For Each dr As DataRow In dt.Rows
                dr("PODate") = TPSDateToString(dr("POMDAT").ToString.Trim)

                dr("WPEMSG") = dr("WPEMSG").ToString.Replace("EXPRESS222", "EXPRESS 222")

                If dr("WPSTAT") = "O" Then
                    dr("Status") = "Open"
                ElseIf dr("WPSTAT") = "I" Then
                    dr("Status") = "In Process"
                    dr("show_resend") = 1
                    'If dr("WPMBLN").ToString.Trim = ""
                    'End If
                ElseIf dr("WPSTAT") = "R" Then
                    dr("Status") = "Received"
                ElseIf dr("WPSTAT") = "X" Then
                    dr("Status") = "Cancelled"
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
            Utils.traceApp(Server, "PO List: " & ex.Message)
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

        item_list.CurrentPageIndex = 0

        LoadPurchaseOrders()
    End Sub

    Private Sub item_list_PageIndexChanged(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles item_list.PageIndexChanged
        item_list.CurrentPageIndex = e.NewPageIndex
        LoadPurchaseOrders()
    End Sub

    Protected Sub item_list_ItemCommand(source As Object, e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles item_list.ItemCommand
        If e.CommandName = "resend" Then
            ResendPO(e.CommandArgument)
            LoadPurchaseOrders()
        End If
    End Sub

    Private Sub ResendPO(ByVal sPO As String)
        Dim OdbcConnection As New OdbcConnection(ConfigurationManager.ConnectionStrings("TurningpointSystem").ConnectionString)
        Dim oCmd As OdbcCommand

        Try
            OdbcConnection.Open()

            oCmd = New OdbcCommand
            oCmd.Connection = OdbcConnection
            oCmd.CommandText = "update FPWPPOH set WPSTAT = 'Q', WPEMSG = 'RESENT TO EXPRESS 222' where WPMNUM = " & sPO
            oCmd.ExecuteNonQuery()
        Catch ex As Exception
        Finally
            OdbcConnection.Close()
        End Try
    End Sub

    Function TPSDateToString(ByVal tpsDate As String) As String
        Dim sDate As String = ""

        Try
            If tpsDate = "" Or tpsDate = "0" Then
                Return ""
            End If

            sDate = tpsDate.Substring(3, 2) & "/" & tpsDate.Substring(5, 2) & "/" & tpsDate.Substring(1, 2)
        Catch ex As Exception
        End Try

        Return sDate
    End Function

    Private Function createCYYMMDDFromDateTime(ByVal sdt As String) As String
        If sdt.Trim() = "" Then
            Return "1000101"
        End If

        Dim dt As DateTime = sdt

        Dim sDate As String = dt.ToString("yyMMdd")
        Dim y As String = dt.Year

        Dim century As Integer = Integer.Parse(y.Substring(0, 2))
        Dim c = (century - 19).ToString()

        Return c & sDate
    End Function

    Protected Sub search_button_Click(sender As Object, e As System.EventArgs) Handles search_button.Click
        LoadPurchaseOrders()
    End Sub

End Class

