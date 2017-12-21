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

Partial Class OrderPrint
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

    Public CustomerNo As String
    Public CustomerName As String
    Public InvoiceNo As String
    Public OrderDate As String
    Public OrderAmt As String
    Public OrderLines As String
    Public OrderTotal As String
    Public DEANumber As String

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Page.MaintainScrollPositionOnPostBack = True

        Dim usr As UserDetail = Session("UserDetails")
        Try
            CustomerNo = usr.TPSCustomerNumber
            CustomerName = ""
        Catch
        End Try

        If CustomerNo = "" Then
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "myCloseScript", "window.close()", True)
            Exit Sub
        End If

        InvoiceNo = Request.QueryString("orderno")

        If ConfigurationManager.AppSettings("RX") = "yes" Then
            item_list.Columns(8).Visible = False
        Else
            item_list.Columns(7).Visible = False
        End If

        LoadView()

        ViewState("SortExpression") = "ITDESC"
        ViewState("sort_asc") = True
        Session("SortExpression") = ViewState("SortExpression")
        Session("sort_asc") = True
    End Sub

    Private Sub LoadView()
        Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()

        Dim invHdr As InvoiceHeader = tpsData.GetInvoiceHeader(InvoiceNo)
        Dim orderHdr As OrderHeader = tpsData.GetOrderHeaderTPS(invHdr.OrderNo)

        If orderHdr.DEABlankNumber = "" Then
            dea_blank.Visible = False
            DEANumber = ""
        Else
            dea_blank.Visible = True
            DEANumber = orderHdr.DEABlankNumber
        End If

        Dim cust As Customer = tpsData.GetCustomer(CustomerNo)
        CustomerName = cust.CustomerName

        OrderDate = invHdr.Date ' FormatDateTime(orderHdr.DateCreated, vbShortDate)

        Try
            Dim dt As DataTable = New DataTable

            dt.Columns.Add("ItemNumber", GetType(String))
            dt.Columns.Add("ItemNo", GetType(Integer))
            dt.Columns.Add("Description", GetType(String))
            dt.Columns.Add("UPC", GetType(String))
            dt.Columns.Add("Size", GetType(String))
            dt.Columns.Add("Form", GetType(String))
            dt.Columns.Add("Price", GetType(String))
            dt.Columns.Add("Retail", GetType(String))
            dt.Columns.Add("NDC", GetType(String))
            dt.Columns.Add("Quantity", GetType(Integer))
            dt.Columns.Add("LineNumber", GetType(Integer))
            dt.Columns.Add("ExtPrice", GetType(String))

            Dim usrDetails As UserDetail = Session("UserDetails")

            Dim response As GetInvoiceItemsResponse = tpsData.GetInvoiceItems(0, CustomerNo, invHdr.OrderNo)
            Dim OrderItems As List(Of InvoiceItem) = response.InvoiceItemList

            Dim nLines As Integer = 0
            Dim nLWDLines As Integer = 0
            Dim nABCLines As Integer = 0
            Dim dTotal As Double = 0
            Dim dLWDTotal As Double = 0
            Dim dABCTotal As Double = 0

            For Each oi As InvoiceItem In OrderItems
                Dim nItem As Integer = 0
                Integer.TryParse(oi.ItemNumber, nItem)

                Dim dExtPrice As Double = 0
                Double.TryParse(oi.ExtPrice, dExtPrice)

                If oi.Color = "0" Or oi.Color = "2" Or oi.Color = "" Then
                    nLWDLines += 1
                    dLWDTotal += dExtPrice
                End If
                If oi.Color = "1" Or oi.Color = "3" Then
                    nABCLines += 1
                    dABCTotal += dExtPrice
                End If

                dTotal += dExtPrice
                nLines += 1

                If oi.Color = "0" Then
                    oi.Price = ""
                    oi.ExtPrice = ""
                End If

                dt.Rows.Add(oi.ItemNumber, nItem, oi.Description, oi.UPC, oi.Size, oi.Form, oi.Price, oi.RetailPrice, oi.NDC, oi.ShippedQty, oi.LineNo, oi.ExtPrice)
            Next

            Dim dv As DataView = New DataView(dt)

            If Session("order_sort_asc") Then
                dv.Sort = Session("OrderSortExpression") & " asc"
            Else
                dv.Sort = Session("OrderSortExpression") & " desc"
            End If

            item_list.DataSource = dv
            item_list.DataBind()

            OrderLines = nLines
            OrderTotal = FormatNumber(dTotal, 2)
        Catch ex As Exception
            Utils.traceApp(Server, ex.Message + vbCrLf + ex.StackTrace)
        End Try
    End Sub

End Class

