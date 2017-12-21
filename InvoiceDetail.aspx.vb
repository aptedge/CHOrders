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
    Dim nInv As String
    Dim sType As String
    Dim sDate As String
    Dim sAmt As String
    Private sCSV As String = ""

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

        If ConfigurationManager.AppSettings("RX") = "yes" Then
            item_list.Columns(3).Visible = False
            item_list.Columns(4).Visible = False
            item_list.Columns(10).Visible = False
        Else
            item_list.Columns(5).Visible = False
        End If

        If ConfigurationManager.AppSettings("WelcomePage").ToString() = "welcome2.aspx" Then
            header.Visible = True
            btnCopy.Visible = True
        Else
            header_new.Visible = True
            page_header_tp.setHeader("Invoice Detail")
        End If

        nInv = Request.QueryString("no")
        sType = "invoice"

        Try
            sType = Request.QueryString("type")
        Catch
            sType = "invoice"
        End Try

        Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()
        Dim invHeader As InvoiceHeader = tpsData.GetInvoiceHeader(nInv)

        header_invoice_no.Text = nInv
        header_invoice_date.Text = invHeader.Date
        header_invoice_amt.Text = FormatCurrency(invHeader.Amount, 2)

        If ConfigurationManager.AppSettings("BLU") = "yes" Then
            exportpdf_link.Visible = True
            exportpdf_label.Visible = True
        End If

        If ConfigurationManager.AppSettings("ShowInvoiceCompliancePDF") = "yes" Then
            item_list.Columns(13).Visible = True
        End If

        If ConfigurationManager.AppSettings("OrderPrint") = "yes" Then
            print_button.Visible = True
            print_text.Visible = True
        Else
            print_button.Visible = False
            print_text.Visible = False
        End If

        If Not IsPostBack Then
            ViewState("SortExpression") = "ITDESC"
            ViewState("sort_asc") = True
            Session("SortExpression") = ViewState("SortExpression")
            Session("sort_asc") = True

            loadInvoiceDetails(item_list)
        End If
    End Sub

    Dim fTotal As Double = 0
    Dim fItems As Integer = 0

    Public Function loadInvoiceDetails(ByRef dg As DataGrid) As DataTable
        Dim dt As DataTable = New DataTable

        Dim OdbcConnection As New OdbcConnection(ConfigurationManager.ConnectionStrings("TurningpointSystem").ConnectionString)

        Try
            fTotal = 0
            fItems = 0

            OdbcConnection.Open()
            oCmd = New System.Data.Odbc.OdbcCommand
            oCmd.Connection = OdbcConnection

            If ConfigurationManager.AppSettings("LWD") = "yes" Then
                oCmd.CommandText = "SELECT distinct A.ORDTIT, 0 as ORUSIT, A.OTCACT, A.ORDTSQ, A.ORDTQT, A.ORDTLN, B.ITDESC, B.ITSIZE, B.ITFORM, B.ITMUPC, B.ITNDCI, '' as UPC, '' as ZUPC, '' as NDCI, '' as ZNDCI, B.ITMNDC, B.ITINVT, 0 as OCLNX$, 0 as ITEM, 0.0 as EXT, 0 as ORDTSR, TTREFL AS OTLOT#, TTLOTEXPDT AS LMEDAT, '' AS VNDLNM, '' AS VNDSTR, '' AS VNDCTY, '' AS VNDSTA, '' AS VNDZIP, '' AS ITEM_ARGS, 'N' AS ITLOTC, 0 as SHOW_PDF" & _
                                   " FROM FPORDDTL A LEFT JOIN FPITMMAW B ON A.ORDTIT = B.ITMNUM" & _
                                   " LEFT JOIN FPPOTNT L ON L.TTORDTNM = A.ORDTNM AND L.TTORDTIT = A.ORDTIT AND L.TTORDTLN = A.ORDTLN" & _
                                   " WHERE A.OTINV# = " & nInv & " ORDER BY B.ITDESC"
            ElseIf ConfigurationManager.AppSettings("RX") = "yes" Then
                oCmd.CommandText = "SELECT distinct A.ORDTIT, 0 as ORUSIT, A.OTCACT, A.ORDTSQ, A.ORDTQT, A.ORDTLN, B.ITDESC, B.ITSIZE, B.ITFORM, B.ITMUPC, B.ITNDCI, '' as UPC, '' as ZUPC, '' as NDCI, '' as ZNDCI, B.ITMNDC, B.ITINVT, 0 as OCLNX$, 0 as ITEM, 0.0 as EXT, 0 as ORDTSR, OTLOT#, LMEDAT, VNDLNM, VNDSTR, VNDCTY, VNDSTA, VNDZIP, '' AS ITEM_ARGS, ITLOTC, 0 as SHOW_PDF" & _
                                   " FROM FPORDDTL A LEFT JOIN FPITMMAS B ON A.ORDTIT = B.ITMNUM" & _
                                   " LEFT JOIN FPLOTMAS L ON L.LMLOT# = A.OTLOT# AND L.LMITEM = A.ORDTIT" & _
                                   " LEFT JOIN FPVNDMAS V ON V.VNDNUM = B.ITMFGR" & _
                                   " WHERE A.OTINV# = " & nInv & " ORDER BY B.ITDESC"
            Else
                oCmd.CommandText = "SELECT distinct A.VWDTIT as ORDTIT, A.VWUSIT as ORUSIT, A.VWCACT as OTCACT, A.VWDTSQ as ORDTSQ, A.VWDTQT as ORDTQT, A.VWDTLN as ORDTLN, B.ITDESC, B.ITSIZE, B.ITFORM, B.ITMUPC, B.ITNDCI, '' as UPC, C.ITMUPC as ZUPC, '' as NDCI, C.ITNDCI as ZNDCI, C.ITDESC as ZDESC, B.ITMNDC, B.ITINVT, 0 as OCLNX$, 0 as ITEM, 0.0 as EXT, VWSRP as ORDTSR, '' AS ITEM_ARGS, 'N' AS ITLOTC, 0 AS SHOW_PDF" & _
                                   " FROM FPINVWRK A " & _
                                   " LEFT JOIN FPITMMAS B ON A.VWDTIT = B.ITMNUM" & _
                                   " LEFT JOIN FPITMMAS C ON A.VWUSIT = C.ITMNUM" & _
                                   " WHERE A.VWINV# = " & nInv & " ORDER BY B.ITDESC"
                'Else
                '    oCmd.CommandText = "SELECT distinct A.ORDTIT, A.ORUSIT, A.OTCACT, A.ORDTSQ, A.ORDTQT, A.ORDTLN, B.ITDESC, B.ITSIZE, B.ITFORM, B.ITMUPC, B.ITNDCI, '' as UPC, C.ITMUPC as ZUPC, '' as NDCI, C.ITNDCI as ZNDCI, C.ITDESC as ZDESC, B.ITMNDC, B.ITINVT, 0 as OCLNX$, 0 as ITEM, 0.0 as EXT" & _
                '                       " FROM FPORDDTL A " & _
                '                       " LEFT JOIN FPITMMAS B ON A.ORDTIT = B.ITMNUM" & _
                '                       " LEFT JOIN FPITMMAS C ON A.ORUSIT = C.ITMNUM" & _
                '                       " WHERE A.OTINV# = " & nInv & " ORDER BY B.ITDESC"
            End If

            ' " LEFT JOIN FPORDCRD C ON C.OCDOC# = A.OTINV# AND C.OCDLNE = A.ORDTLN" & _

            Dim DA As System.Data.Odbc.OdbcDataAdapter = New System.Data.Odbc.OdbcDataAdapter(oCmd)

            DA.Fill(dt)

            sCSV = ""

            sCSV += "Invoice No, Invoice Date, Amount" + vbCrLf
            sCSV += header_invoice_no.Text + "," + header_invoice_date.Text + "," + header_invoice_amt.Text.Replace(",", "") + vbCrLf + vbCrLf

            For k As Integer = 0 To dg.Columns.Count - 1
                If dg.Columns(k).Visible Then
                    sCSV += dg.Columns(k).HeaderText + ","c
                End If
            Next
            sCSV += vbCrLf

            If dt.Rows.Count < item_list.PageSize Then
                item_list.AllowPaging = False
            Else
                item_list.AllowPaging = True
            End If

            For Each dr As DataRow In dt.Rows
                If ConfigurationManager.AppSettings("LWD") = "yes" Then
                    Dim dtLot As Integer = 0
                    Try
                        dtLot = dr("LMEDAT")
                    Catch
                        dr("LMEDAT") = 0
                    End Try
                    If dr("OTLOT#").ToString.Trim > "" Then
                        dr("ITLOTC") = "Y"
                    End If
                    ' LWD needs this to show for all items not just lot controlled
                    dr("ITLOTC") = "Y"
                End If

                If dr("ITLOTC") = "Y" Then
                    dr("SHOW_PDF") = 1
                End If

                If ConfigurationManager.AppSettings("RX") = "yes" Then
                    dr("ITEM") = dr("ORDTIT")
                    dr("UPC") = dr("ITMUPC").ToString
                Else
                    If dr("ITINVT").ToString().Trim() = "Z" Then
                        dr("ITEM") = dr("ORUSIT")
                        dr("UPC") = dr("ZUPC").ToString
                        dr("NDCI") = dr("ZNDCI").ToString
                        dr("ITDESC") = dr("ZDESC").ToString
                    Else
                        dr("ITEM") = dr("ORDTIT")
                        dr("UPC") = dr("ITMUPC").ToString
                        dr("NDCI") = dr("ITNDCI").ToString
                    End If
                End If

                dr("EXT") = Convert.ToDouble(dr("ORDTSQ")) * Convert.ToDouble(dr("OTCACT"))
                fTotal += dr("EXT")
                fItems += dr("ORDTSQ")

                sCSV += dr("ORDTLN").ToString + ","c
                sCSV += dr("ITEM").ToString + ","c
                sCSV += """" + dr("ITDESC").ToString.Trim() + """" + ","c

                Try
                    Dim sNDC As String = Right(dr("ITMNDC").ToString.Trim, 11)
                    sNDC = Left(sNDC, 5) + "-" + sNDC.Substring(5, 4) + "-" + Right(sNDC, 2)
                    dr("ITMNDC") = sNDC
                Catch
                End Try

                dr("ITEM_ARGS") = dr("ITEM").ToString + "|" + dr("ITMNDC").ToString + "|" + dr("ITDESC").ToString + "|" + dr("ORDTLN").ToString + "|" + dr("ITSIZE").ToString.Trim + "|" + dr("ITFORM").ToString.Trim

                If ConfigurationManager.AppSettings("RX") = "yes" Then
                    If dr("ITMNDC").ToString.Trim() > "" Then
                        sCSV += dr("ITMNDC").ToString.Trim() + " *" + ","c
                    Else
                        sCSV += ","c
                    End If
                Else
                    If dr("UPC").ToString.Trim() > "" Then
                        sCSV += dr("UPC").ToString.Trim() + " *" + ","c
                    Else
                        sCSV += ","c
                    End If
                    If dr("NDCI").ToString.Trim() > "" Then
                        sCSV += dr("NDCI").ToString.Trim() + " *" + ","c
                    Else
                        sCSV += ","c
                    End If
                End If

                sCSV += dr("ITSIZE").ToString + ","c
                sCSV += dr("ITFORM").ToString + ","c
                sCSV += dr("ORDTQT").ToString + ","c
                sCSV += dr("ORDTSQ").ToString + ","c

                If Not ConfigurationManager.AppSettings("RX") = "yes" Then
                    sCSV += dr("ORDTSR").ToString + ","c
                End If

                sCSV += dr("OTCACT").ToString + ","c
                sCSV += dr("EXT").ToString + ","c
                sCSV += vbCrLf
            Next
            header_invoice_amt.Text = FormatCurrency(fTotal, 2)

            Dim dv As DataView = New DataView(dt)

            If ViewState("sort_asc") Then
                dv.Sort = ViewState("SortExpression") & " asc"
            Else
                dv.Sort = ViewState("SortExpression") & " desc"
            End If

            dg.DataSource = dv
            dg.DataBind()
        Catch ex As Exception
        Finally
            OdbcConnection.Close()
        End Try

        Return dt
    End Function

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
        loadInvoiceDetails(item_list)
    End Sub

    Private Sub item_list_PageIndexChanged(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles item_list.PageIndexChanged
        item_list.CurrentPageIndex = e.NewPageIndex
        loadInvoiceDetails(item_list)
    End Sub

    Function TPSDateToString(ByVal tpsDate As String) As String
        Dim sDate As String

        If tpsDate = "" Or tpsDate = "0" Then
            Return ""
        End If

        sDate = tpsDate.Substring(3, 2) & "/" & tpsDate.Substring(5, 2) & "/" & tpsDate.Substring(1, 2)
        Return sDate
    End Function

    Private Sub export_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles export_link.Click
        'ExportToExcel()
        ExportToCSV()
    End Sub

    Private Sub ExportToExcel()
        Response.Clear()
        Response.Charset = ""
        Response.ContentType = "application/vnd.ms-excel"
        'Response.ContentType = "application/vnd.xls"
        'Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        Response.AddHeader("Content-Disposition", "attachment; filename=Invoice_" & nInv & ".xls")

        Dim sw As New System.IO.StringWriter()
        Dim hw As New System.Web.UI.HtmlTextWriter(sw)

        Dim dg As New DataGrid()
        dg = item_list

        dg.GridLines = GridLines.None
        dg.HeaderStyle.Font.Bold = True
        dg.FooterStyle.Font.Bold = True

        dg.AllowPaging = False
        dg.AllowSorting = False

        loadInvoiceDetails(dg)

        Dim frm As HtmlForm = New HtmlForm()
        dg.Parent.Controls.Add(frm)
        frm.Attributes("runat") = "server"
        frm.Controls.Add(dg)

        frm.RenderControl(hw)

        Response.Write(sw.ToString)
        Response.End()
    End Sub

    Protected Sub ExportToCSV()
        Response.Clear()
        Response.Charset = ""
        Response.Buffer = True

        Response.ContentType = "application/text"
        Response.AddHeader("Content-Disposition", "attachment; filename=Invoice_" & nInv & ".csv")

        Dim sw As New System.IO.StringWriter()
        Dim hw As New System.Web.UI.HtmlTextWriter(sw)

        Dim dg As New DataGrid()
        dg = item_list

        dg.GridLines = GridLines.None
        dg.HeaderStyle.Font.Bold = True
        dg.FooterStyle.Font.Bold = True

        dg.AllowPaging = False
        dg.AllowSorting = False

        loadInvoiceDetails(dg)

        Response.Output.Write(sCSV.ToString())
        Response.Flush()
        Response.End()
    End Sub

    Protected Sub btnCopy_Click(sender As Object, e As System.EventArgs) Handles btnCopy.Click
        Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()
        Try
            tpsData.SetLibList(Session("LibList").ToString())
        Catch
        End Try

        Dim nOrder As Decimal = Session("OrderNo")

        tpsData.CopyInvoiceToShoppingCart(Integer.Parse(sCust), nOrder, Integer.Parse(nInv))

        Response.Redirect("ShoppingCart.aspx")
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
    End Sub

    Protected Sub export_pdf_link_Click(sender As Object, e As System.EventArgs) Handles exportpdf_link.Click
        ExportToPDF()
    End Sub

    Private Sub ExportToPDF()
        ' get the html string for the report
        Dim htmlStringWriter As StringWriter = New StringWriter()
        Server.Execute("invoice_pdf.aspx?order=" & nInv, htmlStringWriter)
        Dim htmlCodeToConvert As String = htmlStringWriter.GetStringBuilder().ToString()
        htmlStringWriter.Close()

        ' initialize the PdfConvert object
        Dim pdfConverter As PdfConverter = New PdfConverter()
        pdfConverter.PdfDocumentOptions.PdfPageSize = PdfPageSize.A4
        pdfConverter.PdfDocumentOptions.PdfCompressionLevel = PdfCompressionLevel.Normal
        pdfConverter.PdfDocumentOptions.PdfPageOrientation = PDFPageOrientation.Portrait
        pdfConverter.PdfDocumentOptions.AutoSizePdfPage = True
        pdfConverter.PdfDocumentOptions.ShowHeader = False
        pdfConverter.PdfDocumentOptions.ShowFooter = False
        ' set the demo license key
        pdfConverter.LicenseKey = ConfigurationManager.AppSettings("WinnovativeLicenseKey").ToString()

        ' get the base url for string conversion which is the url from where the html code was retrieved
        ' the base url is a hint for the converter to find the external CSS and images referenced by relative URLs
        Dim thisPageURL As String = HttpContext.Current.Request.Url.AbsoluteUri
        'Dim baseUrl As String = thisPageURL.Substring(0, thisPageURL.LastIndexOf("/"c)) + "/"
        Dim baseUrl As String = thisPageURL

        ' get the pdf bytes from html string
        'Dim downloadBytes As Byte() = pdfConverter.GetPdfBytesFromHtmlString(htmlCodeToConvert)
        Dim downloadBytes As Byte() = pdfConverter.GetPdfBytesFromHtmlString(htmlCodeToConvert, baseUrl)

        ' send the PDF document as a response to the browser for download
        Dim Response As System.Web.HttpResponse = System.Web.HttpContext.Current.Response

        Response.Clear()
        Response.AddHeader("Content-Type", "binary/octet-stream")
        Response.AddHeader("Content-Disposition", "attachment; filename=Invoice_" & nInv & ".pdf; size=" & downloadBytes.Length.ToString())
        Response.Flush()
        Response.BinaryWrite(downloadBytes)
        Response.Flush()
        Response.End()
    End Sub

    Protected Sub item_list_ItemCommand(source As Object, e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles item_list.ItemCommand
        ExportCompliancePDF(e.CommandArgument)
    End Sub

    Private Sub ExportCompliancePDF(ByVal sItemArgs As String)
        Try
            Dim sArgs() As String = sItemArgs.Split("|")

            Dim usrDetails As UserDetail
            usrDetails = Session("UserDetails")

            Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()
            Dim company As Company = tpsData.GetCompany()
            Dim custInfo As Customer = tpsData.GetCustomer(usrDetails.TPSCustomerNumber)

            Dim sSoldTitle As String = "Sold To:"
            Dim sCustTitle As String = custInfo.CustomerName + vbCrLf + custInfo.Address + vbCrLf
            If custInfo.Address2.ToString.Trim > "" Then
                sCustTitle += custInfo.Address2 + vbCrLf
            End If
            sCustTitle += custInfo.City + ", " + custInfo.State + " " + custInfo.Zip

            Dim sCompanyTitle As String = "DSCSA Transaction Data Report" + vbCrLf + company.CompanyName + vbCrLf + company.Address1
            If company.Address2.Trim > "" Then
                sCompanyTitle += ", " + company.Address2
            End If
            sCompanyTitle += vbCrLf + company.City + ", " + company.State + " " + company.Zip + vbCrLf + company.Phone

            ' get the html string for the report
            Dim htmlStringWriter As StringWriter = New StringWriter()
            If ConfigurationManager.AppSettings("LWD") = "yes" Then
                Server.Execute("rpts/rpt_rx_compliance_pdf.aspx?itemno=" + sArgs(0) + "&invno=" + header_invoice_no.Text + "&lineno=" + sArgs(3), htmlStringWriter)
            Else
                Server.Execute("rpts/rpt_rx_pedigree_pdf.aspx?itemno=" + sArgs(0) + "&invno=" + header_invoice_no.Text + "&lineno=" + sArgs(3), htmlStringWriter)
            End If
            Dim htmlCodeToConvert As String = htmlStringWriter.GetStringBuilder().ToString()
            htmlStringWriter.Close()

            ' initialize the PdfConvert object
            Dim pdfConverter As PdfConverter = New PdfConverter()
            pdfConverter.PdfDocumentOptions.PdfPageSize = PdfPageSize.A4

            pdfConverter.PdfDocumentOptions.PdfCompressionLevel = PdfCompressionLevel.Normal
            pdfConverter.PdfDocumentOptions.PdfPageOrientation = PDFPageOrientation.Portrait
            pdfConverter.PdfDocumentOptions.FitHeight = False
            pdfConverter.PdfDocumentOptions.FitWidth = True
            pdfConverter.PdfDocumentOptions.StretchToFit = True

            pdfConverter.AvoidImageBreak = True
            pdfConverter.AvoidTextBreak = True

            'pdfConverter.PdfDocumentOptions.BottomMargin
            pdfConverter.PdfDocumentOptions.ShowHeader = True
            pdfConverter.PdfDocumentOptions.ShowFooter = True

            pdfConverter.PdfFooterOptions.DrawFooterLine = False
            pdfConverter.PdfFooterOptions.ShowPageNumber = True
            pdfConverter.PdfFooterOptions.PageNumberTextFontSize = 10
            pdfConverter.PdfFooterOptions.FooterBackColor = Drawing.Color.White
            pdfConverter.PdfFooterOptions.FooterText = "   " + FormatDateTime(Now, DateFormat.ShortDate)
            pdfConverter.PdfFooterOptions.FooterTextFontSize = 10

            pdfConverter.PdfHeaderOptions.DrawHeaderLine = False
            pdfConverter.PdfHeaderOptions.HeaderBackColor = Drawing.Color.White
            pdfConverter.PdfHeaderOptions.HeaderText = vbCrLf + sCompanyTitle
            pdfConverter.PdfHeaderOptions.HeaderTextFontType = PdfFontType.Helvetica
            pdfConverter.PdfHeaderOptions.HeaderTextFontSize = 11
            pdfConverter.PdfHeaderOptions.HeaderTextFontStyle = Drawing.FontStyle.Bold
            pdfConverter.PdfHeaderOptions.HeaderTextYLocation = 5
            If ConfigurationManager.AppSettings("LWD") = "yes" Then
                pdfConverter.PdfHeaderOptions.HeaderHeight = 190
            Else
                pdfConverter.PdfHeaderOptions.HeaderHeight = 170
            End If
            pdfConverter.PdfHeaderOptions.HeaderTextAlign = HorizontalTextAlign.Center

            Try
                Dim headerImg As ImageArea = New ImageArea(10, 10, 90, Server.MapPath("~/images/reports/logo.svg"))
                pdfConverter.PdfHeaderOptions.ImageArea = headerImg
            Catch
            End Try

            Dim font As Drawing.Font = New Drawing.Font(New Drawing.FontFamily("Helvetica"), 11, Drawing.GraphicsUnit.Point)

            Dim nTop As Integer = 90
            If ConfigurationManager.AppSettings("LWD") = "yes" Then
                nTop = 110
            End If

            Dim invTitleText As TextArea = New TextArea(290, nTop, 60, "Item #:" + vbCrLf + "NDC:" + vbCrLf + "Size / Form:" + vbCrLf + "Desc:", font)
            invTitleText.TextAlign = HorizontalTextAlign.Right
            pdfConverter.PdfHeaderOptions.AddTextArea(invTitleText)

            Dim invDataText As TextArea = New TextArea(357, nTop, sArgs(0) + vbCrLf + sArgs(1) + vbCrLf + sArgs(4).Trim + " / " + sArgs(5) + vbCrLf + sArgs(2), font)
            pdfConverter.PdfHeaderOptions.AddTextArea(invDataText)

            Dim soldText As TextArea = New TextArea(15, nTop, sSoldTitle, font)
            pdfConverter.PdfHeaderOptions.AddTextArea(soldText)

            Dim custText As TextArea = New TextArea(65, nTop, sCustTitle, font)
            pdfConverter.PdfHeaderOptions.AddTextArea(custText)

            ' set the demo license key
            pdfConverter.LicenseKey = ConfigurationManager.AppSettings("WinnovativeLicenseKey").ToString()

            ' get the base url for string conversion which is the url from where the html code was retrieved
            ' the base url is a hint for the converter to find the external CSS and images referenced by relative URLs
            Dim thisPageURL As String = HttpContext.Current.Request.Url.AbsoluteUri
            Dim baseUrl As String = thisPageURL.Substring(0, thisPageURL.LastIndexOf("/"c)) + "/"

            ' get the pdf bytes from html string
            pdfConverter.NavigationTimeout = 600
            Dim downloadBytes As Byte()

            Try
                downloadBytes = pdfConverter.GetPdfBytesFromHtmlString(htmlCodeToConvert, baseUrl)
            Catch ex As Exception
            End Try

            'Dim downloadBytes() As Byte = pdfConverter.GetPdfFromUrlBytes(Server.MapPath("rpt_orderguide_pdf.aspx"))

            ' send the PDF document as a response to the browser for download
            Dim Response As System.Web.HttpResponse = System.Web.HttpContext.Current.Response

            Response.Clear()
            Response.AddHeader("Content-Type", "binary/octet-stream")
            Response.AddHeader("Content-Disposition", "attachment; filename=Invoice_RX_Compliance_" & sArgs(0) & ".pdf; size=" & downloadBytes.Length.ToString())
            Response.Flush()
            Response.BinaryWrite(downloadBytes)
            Response.Flush()
            Response.End()
        Catch ex As Exception
        End Try
    End Sub

End Class

