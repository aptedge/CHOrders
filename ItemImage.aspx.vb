Imports System.IO
Imports System
Imports System.Collections
Imports System.Data
Imports System.Configuration
Imports System.Data.Odbc
Imports System.Drawing
Imports Turningpoint.Shared

Partial Class ItemImage
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
        Dim sFileName As String = ""

        Dim sItemNo As String = Request.QueryString("item").ToString.Trim
        Dim sUpcRetail As String = Request.QueryString("upc_r").ToString.Trim
        Dim sUpcSell As String = Request.QueryString("upc_s").ToString.Trim

        If Not sItemNo Is Nothing Then
            sFileName = "images/items/" & sItemNo & ".jpg"
        End If

        If Not File.Exists(Server.MapPath(sFileName)) Then
            Dim sItem As String = "000000" & sItemNo
            sItem = Right(sItem, 6)
            sFileName = "images/items/" & sItem & ".jpg"
        End If

        If Not File.Exists(Server.MapPath(sFileName)) Then
            sFileName = "images/items/" & sUpcRetail & ".jpg"
        End If

        If Not File.Exists(Server.MapPath(sFileName)) Then
            Dim sUpc As String = "000000000000" & sUpcRetail
            sUpc = Right(sUpc, 12)
            sFileName = "images/items/" & sUpc & ".jpg"
        End If

        If Not File.Exists(Server.MapPath(sFileName)) Then
            sFileName = "images/items/" & sUpcSell & ".jpg"
        End If

        If Not File.Exists(Server.MapPath(sFileName)) Then
            Dim sUpc As String = "000000000000" & sUpcSell
            sUpc = Right(sUpc, 12)
            sFileName = "images/items/" & sUpc & ".jpg"
        End If

        If Not File.Exists(Server.MapPath(sFileName)) Then
            sFileName = "images/default_item.jpg"
        End If

        Dim ms As New IO.MemoryStream
        Dim bmp As New Bitmap(Server.MapPath(sFileName))

        bmp.SetResolution(256, 256)
        bmp.Save(ms, Drawing.Imaging.ImageFormat.Jpeg)

        Response.ContentType = "image/JPEG"

        ms.WriteTo(Response.OutputStream)
    End Sub
End Class

