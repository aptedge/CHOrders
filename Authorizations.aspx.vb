Imports System.IO
Imports System
Imports System.Collections
Imports System.Collections.Generic
Imports System.Data
Imports System.Configuration
Imports System.Data.Odbc
Imports Turningpoint.Shared
Imports Turningpoint.Data

Partial Class Authorizations
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
        Page.MaintainScrollPositionOnPostBack = True

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

        Dim sColor As String = "white"
        Try
            sColor = ConfigurationManager.AppSettings("PageBackColor").ToString()
        Catch
            sColor = "white"
        End Try
        body.Style.Add("background-color", sColor)

        If ConfigurationManager.AppSettings("WelcomePage").ToString() = "welcome2.aspx" Then
            Header.Visible = True
        Else
            header_new.Visible = True
            page_header_tp.setHeader("Authorizations")
        End If

        If Not IsPostBack Then
            Session("RetailRecs") = "25"
            Session("SortExpression") = "ItemDesc"
            Session("sort_asc") = True

            FillDropDowns()

            CustomerNo.Value = usrDetails.TPSCustomerNumber
            LoadView()
        End If
    End Sub

    Sub LoadView()
        Try
            Dim sCSVBuilder As StringBuilder = New StringBuilder()

            Dim usrDetails As UserDetail = Session("UserDetails")

            Dim dt As DataTable = New DataTable

            dt.Columns.Add("ItemNumber", GetType(String))
            dt.Columns.Add("ItemDesc", GetType(String))
            dt.Columns.Add("Vendor", GetType(String))
            dt.Columns.Add("RetailClass", GetType(String))
            dt.Columns.Add("RetailClassDesc", GetType(String))
            dt.Columns.Add("ItemClass", GetType(String))
            dt.Columns.Add("InvDescription", GetType(String))
            dt.Columns.Add("RetailDate", GetType(DateTime))
            dt.Columns.Add("DisplayDate", GetType(String))
            dt.Columns.Add("Fixed_Pct", GetType(String))
            dt.Columns.Add("RetailsAmount", GetType(String))
            dt.Columns.Add("Rounding", GetType(String))
            dt.Columns.Add("RoundingDesc", GetType(String))
            dt.Columns.Add("UOM", GetType(String))
            dt.Columns.Add("CSSNSC", GetType(String))
            dt.Columns.Add("CSSNSM", GetType(String))
            dt.Columns.Add("IsException", GetType(Integer))
            dt.Columns.Add("Tooltip", GetType(String))
            dt.Columns.Add("LinkClass", GetType(String))
            dt.Columns.Add("IsAuth", GetType(Integer))
            dt.Columns.Add("RetailSRP", GetType(String))

            Dim params As SearchItemsParameters = New SearchItemsParameters()
            params.CustomerNumber = usrDetails.TPSCustomerNumber
            params.Description = txt_search.Text.Trim
            params.Class = cat_dropdown.SelectedValue
            params.ClassName = cat_dropdown.SelectedItem.Text
            params.Vendor = vendor_dropdown.SelectedValue
            params.VendorName = vendor_dropdown.SelectedItem.Text
            params.MaxItems = 1000
            params.ShowAll = cb_show_all.Checked

            Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()
            Dim lstItems As List(Of ItemRetail)
            lstItems = tpsData.GetSearchAuthorizationsAndItemRetails(params)

            For Each item As ItemRetail In lstItems
                Dim sLinkClass As String = item.RetailClass + "|" + item.ItemClass

                item.Tooltip = item.Tooltip.Replace("""", "")
                item.Tooltip = item.Tooltip.Replace("'", "")

                Dim dtRetail As DateTime = Nothing
                If item.Date > "" Then
                    dtRetail = item.Date
                End If

                Dim nException As Integer = 0
                If item.RetailClass.Trim = "" And item.Date > "" Then
                    nException = 1
                End If

                Dim sRoundingDesc As String = ""
                If nException = 1 Then
                    sRoundingDesc = GetRoundingDesc(item.Rounding)
                End If

                Dim sItemNo As String = Right("000000" & item.RetailItemNumber, 6)

                If item.RetailClass > "" Then
                    item.RetailDescription = item.RetailClass + " - " + item.RetailDescription
                End If

                Dim sSRP As String = FormatNumber(item.RetailSRP, 2)

                dt.Rows.Add(sItemNo, item.Description, item.VendorName, item.RetailClass, item.RetailDescription, item.ItemClass, item.InvDescription, dtRetail, item.Date, _
                            item.Fixed_Pct, item.RetailsAmount, item.Rounding, sRoundingDesc, item.UOM, item.CSANSC, item.CSANSM, nException, item.Tooltip, sLinkClass, item.IsAuth, sSRP)
            Next

            Dim dv As DataView = New DataView(dt)

            Try
                Dim sSort As String
                If cb_retails_top.Checked Then
                    sSort = "IsAuth desc, IsException desc, "
                Else
                    sSort = "IsAuth desc, "
                End If

                If Session("sort_asc") Then
                    dv.Sort = sSort & Session("SortExpression") & " asc"
                Else
                    dv.Sort = sSort & Session("SortExpression") & " desc"
                End If
            Catch ex As Exception
                Utils.traceApp(Server, ex.Message & vbCrLf & ex.StackTrace)
            End Try

            item_list.PageSize = records_per_page.SelectedValue

            item_list.DataSource = dv
            item_list.DataBind()
        Catch ex As Exception
            Utils.traceApp(Server, ex.Message)
        End Try
    End Sub

    Private Sub item_list_SortCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridSortCommandEventArgs) Handles item_list.SortCommand
        If Session("SortExpression") = e.SortExpression Then
            Session("sort_asc") = Not Session("sort_asc")
        Else
            Session("SortExpression") = e.SortExpression
            Session("sort_asc") = True
        End If

        item_list.CurrentPageIndex = 0

        LoadView()
    End Sub

    Protected Sub item_list_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles item_list.ItemDataBound
        Try
            Dim sRounding As String = DirectCast(e.Item.FindControl("Rounding"), Label).Text().Trim()
            Dim dd As DropDownList = DirectCast(e.Item.FindControl("ItemRoundingDropdown"), DropDownList)

            For Each item As ListItem In rounding_dropdown.Items
                dd.Items.Add(New System.Web.UI.WebControls.ListItem(item.Text, item.Value))
            Next

            dd.SelectedValue = sRounding
        Catch ex As Exception
        End Try
    End Sub

    Private Sub FillDropDowns()
        Dim sDesc As String = ""
        Dim usrDetails As UserDetail = Session("UserDetails")
        Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()

        cat_dropdown.Items.Add(New System.Web.UI.WebControls.ListItem("- Select Inventory Class -", ""))
        For Each kv As KeyValuePair(Of String, String) In tpsData.GetItemClasses(usrDetails.TPSCustomerNumber)
            cat_dropdown.Items.Add(New ListItem(kv.Value, kv.Key))
        Next

        vendor_dropdown.Items.Add(New ListItem("- Select Vendor -", ""))
        For Each kv As KeyValuePair(Of String, String) In tpsData.GetItemVendors()
            vendor_dropdown.Items.Add(New ListItem(kv.Value, kv.Key))
        Next

        For Each kv As KeyValuePair(Of String, String) In tpsData.GetRoundingCodes()
            rounding_dropdown.Items.Add(New System.Web.UI.WebControls.ListItem(kv.Value, kv.Key))
        Next
    End Sub

    Private Function GetRoundingDesc(ByVal sRoundingCode As String) As String
        For Each Item As ListItem In rounding_dropdown.Items
            If Item.Value = sRoundingCode Then
                Return Item.Text
            End If
        Next

        Return ""
    End Function

    Protected Sub item_list_PageIndexChanged(source As Object, e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles item_list.PageIndexChanged
        item_list.CurrentPageIndex = e.NewPageIndex
        LoadView()
    End Sub

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

    Private Function createDateTimeFromCYYMMDD(ByVal cmmddyy As String) As String
        Dim s_dt As String = "0000000" + cmmddyy
        s_dt = s_dt.Substring(s_dt.Length - 7, 7)

        Try
            Dim century As Integer = 100 * (19 + Integer.Parse(s_dt.Substring(0, 1)))
            Dim dt As Date = New Date(century + Integer.Parse(s_dt.Substring(1, 2)), Integer.Parse(s_dt.Substring(3, 2)), Integer.Parse(s_dt.Substring(5, 2)))
            Return dt.ToShortDateString
        Catch
            Return "1/1/1900"
        End Try
    End Function

    Protected Sub records_per_page_SelectedIndexChanged(sender As Object, e As EventArgs) Handles records_per_page.SelectedIndexChanged
        Try
            If records_per_page.SelectedValue = Session("RetailRecs") Then
                Exit Sub
            End If

            Session("RetailRecs") = records_per_page.SelectedValue
            item_list.CurrentPageIndex = 0

            LoadView()
        Catch ex As Exception
            Utils.traceApp(Server, ex.Message)
        End Try
    End Sub

    Protected Sub save_items_button_Click(sender As Object, e As EventArgs) Handles save_items_button.Click
        SaveAuthorizations()
        SaveRetails()

        LoadView()
    End Sub

    Private Sub SaveRetails()
        Dim sItem As String
        Dim cb As CheckBox
        Dim usrDetails As UserDetail = Session("UserDetails")
        Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()
        Dim lstParams As List(Of RetailItemParameters) = New List(Of RetailItemParameters)

        For Each GridItem As DataGridItem In item_list.Items
            sItem = DirectCast(GridItem.FindControl("ItemNumber"), Label).Text().Trim()

            Try
                cb = DirectCast(GridItem.FindControl("cb_delete"), CheckBox)
                If cb.Checked Then
                    tpsData.DeleteRetailItem(usrDetails.TPSCustomerNumber, sItem)
                    Continue For
                End If
            Catch
            End Try

            Dim sFixedAmt As String = DirectCast(GridItem.FindControl("FixedAmt"), TextBox).Text().Trim()
            Dim sPctAmt As String = DirectCast(GridItem.FindControl("PctAmt"), TextBox).Text().Trim()

            If IsNumeric(sFixedAmt) Or IsNumeric(sPctAmt) Then
                Dim sRetailClass = DirectCast(GridItem.FindControl("RetailClass"), Label).Text().Trim()
                Dim sRetailClassDesc = DirectCast(GridItem.FindControl("RetailClassDesc"), Label).Text().Trim()
                Dim sInvClass = DirectCast(GridItem.FindControl("ItemClass"), Label).Text().Trim()
                Dim sRounding As String = DirectCast(GridItem.FindControl("ItemRoundingDropdown"), DropDownList).SelectedValue
                Dim sUOM = DirectCast(GridItem.FindControl("UOM"), Label).Text().Trim()

                Dim params As RetailItemParameters = New RetailItemParameters()

                params.CustomerNumber = usrDetails.TPSCustomerNumber
                params.RetailClass = sRetailClass
                params.RetailClassDesc = sRetailClassDesc
                params.InvClass = sInvClass
                params.Rounding = sRounding
                params.R_S = sUOM
                params.Date = Now.Date.ToShortDateString
                params.ClassDate = Now.Date.ToShortDateString
                params.CSSISC = ""
                params.CSSNSC = ""
                params.CSSNSM = ""
                params.ItemNumber = sItem
                If sFixedAmt > "" Then
                    params.F_S = "F"
                    params.Amount = sFixedAmt
                Else
                    params.F_S = "%"
                    params.Amount = sPctAmt
                End If

                lstParams.Add(params)
            End If
        Next

        If lstParams.Count > 0 Then
            tpsData.AddClassItem(lstParams)
        End If
    End Sub

    Private Sub SaveAuthorizations()
        Dim sItem As String
        Dim sIsAuth As String
        Dim sDesc As String
        Dim bIsAuth As Boolean
        Dim cb As CheckBox
        Dim bChecked As Boolean
        Dim usrDetails As UserDetail = Session("UserDetails")
        Dim tpsData As TurningpointDataComponent = New TurningpointDataComponent()

        For Each GridItem As DataGridItem In item_list.Items
            Try
                sItem = DirectCast(GridItem.FindControl("ItemNumber"), Label).Text().Trim()
                sDesc = DirectCast(GridItem.FindControl("ItemDesc"), Label).Text().Trim()
                sIsAuth = DirectCast(GridItem.FindControl("IsAuth"), Label).Text().Trim()
                If sIsAuth = "1" Then
                    bIsAuth = True
                Else
                    bIsAuth = False
                End If
                cb = DirectCast(GridItem.FindControl("cb_auth"), CheckBox)
                bChecked = cb.Checked

                If bChecked = bIsAuth Then
                    Continue For
                End If

                If cb.Checked Then
                    tpsData.AddAuthorizedItem(usrDetails.TPSCustomerNumber, sItem, sDesc)
                Else
                    tpsData.DeleteAuthorizedItem(usrDetails.TPSCustomerNumber, sItem)
                End If
            Catch ex As Exception
                Utils.traceApp(Server, "SaveAuthorizations" + vbCrLf + ex.Message + vbCrLf + ex.StackTrace)
            End Try
        Next
    End Sub

    Protected Sub search_button_Click(sender As Object, e As EventArgs) Handles search_button.Click
        item_list.CurrentPageIndex = 0
        LoadView()
    End Sub
End Class
