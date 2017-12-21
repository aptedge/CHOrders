Imports System.Threading
Imports System.Globalization
Imports System.Configuration
Imports System.Data.Odbc
Imports Turningpoint.Shared
Imports Turningpoint.Data
Imports System.Collections
Imports System.Collections.Generic
Imports System.Data

Partial Class AP
    Inherits System.Web.UI.Page

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

        CustNo.Attributes("value") = usr.TPSCustomerNumber

        If Not IsPostBack Then
            LoadView()
        End If
    End Sub

    Private Sub LoadView()
        Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent
        Dim acct As AccountStatus = tpsData.GetCustAccount(CustNo.Attributes("value"))

        header_amount_due.Text = String.Format("{0:C}", acct.AmountOpen)
        header_last_payment_date.Text = acct.LastPaymentDate.ToShortDateString()
        header_last_payment_amt.Text = String.Format("{0:C}", acct.LastPaymentAmount)

        Dim parms As SearchAccountsPayableParameters = New SearchAccountsPayableParameters()
        parms.CustomerNumber = CustNo.Attributes("value")
        If date_start.IsDate And Not date_start.IsNull Then
            parms.Date = date_start.SelectedDate
        End If
        If date_end.IsDate And Not date_end.IsNull Then
            parms.ToDate = date_end.SelectedDate
        End If
        parms.DocumentNumber = txn_number.Text.Trim()

        Dim response As SearchAccountsPayableResponse = tpsData.SearchAccountsPayable(parms)

        Dim dt As DataTable = New DataTable()

        dt.Columns.Add("TxnDate")
        dt.Columns.Add("TxnNo")
        dt.Columns.Add("TxnType")
        dt.Columns.Add("Amount")
        dt.Columns.Add("Closed", GetType(Boolean))

        For Each ap As AccountPayable In response.AccountPayableList
            Dim iClosed As Integer = 0

            If ap.ARClosed = 0 Then
                iClosed = 1
            End If

            dt.Rows.Add(ap.Date.ToShortDateString(), ap.DocNo, ap.DocType, ap.Amount, iClosed)
        Next

        Dim dv As DataView = New DataView(dt)

        item_list.DataSource = dv
        item_list.DataBind()
    End Sub

    Private Sub item_list_PageIndexChanged(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles item_list.PageIndexChanged
        item_list.CurrentPageIndex = e.NewPageIndex
        LoadView()
    End Sub

    Protected Sub search_button_Click(sender As Object, e As EventArgs) Handles search_button.Click
        item_list.CurrentPageIndex = 0
        LoadView()
    End Sub
End Class

