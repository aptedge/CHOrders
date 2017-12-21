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
Imports System.Net

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

        header_new.Visible = True
        page_header_tp.setHeader("PO Detail")

        If Not IsPostBack Then
            ViewState("SortExpression") = "PODSEQ"
            ViewState("sort_asc") = True
            Session("SortExpression") = ViewState("SortExpression")
            Session("sort_asc") = True

            po.Focus()
        End If
    End Sub

    Public Sub LoadPO()
        message.Text = "&nbsp;"

        nPO = po.Text.Trim

        If nPO = "" Then
            Exit Sub
        End If

        Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()
        Dim poHeader As POHeader = tpsData.GetPOHeader(nPO)

        If poHeader.PONo = "" Then
            message.Text = "PO " + po.Text + " not found"
            ClearControls()
            Exit Sub
        End If

        header_po_date.Text = poHeader.Date
        header_vendor.Text = poHeader.VendorNo + " - " + poHeader.VendorName
        header_dea_no.Text = poHeader.DEABlankNo
        header_po_lines.Text = poHeader.Lines
        header_po_amt.Text = FormatCurrency(poHeader.Amount, 2)

        loadPODetails()

        load850Data()
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

    Private Sub load850Data()
        edi850_data.Visible = True

        Dim dt As DataTable = New DataTable
        Dim s850 As String = ""

        Dim OdbcConnection As New OdbcConnection(ConfigurationManager.ConnectionStrings("TurningpointSystem").ConnectionString)

        Try
            OdbcConnection.Open()
            oCmd = New System.Data.Odbc.OdbcCommand
            oCmd.Connection = OdbcConnection

            oCmd.CommandText = "SELECT * from FPCSOS850 WHERE CSOSPO = " & po.Text & " ORDER BY CSOSLN "

            Dim DA As System.Data.Odbc.OdbcDataAdapter = New System.Data.Odbc.OdbcDataAdapter(oCmd)
            DA.Fill(dt)

            For Each dr As DataRow In dt.Rows
                s850 += dr("CSOS850").ToString.Trim
            Next

            edi850_data.Text = s850
        Catch ex As Exception
        Finally
            OdbcConnection.Close()
        End Try
    End Sub

    Public Sub Write850()
        Try
            Dim fName As String = po.Text.Trim & Now.ToString("_yyyyMMdd_HHmmss_") & "EDI850.edi"
            Dim fFullName As String = Server.MapPath("EDI850") + "/" & fName
            Dim fEDI850 As System.IO.FileStream
            Dim fWriter As System.IO.StreamWriter

            Try
                fEDI850 = New System.IO.FileStream(fFullName, IO.FileMode.Create)
                fWriter = New System.IO.StreamWriter(fEDI850)
            Catch ex As Exception
                Exit Sub
            End Try

            fWriter.Write(edi850_data.Text.Trim)

            Try
                fWriter.Close()
                fEDI850.Close()
            Catch ex As Exception
            End Try

        Catch ex As Exception
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

    Protected Sub btn_load_Click(sender As Object, e As EventArgs) Handles btn_load.Click
        LoadPO()
    End Sub

    Protected Sub btn_resend_Click(sender As Object, e As EventArgs) Handles btn_resend.Click
        If edi850_data.Text.TrimEnd = "" Then
            Exit Sub
        End If

        Dim fFullName As String = ""
        Dim fName As String = ""

        Write850()
        message.Text = "EDI850 test file created and sent to Express 222 dev ftp"
    End Sub

    Sub ClearControls()
        po.Text = ""

        header_po_date.Text = ""
        header_vendor.Text = ""
        header_dea_no.Text = ""
        header_po_lines.Text = ""
        header_po_amt.Text = ""

        edi850_data.Text = ""
        edi850_data.Visible = False

        item_list.DataSource = Nothing
        item_list.DataBind()

        po.Focus()
    End Sub

    Protected Sub btn_clear_Click(sender As Object, e As EventArgs) Handles btn_clear.Click
        ClearControls()
    End Sub
End Class

