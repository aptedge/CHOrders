Imports System.IO
Imports System
Imports System.Collections
Imports System.Collections.Generic
Imports System.Data
Imports System.Configuration
Imports System.Data.Odbc
Imports Turningpoint.Shared
Imports Turningpoint.Data

Partial Class CustomerSelect
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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Page.MaintainScrollPositionOnPostBack = True

        Dim usrDetails As UserDetail
        Try
            usrDetails = Session("UserDetails")
            If usrDetails.TPSCustomerNumber = "" Then
                Response.Redirect("~/login.aspx")
                Exit Sub
            End If
        Catch
            Response.Redirect("~/login.aspx")
            Exit Sub
        End Try

        body.Style.Add("background-color", Session("PageBackColor").ToString)

        If usrDetails.ChainMgr = "A" Then
            Response.Redirect("CustomerSelectAdmin.aspx")
            Exit Sub
        End If

        If Not IsPostBack Then
            Session("SortExpression") = "CustomerName"
            Session("sort_asc") = True

            LoadView()
        End If

        cust_number.Focus()
    End Sub

    Sub LoadView()
        Try
            Dim usrDetails As UserDetail = Session("UserDetails")

            Dim dt As DataTable = New DataTable

            dt.Columns.Add("CustomerNo", GetType(String))
            dt.Columns.Add("CustomerNumber", GetType(String))
            dt.Columns.Add("CustomerName", GetType(String))
            dt.Columns.Add("CustomerAddress", GetType(String))
            dt.Columns.Add("CustomerCity", GetType(String))
            dt.Columns.Add("CustomerState", GetType(String))
            dt.Columns.Add("CustomerPhone", GetType(String))

            Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()
            Dim lstCust As List(Of Customer) = tpsData.GetChainCustomers(usrDetails.TPSChainNumber, usrDetails.Salesman)

            For Each c As Customer In lstCust
                Dim sCustNo As String = Right("000000" + c.CustomerNo, 6)

                dt.Rows.Add(c.CustomerNo, sCustNo, c.CustomerName, c.Address, c.City, c.State, c.Phone)
            Next

            Dim dv As DataView = New DataView(dt)

            Session("dt_cust") = dt

            Try
                If Session("sort_asc") Then
                    dv.Sort = Session("SortExpression") & " asc"
                Else
                    dv.Sort = Session("SortExpression") & " desc"
                End If
            Catch ex As Exception
                Utils.traceApp(Server, ex.Message & vbCrLf & ex.StackTrace)
            End Try

            item_list.DataSource = dv
            item_list.DataBind()
        Catch ex As Exception
            Utils.traceApp(Server, ex.Message)
        End Try
    End Sub

    Protected Sub item_list_ItemCommand(source As Object, e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles item_list.ItemCommand
        If e.CommandName = "select_cust" Then
            Response.Redirect("welcome.aspx?custno=" & e.CommandArgument)
        End If
    End Sub

    Private Sub item_list_SortCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridSortCommandEventArgs) Handles item_list.SortCommand
        If Session("SortExpression") = e.SortExpression Then
            Session("sort_asc") = Not Session("sort_asc")
        Else
            Session("SortExpression") = e.SortExpression
            Session("sort_asc") = True
        End If

        item_list.CurrentPageIndex = 0

        LoadView()
    End Sub

    Protected Sub item_list_PageIndexChanged(source As Object, e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles item_list.PageIndexChanged
        item_list.CurrentPageIndex = e.NewPageIndex
        LoadView()
    End Sub

    Protected Sub cancel_button_Click(sender As Object, e As EventArgs) Handles cancel_button.Click
        Response.Redirect("~/login.aspx")
    End Sub

    Protected Sub search_button_Click(sender As Object, e As EventArgs) Handles search_button.Click
        Dim dt As DataTable = Session("dt_cust")

        Dim nCust As Integer = 0
        Try
            nCust = Integer.Parse(cust_number.Text)
        Catch
        End Try

        If nCust = 0 Then
            message.Text = "Enter a valid Customer #"
            Exit Sub
        End If

        For Each dr As DataRow In dt.Rows
            Dim cust As Integer = dr("CustomerNo")

            If cust = nCust Then
                Response.Redirect("welcome.aspx?custno=" & cust)
                Exit Sub
            End If
        Next

        message.Text = "Customer not found"
        cust_number.Focus()
    End Sub
End Class
