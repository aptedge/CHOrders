Imports System.IO
Imports System
Imports System.Collections
Imports System.Data
Imports System.Configuration
Imports System.Data.Odbc
Imports TurningPoint.Shared
Imports TurningPoint.Data
Imports System.Collections.Generic

Partial Class Messages
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
        Try
            page_header.setHeader("Messages")

            Dim usrDetails As UserDetail = Nothing

            If Not Session("UserDetails") Is Nothing Then
                usrDetails = Session("UserDetails")
            Else
                Response.Redirect("login.aspx")
            End If

            Dim sColor As String = "white"
            Try
                sColor = ConfigurationManager.AppSettings("PageBackColor").ToString()
            Catch
                sColor = "white"
            End Try
            body.Style.Add("background-color", sColor)

            If Not Page.IsPostBack Then
                LoadView()
            End If
        Catch
        End Try
    End Sub

    Sub LoadView()
        Try
            Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()

            Dim dt As DataTable = New DataTable

            dt.Columns.Add("MessageId", GetType(String))
            dt.Columns.Add("MessageDate", GetType(String))
            dt.Columns.Add("ExpDate", GetType(String))
            dt.Columns.Add("Icon", GetType(String))
            dt.Columns.Add("Text1", GetType(String))
            dt.Columns.Add("Text2", GetType(String))
            dt.Columns.Add("Text3", GetType(String))
            dt.Columns.Add("Text4", GetType(String))
            dt.Columns.Add("Text5", GetType(String))
            dt.Columns.Add("Link", GetType(String))
            dt.Columns.Add("ShowLink", GetType(Integer))
            dt.Columns.Add("ShowNoLink", GetType(Integer))
            dt.Columns.Add("ShowHide", GetType(Integer))
            dt.Columns.Add("ShowUnhide", GetType(Integer))

            Dim usrDetails As UserDetail = Session("UserDetails")
            Dim MessageList As List(Of MessageDetail) = tpsData.GetMessages(usrDetails.TPSCustomerNumber)

            For Each msg As MessageDetail In MessageList
                If Not show_hidden.Checked Then
                    If msg.Status = "H" Then
                        Continue For
                    End If
                End If

                Dim sMessageDate As String = ""
                Try
                    sMessageDate = FormatDateTime(msg.MessageDate, DateFormat.ShortDate)
                Catch
                End Try

                Dim sExpDate As String = ""
                Try
                    sExpDate = FormatDateTime(msg.ExpiresDate, DateFormat.ShortDate)
                Catch
                End Try

                Dim sIcon As String = ""
                If msg.Type = "MS" Then
                    sIcon = "/images/info.png"
                ElseIf msg.Type = "CR" Then
                    sIcon = "/images/critical.png"
                ElseIf msg.Type = "WN" Then
                    sIcon = "/images/warning.png"
                Else
                    sIcon = "images/info.png"
                End If

                Dim bShowLink As Integer = 0
                Dim bShowNoLink As Integer = 0
                If msg.Link = "" Then
                    bShowNoLink = 1
                Else
                    bShowLink = 1
                End If

                Dim bShowHide As Integer = 0
                Dim bShowUnhide As Integer = 0
                If msg.Status = "H" Then
                    bShowUnhide = 1
                Else
                    bShowHide = 1
                End If

                dt.Rows.Add(msg.MessageId, sMessageDate, sExpDate, sIcon, msg.Text1, msg.Text2, msg.Text3, msg.Text4, msg.Text5, msg.Link, bShowLink, bShowNoLink, bShowHide, bShowUnhide)
            Next

            Dim dv As DataView = New DataView(dt)

            item_list.DataSource = dv
            item_list.DataBind()
        Catch ex As Exception
            Utils.traceApp(Server, ex.Message & vbCrLf & ex.StackTrace)
        End Try
    End Sub

    Protected Sub item_list_ItemCommand(source As Object, e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles item_list.ItemCommand
        If e.CommandName = "hide" Then
            UpdateMessageStatus(e.CommandArgument, "H")
        ElseIf e.CommandName = "unhide" Then
            UpdateMessageStatus(e.CommandArgument, "")
        End If
    End Sub

    Private Sub UpdateMessageStatus(ByVal sMessageId As String, ByVal sStatus As String)
        Try
            Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()

            Dim usrDetails As UserDetail = Session("UserDetails")
            tpsData.UpdateMessageStatus(usrDetails.TPSCustomerNumber, sMessageId, sStatus)

            LoadView()
        Catch ex As Exception
            Utils.traceApp(Server, ex.Message & vbCrLf & ex.StackTrace)
        End Try
    End Sub

    Protected Sub show_hidden_CheckedChanged(sender As Object, e As EventArgs) Handles show_hidden.CheckedChanged
        LoadView()
    End Sub
End Class

