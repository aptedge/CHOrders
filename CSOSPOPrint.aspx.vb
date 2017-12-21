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

Partial Class OrderPrint
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

    Public VendorNo As String
    Public VendorName As String
    Public PONo As String
    Public PODate As String
    Public POTotal As String
    Public DEANumber As String
    Public sCust As String

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Page.MaintainScrollPositionOnPostBack = True

        Dim usr As UserDetail = Session("UserDetails")
        Try
            sCust = usr.TPSCustomerNumber
        Catch
        End Try

        If sCust = "" Then
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "myCloseScript", "window.close()", True)
            Exit Sub
        End If

        PONo = Request.QueryString("pono")

        LoadView()
    End Sub

    Private Sub LoadView()
        Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()

        Dim poHdr As POHeader = tpsData.GetPOHeader(PONo)

        VendorNo = poHdr.VendorNo
        VendorName = poHdr.VendorName
        DEANumber = poHdr.DEABlankNo
        PODate = poHdr.Date
        POTotal = FormatNumber(poHdr.Amount, 2)

        loadPODetails()

        Try
        Catch ex As Exception
            Utils.traceApp(Server, ex.Message + vbCrLf + ex.StackTrace)
        End Try
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
                                   " WHERE PODNUM = " & PONo & " ORDER BY ITDESC"

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

            item_list.DataSource = dv
            item_list.DataBind()
        Catch ex As Exception
        Finally
            OdbcConnection.Close()
        End Try
    End Sub

End Class

