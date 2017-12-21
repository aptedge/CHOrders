Imports System.Threading
Imports System.Globalization
Imports System.Configuration
Imports System.Data.Odbc
Imports Turningpoint.Shared
Imports Turningpoint.Data
Imports System.Collections
Imports System.Collections.Generic
Imports System.Data

Partial Class ContactUs2
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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Page.MaintainScrollPositionOnPostBack = True
        Dim sCust As String = ""

        'Dim usr As UserDetail = Session("UserDetails")
        'Try
        'sCust = usr.TPSCustomerNumber
        'Catch
        'End Try

        'If sCust = "" Then
        'Response.Redirect("login.aspx")
        'End If

        contact_company.Text = ConfigurationManager.AppSettings("ContactCompany")
        contact_address.Text = ConfigurationManager.AppSettings("ContactAddress")
        contact_city.Text = ConfigurationManager.AppSettings("ContactCity")
        contact_state.Text = ConfigurationManager.AppSettings("ContactState")
        contact_zip.Text = ConfigurationManager.AppSettings("ContactZip")
        contact_phone.Text = ConfigurationManager.AppSettings("ContactPhone")
        contact_fax.Text = ConfigurationManager.AppSettings("ContactFax")
        contact_email.InnerText = ConfigurationManager.AppSettings("ContactEmail")
        contact_email.HRef = "mailto: " & ConfigurationManager.AppSettings("ContactEmail")
    End Sub

End Class

