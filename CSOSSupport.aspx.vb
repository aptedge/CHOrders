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
    End Sub


End Class
