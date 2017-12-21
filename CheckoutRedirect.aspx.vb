Imports System.IO
Imports System
Imports System.Collections
Imports System.Data
Imports System.Configuration
Imports System.Data.Odbc
Imports Turningpoint.Shared
Imports Turningpoint.Data
Imports System.Collections.Generic

Partial Class OrderList
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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim nOrder As String = Request.QueryString("orderno")

        If ConfigurationManager.AppSettings("NewOrderEdit") = "yes" Then
            Response.Redirect("OrderListSubmit.aspx?orderno=" & nOrder)
        Else
            Response.Redirect("Checkout.aspx?orderno=" & nOrder)
        End If
    End Sub

End Class
