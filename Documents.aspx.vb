Imports System.IO
Imports System
Imports System.Collections
Imports System.Collections.Generic
Imports System.Data
Imports System.Configuration
Imports System.Data.Odbc
Imports Turningpoint.Shared
Imports Turningpoint.Data

Partial Class Documents
    Inherits System.Web.UI.Page
    Protected WithEvents OdbcConnection As New System.Data.Odbc.OdbcConnection(ConfigurationManager.ConnectionStrings("TurningpointSystem").ConnectionString)
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

    Public lbl_title As String = ""

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not IsPostBack Then
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

            If ConfigurationManager.AppSettings("WelcomePage").ToString() = "welcome2.aspx" Then
                header.Visible = True
            Else
                header_new.Visible = True
            End If

            Try
                ViewState("docview") = Request.QueryString("type")
            Catch
                ViewState("docview") = "policy"
            End Try

            If ViewState("docview") = "policy" Then
                lbl_title = "Policies & Forms"
                page_header_tp.setHeader("Documents - Policies & Forms")
            ElseIf ViewState("docview") = "news" Then
                lbl_title = "Newsletters"
                page_header_tp.setHeader("Documents - Newsletters")
            ElseIf ViewState("docview") = "recall" Then
                lbl_title = "Recalls"
                page_header_tp.setHeader("Documents - Recalls")
            ElseIf ViewState("docview") = "item" Then
                lbl_title = "Item Changes"
                page_header_tp.setHeader("Documents - Item Changes")
            ElseIf ViewState("docview") = "832" Then
                lbl_title = "Price Catalog"
                page_header_tp.setHeader("Documents - Price Catalog")
            End If

            ViewState("SortExpression") = "NAME"
            ViewState("sort_asc") = True

            If ViewState("docview") = "832" Then
                LoadPriceCatalog()
            Else
                LoadView()
            End If
        End If
    End Sub

    Private Sub LoadView()
        Dim folderPath As String = ""

        If ViewState("docview") = "policy" Then
            folderPath = Server.MapPath("PolicyDocuments")
        ElseIf ViewState("docview") = "news" Then
            folderPath = Server.MapPath("Newsletters")
        ElseIf ViewState("docview") = "recall" Then
            folderPath = Server.MapPath("Recalls")
        ElseIf ViewState("docview") = "item" Then
            folderPath = Server.MapPath("ItemChanges")
        End If

        Dim files As String() = Directory.GetFiles(folderPath, "*.*")

        Dim di As DirectoryInfo = New DirectoryInfo(folderPath)
        Dim rgFiles As FileInfo() = di.GetFiles("*.*")

        Dim dt As DataTable = New DataTable()

        dt.Columns.Add("NAME")

        For Each fi As FileInfo In rgFiles
            If Not fi.Name.ToLower.IndexOf("thumbs.db") = -1 Then
                Continue For
            End If
            dt.Rows.Add(fi.Name)
        Next

        Dim dv As DataView = New DataView(dt)

        If ViewState("sort_asc") Then
            dv.Sort = ViewState("SortExpression") & " asc"
        Else
            dv.Sort = ViewState("SortExpression") & " desc"
        End If

        item_list.DataSource = dv
        item_list.DataBind()
    End Sub

    Private Sub LoadPriceCatalog()
        Try
            Dim sPriceCatalogName As String = GetPriceCatalogName()

            Dim dt As DataTable = New DataTable()
            dt.Columns.Add("NAME")

            If sPriceCatalogName = "" Then
                message.Text = "You are not setup for this feature.  Please contact Customer Support for more information."
            Else
                dt.Rows.Add(sPriceCatalogName)
            End If

            Dim dv As DataView = New DataView(dt)

            If ViewState("sort_asc") Then
                dv.Sort = ViewState("SortExpression") & " asc"
            Else
                dv.Sort = ViewState("SortExpression") & " desc"
            End If

            item_list.DataSource = dv
            item_list.DataBind()
        Catch
        End Try
    End Sub

    Private Function GetPriceCatalogName() As String
        Dim usrDetails As UserDetail = Session("UserDetails")
        Dim sFilename As String = ""
        Dim sType As String = ""

        Try
            Dim oCmd As System.Data.Odbc.OdbcCommand
            Dim oRdr As System.Data.Odbc.OdbcDataReader

            OdbcConnection.Open()
            oCmd = New System.Data.Odbc.OdbcCommand
            oCmd.Connection = OdbcConnection

            oCmd.CommandText = "select * from FPEDIMAS where EDDOC = 832 AND EDCUST = " & usrDetails.TPSCustomerNumber

            oRdr = oCmd.ExecuteReader()

            If oRdr.Read() Then
                sType = oRdr("EDRXNM").ToString.Trim
            End If

            If sType > "" Then
                oCmd = New System.Data.Odbc.OdbcCommand
                oCmd.Connection = OdbcConnection

                oCmd.CommandText = "select * from FPSYGREF where GREFCD = 'PC' AND GREFKY = '" & sType & "'"

                oRdr = oCmd.ExecuteReader()

                If oRdr.Read() Then
                    Dim s As String = oRdr("GREFDT").ToString.Trim
                    Dim split As String() = s.Split(" ")

                    sFilename = split(split.Length - 1)
                    sFilename = sFilename.Replace("1234", usrDetails.TPSCustomerNumber)
                End If
            End If
        Catch ex As Exception
        Finally
            OdbcConnection.Close()
        End Try

        Return sFilename
    End Function

    Private Sub list_SortCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridSortCommandEventArgs) Handles item_list.SortCommand
        If ViewState("SortExpression") = e.SortExpression Then
            ViewState("sort_asc") = Not ViewState("sort_asc")
        Else
            ViewState("SortExpression") = e.SortExpression
            ViewState("sort_asc") = True
        End If

        item_list.CurrentPageIndex = 0

        LoadView()
    End Sub

    Protected Sub item_list_ItemCommand(source As Object, e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles item_list.ItemCommand
        If e.CommandName = "download" Then
            DownloadFile(e.CommandArgument)
        End If
    End Sub

    Protected Sub DownloadFile(fname As String)
        Try
            ' Get the physical Path of the file(test.doc)
            Dim usrDetails As UserDetail = Session("UserDetails")
            Dim filepath As String = ""

            If ViewState("docview") = "policy" Then
                filepath = Server.MapPath("PolicyDocuments") + "/" + fname
            ElseIf ViewState("docview") = "news" Then
                filepath = Server.MapPath("Newsletters") + "/" + fname
            ElseIf ViewState("docview") = "recall" Then
                filepath = Server.MapPath("Recalls") + "/" + fname
            ElseIf ViewState("docview") = "item" Then
                filepath = Server.MapPath("ItemChanges") + "/" + fname
            ElseIf ViewState("docview") = "832" Then
                filepath = ConfigurationManager.AppSettings("PriceCatalogPath") + usrDetails.TPSCustomerNumber + "/" + fname
            End If

            Dim file As FileInfo = New FileInfo(filepath)

            If file.Exists Then
                ' Clear the content of the response
                Response.ClearContent()

                ' Add the file name and attachment, which will force the open/cance/save dialog to show, to the header
                Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name)

                ' Add the file size into the response header
                Response.AddHeader("Content-Length", file.Length.ToString())

                ' Set the ContentType
                Response.ContentType = ReturnExtension(file.Extension.ToLower())

                ' Write the file into the response (TransmitFile is for ASP.NET 2.0. In ASP.NET 1.1 you have to use WriteFile instead)
                Response.WriteFile(file.FullName)

                ' End the response
                Response.End()
            End If
        Catch
        End Try
    End Sub

    Private Function ReturnExtension(fileExtension As String) As String
        Select Case fileExtension
            Case ".htm"
            Case ".html"
            Case ".log"
                Return "text/HTML"
            Case ""
            Case "."
            Case ".832"
            Case ".txt"
                Return "text/plain"
            Case ".doc"
                Return "application/ms-word"
            Case ".tiff"
            Case ".tif"
                Return "image/tiff"
            Case ".asf"
                Return "video/x-ms-asf"
            Case ".avi"
                Return "video/avi"
            Case ".zip"
                Return "application/zip"
            Case ".xls"
            Case ".csv"
                Return "application/vnd.ms-excel"
            Case ".gif"
                Return "image/gif"
            Case ".jpg"
            Case "jpeg"
                Return "image/jpeg"
            Case ".bmp"
                Return "image/bmp"
            Case ".png"
                Return "image/png"
            Case ".wav"
                Return "audio/wav"
            Case ".mp3"
                Return "audio/mpeg3"
            Case ".mpg"
            Case "mpeg"
                Return "video/mpeg"
            Case ".rtf"
                Return "application/rtf"
            Case ".asp"
                Return "text/asp"
            Case ".pdf"
                Return "application/pdf"
            Case ".fdf"
                Return "application/vnd.fdf"
            Case ".ppt"
                Return "application/mspowerpoint"
            Case ".dwg"
                Return "image/vnd.dwg"
            Case ".msg"
                Return "application/msoutlook"
            Case ".xml"
            Case ".sdxl"
                Return "application/xml"
            Case ".xdp"
                Return "application/vnd.adobe.xdp+xml"
            Case Else
                Return "application/octet-stream"
        End Select

        Return "application/octet-stream"
    End Function

End Class
