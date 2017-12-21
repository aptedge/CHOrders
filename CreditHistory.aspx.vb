Imports System.Threading
Imports System.Globalization
Imports System.Configuration
Imports System.Data.Odbc
Imports Turningpoint.Shared
Imports Turningpoint.Data
Imports System.Collections
Imports System.Collections.Generic
Imports System.Data

Partial Class CreditHistory
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

        body.Style.Add("background-color", Session("PageBackColor").ToString)

        If ConfigurationManager.AppSettings("WelcomePage").ToString() = "welcome2.aspx" Then
            header.Visible = True
        Else
            header_new.Visible = True
            page_header_tp.setHeader("Credit History")
        End If

        If Not IsPostBack Then
            ViewState("SortExpression") = "CHCMDT"
            ViewState("sort_asc") = False

            loadInvoiceHistory()
        End If
    End Sub

    Public Sub loadInvoiceHistory()
        Dim OdbcConnection As New OdbcConnection(ConfigurationManager.ConnectionStrings("TurningpointSystem").ConnectionString)

        Try
            OdbcConnection.Open()
            oCmd = New System.Data.Odbc.OdbcCommand
            oCmd.Connection = OdbcConnection
            oCmd.CommandText = "SELECT C.*, '' as CrdDate FROM FPCRDHDR C WHERE CHCUST = " & sCust

            Dim nCredit As Integer = 0
            Try
                Integer.TryParse(credit_number.Text, nCredit)
            Catch
            End Try

            If nCredit > 0 Then
                oCmd.CommandText += " AND CHARNO = " & nCredit
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
                    oCmd.CommandText += " AND CHCMDT = " & sStartDate
                Else
                    oCmd.CommandText += " AND CHCMDT BETWEEN " & sStartDate & " AND " & sEndDate
                End If
            End If

            oCmd.CommandText += " ORDER BY CHCMDT, CHARNO desc"

            Dim DA As System.Data.Odbc.OdbcDataAdapter = New System.Data.Odbc.OdbcDataAdapter(oCmd)
            Dim dt As DataTable = New DataTable

            DA.Fill(dt)

            If dt.Rows.Count < item_list.PageSize Then
                item_list.AllowPaging = False
            Else
                item_list.AllowPaging = True
            End If

            For Each dr As DataRow In dt.Rows
                dr("CrdDate") = TPSDateToString(dr("CHCMDT").ToString.Trim)
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

    Private Sub item_list_SortCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridSortCommandEventArgs) Handles item_list.SortCommand
        ' Response.Write(e.SortExpression)
        If ViewState("SortExpression") = e.SortExpression Then
            ViewState("sort_asc") = Not ViewState("sort_asc")
        Else
            ViewState("SortExpression") = e.SortExpression
            ViewState("sort_asc") = True
        End If
        item_list.CurrentPageIndex = 0
        loadInvoiceHistory()
    End Sub

    Private Sub item_list_PageIndexChanged(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles item_list.PageIndexChanged
        item_list.CurrentPageIndex = e.NewPageIndex
        loadInvoiceHistory()
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

    Protected Sub search_button_Click(sender As Object, e As EventArgs) Handles search_button.Click
        loadInvoiceHistory()
    End Sub
End Class

