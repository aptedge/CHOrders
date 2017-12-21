Imports System.Threading
Imports System.Globalization
Imports System.Configuration
Imports System.Data.Odbc
Imports Turningpoint.Shared
Imports Turningpoint.Data
Imports System.Collections
Imports System.Collections.Generic
Imports System.Data

Partial Class CreditDetail
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
    Dim nCredit As String
    Dim sDate As String
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

        If ConfigurationManager.AppSettings("WelcomePage").ToString() = "welcome2.aspx" Then
            header.Visible = True
        Else
            header_new.Visible = True
            page_header_tp.setHeader("Credit Detail")
        End If

        nCredit = Request.QueryString("no")

        sDate = TPSDateToString(Request.QueryString("dt"))

        header_credit_no.Text = nCredit
        header_credit_date.Text = sDate

        If Not IsPostBack Then
            If ConfigurationManager.AppSettings("RX") = "yes" Then
                item_list.Columns(2).Visible = False
                item_list.Columns(3).Visible = False
                item_list.Columns(8).Visible = False
            Else
                item_list.Columns(4).Visible = False
            End If

            ViewState("SortExpression") = "ITDESC"
            ViewState("sort_asc") = False

            loadCreditDetails(item_list)
        End If
    End Sub

    Dim fTotal As Double = 0
    Dim fItems As Integer = 0

    Public Function loadCreditDetails(ByRef dg As DataGrid) As DataTable
        Dim dt As DataTable = New DataTable

        Dim OdbcConnection As New OdbcConnection(ConfigurationManager.ConnectionStrings("TurningpointSystem").ConnectionString)

        Try
            fTotal = 0
            fItems = 0

            OdbcConnection.Open()
            oCmd = New System.Data.Odbc.OdbcCommand
            oCmd.Connection = OdbcConnection

            oCmd.CommandText = "SELECT distinct A.CRITEM, A.CRSEQ, A.CRUNPR, A.CRQTSR, B.ITDESC, B.ITSIZE, B.ITMUPC, '' as UPC, B.ITNDCI, '' as NDCI, B.ITMNDC, '' as NDC, B.ITINVT, '' as ITEM, 0.0 as EXT, ITCSRP" & _
                               " FROM FPCRDDTL A LEFT JOIN FPITMMAS B ON A.CRITEM = B.ITMNUM " & _
                               " LEFT JOIN FPPDAITC C ON A.CRITEM = C.ITCITM AND C.ITCCUS = A.CRCUST " & _
                               " WHERE A.CRARNO = " & nCredit

            Dim DA As System.Data.Odbc.OdbcDataAdapter = New System.Data.Odbc.OdbcDataAdapter(oCmd)

            DA.Fill(dt)

            sCSV = ""

            For k As Integer = 0 To dg.Columns.Count - 1
                If dg.Columns(k).Visible Then
                    sCSV += dg.Columns(k).HeaderText + ","c
                End If
            Next
            sCSV += vbCr & vbLf

            If dt.Rows.Count < item_list.PageSize Then
                item_list.AllowPaging = False
            Else
                item_list.AllowPaging = True
            End If

            For Each dr As DataRow In dt.Rows
                If dr("ITINVT").ToString().Trim() = "Z" Then
                    dr("ITEM") = dr("CRITEM")
                Else
                    dr("ITEM") = dr("CRITEM")
                End If
                dr("ITEM") = "000000" & dr("ITEM")
                dr("ITEM") = Right(dr("ITEM"), 6)

                dr("EXT") = Convert.ToDouble(dr("CRQTSR")) * Convert.ToDouble(dr("CRUNPR"))
                fTotal += dr("EXT")
                fItems += dr("CRQTSR")

                dr("UPC") = dr("ITMUPC").ToString
                dr("NDCI") = dr("ITNDCI").ToString
                'dr("UPC") = """" & dr("ITMUPC").ToString & """"
                Try
                    Dim sNDC As String = dr("ITMNDC").ToString
                    sNDC = Left(sNDC, 5) + "-" + sNDC.Substring(5, 4) + "-" + Right(sNDC, 2)
                    dr("ITMNDC") = sNDC
                Catch
                End Try

                sCSV += dr("ITEM").ToString + ","c
                sCSV += """" + dr("ITDESC").ToString.Trim() + """" + ","c
                If ConfigurationManager.AppSettings("RX") = "yes" Then
                    sCSV += dr("ITMNDC").ToString.Trim() + " *" + ","c
                Else
                    sCSV += dr("UPC").ToString.Trim() + " *" + ","c
                    sCSV += dr("NDCI").ToString.Trim() + " *" + ","c
                End If
                sCSV += dr("ITSIZE").ToString + ","c
                sCSV += dr("CRQTSR").ToString + ","c
                sCSV += dr("CRUNPR").ToString + ","c
                sCSV += dr("ITCSRP").ToString + ","c
                sCSV += dr("EXT").ToString + ","c
                sCSV += vbCr & vbLf
            Next
            header_credit_amt.Text = FormatCurrency(fTotal, 2)

            sCSV = "Credit No, Credit Date, Amount" + vbCrLf + header_credit_no.Text + "," + header_credit_date.Text + "," + header_credit_amt.Text.Replace(",", "") + vbCrLf + vbCrLf + sCSV

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
        item_list.CurrentPageIndex = 0
        loadCreditDetails(item_list)
    End Sub

    Private Sub item_list_PageIndexChanged(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles item_list.PageIndexChanged
        item_list.CurrentPageIndex = e.NewPageIndex
        loadCreditDetails(item_list)
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
        Response.AddHeader("Content-Disposition", "attachment; filename=Credit_" & nCredit & ".xls")

        Dim sw As New System.IO.StringWriter()
        Dim hw As New System.Web.UI.HtmlTextWriter(sw)

        Dim dg As New DataGrid()
        dg = item_list

        dg.GridLines = GridLines.None
        dg.HeaderStyle.Font.Bold = True
        dg.FooterStyle.Font.Bold = True

        dg.AllowPaging = False
        dg.AllowSorting = False

        loadCreditDetails(dg)

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
        Response.AddHeader("Content-Disposition", "attachment; filename=Credit_" & nCredit & ".csv")

        Dim sw As New System.IO.StringWriter()
        Dim hw As New System.Web.UI.HtmlTextWriter(sw)

        Dim dg As New DataGrid()
        dg = item_list

        dg.GridLines = GridLines.None
        dg.HeaderStyle.Font.Bold = True
        dg.FooterStyle.Font.Bold = True

        dg.AllowPaging = False
        dg.AllowSorting = False

        loadCreditDetails(dg)

        Response.Output.Write(sCSV.ToString())
        Response.Flush()
        Response.End()
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
    End Sub

End Class

