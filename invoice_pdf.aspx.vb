Imports System.IO
Imports System
Imports System.Collections
Imports System.Data
Imports System.Configuration
Imports System.Data.Odbc
Imports System.Net.Mail
Imports Winnovative.WnvHtmlConvert
Imports TurningPoint.Shared
Imports TurningPoint.Data
Imports System.Collections.Generic

Partial Class invoice_pdf
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

    Public sClass As String
    Public sCust As String
    Public sOrder As String
    Public InvoiceTotal As String

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Page.MaintainScrollPositionOnPostBack = True

        Try
            sOrder = Request.QueryString("order")
        Catch
        End Try

        If Not IsPostBack Then
            ViewState("SortExpression") = "line_no"
            ViewState("sort_asc") = True

            SetHeader()
            GetCustomer()
            LoadView()
        End If
    End Sub

    Sub LoadView()
        Try
            Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()

            Dim dt As DataTable = New DataTable

            dt.Columns.Add("item_no", GetType(String))
            dt.Columns.Add("line_no", GetType(Integer))
            dt.Columns.Add("item_desc", GetType(String))
            dt.Columns.Add("vendor_name", GetType(String))
            dt.Columns.Add("item_unit_upc", GetType(String))
            dt.Columns.Add("item_box_upc", GetType(String))
            dt.Columns.Add("item_size", GetType(String))
            dt.Columns.Add("item_form", GetType(String))
            dt.Columns.Add("qty_shipped", GetType(String))
            dt.Columns.Add("price", GetType(Double))
            dt.Columns.Add("ext_amt", GetType(Double))

            Dim response As GetInvoiceItemsResponse = tpsData.GetInvoiceItems(sOrder, sCust)
            Dim OrderItems As List(Of InvoiceItem) = response.InvoiceItemList

            For Each oi As InvoiceItem In OrderItems
                Dim nItem As Integer = 0
                Try
                    Integer.TryParse(oi.ItemNumber, nItem)
                Catch
                End Try

                dt.Rows.Add(oi.ItemNumber, oi.LineNo, oi.Description, "", oi.UPC, oi.CaseUPC, oi.Size, oi.Form, oi.Qty, oi.Price, oi.ExtPrice)
            Next

            Dim dv As DataView = New DataView(dt)

            If ViewState("sort_asc") Then
                dv.Sort = ViewState("SortExpression") & " asc"
            Else
                dv.Sort = ViewState("SortExpression") & " desc"
            End If

            item_list.DataSource = dv
            item_list.DataBind()

            hdr_order_items.Text = OrderItems.Count()
        Catch ex As Exception
            Utils.traceApp(Server, ex.Message & vbCrLf & ex.StackTrace)
        End Try
    End Sub

    Sub SetHeader()
        Dim usr As UserDetail = Session("UserDetails")
        Try
            sCust = usr.TPSCustomerNumber
        Catch
        End Try

        Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()

        Try
            Dim invHeader As InvoiceHeader = tpsData.GetInvoiceHeaderPDF(sOrder)

            hdr_order_no.Text = sOrder
            hdr_order_total.Text = FormatCurrency(invHeader.Amount, 2)
            hdr_order_invoice_date.Text = FormatDateTime(invHeader.Date, DateFormat.ShortDate)
            InvoiceTotal = FormatCurrency(invHeader.Amount, 2)
            hdr_terms.Text = invHeader.Terms

            page_header_pdf.SetHeader("Invoice", sOrder)

        Catch ex As Exception
            'utils.traceApp(Server, "order edit cust: " & ex.Message & ex.StackTrace & vbCrLf & sqlCmd.CommandText)
        End Try
    End Sub

    Sub GetCustomer()
        Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()
        Dim cust As Customer = tpsData.GetCustomer(sCust)

        Try
            customer_name.Text = cust.CustomerName
            customer_address.Text = cust.Address
            customer_citystatezip.Text = cust.City + ", " + cust.State + "  " + cust.Zip
            customer_phone.Text = "Phone: " + cust.Phone
            customer_fax.Text = "Fax: " + cust.Fax
            customer_no.Text = "Cust No: " + sCust
        Catch ex As Exception
        End Try
    End Sub

    Private Sub item_list_SortCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridSortCommandEventArgs) Handles item_list.SortCommand
        If ViewState("SortExpression") = e.SortExpression Then
            ViewState("sort_asc") = Not ViewState("sort_asc")
        Else
            ViewState("SortExpression") = e.SortExpression
            ViewState("sort_asc") = True
        End If
        item_list.CurrentPageIndex = 0
        LoadView()
    End Sub

End Class
