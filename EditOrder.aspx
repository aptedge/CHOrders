<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditOrder.aspx.cs" Inherits="EditOrder" %>
<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header" Src="controls/page_header_tp.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ORDERS</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
    <link rel="stylesheet" href="css/TPWebPortal.css" />
    <link rel="stylesheet" href="css/LayoutStyle.css" />
    <link rel="stylesheet" href="css/Reports.css" />
    <link rel="stylesheet" href="css/Styles.css" />
    <link rel="stylesheet" href="css/EditOrder.css" />
    <script src="script/json2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-ui-1.8.4.custom.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery.formatCurrency-1.4.0.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="script/tooltip/tiptip.css" />
    <script src="script/tooltip/jquery.tipTip.js" type="text/javascript"></script>
    <script src="script/tooltip/jquery.tipTip.minified.js" type="text/javascript"></script>
    <script src="script/date.format.js" type="text/javascript"></script>
    <script src="script/utility.js" type="text/javascript"></script>
    <script src="script/TableHelper.js" type="text/javascript"></script>
    <script src="script/OrderItemCollection.js" type="text/javascript"></script>
    <script src="script/SearchItems.js" type="text/javascript"></script>
    <script src="script/EditOrder.js" type="text/javascript"></script>
    <script type="text/javascript">
        function noBack() { window.history.forward() }
        noBack();
        window.onload = noBack;
        window.onpageshow = function (evt) { if (evt.persisted) noBack() }
        window.onunload = function () { void (0) }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="container"> 
    
	<div id="header"><uc1:page_header id="page_header" runat="server"></uc1:page_header></div>

    <div id="page_body" class="block_adjust">

        <div id="report_title">
            <table>
                <tr style="line-height: 50px;" >
                    <td id="Report_TITLE" colspan="2">
                        <asp:Label runat="server" ID="lblOrders" Text="Edit Order" />
                        <input type='hidden' id='OrderNo' runat='server' />
                        <input type='hidden' id='FormName' runat='server' />
                        <input type='hidden' id='CustomerNo' runat='server' />
                        <input type='hidden' id='EditType' runat='server' />
                        <input type='hidden' id='ShowQOH' runat='server' />
                        <input type='hidden' id='RX' runat='server' />
                    </td>
                </tr>
            </table>
        </div>

        <div id="tabs">
            <ul>
                <li><a id="my_li" href="#my_tab">My Order</a></li>
                <li><a id="newitem_li" href="#newitems_tab" onclick="JavaScript:SearchForItems(NEWITEM_TAB, true);">New Items</a></li>
                <li><a id="search_li" href="#search_tab">Search Items</a></li>
            </ul>
            <div id="my_tab">
                <div id='my_quickentry_div'>
                    <table>
                        <tr>
                            <td class='normal_label' id='po_number_label'>
                                PO #:&nbsp;
                            </td>
                            <td id='po_number'>
                                <input type='text' id='po_number_text' class='normal_input' maxlength='12' />
                            </td>
                            <td class='normal_label' id='day_of_week_label' runat="server" visible="false">
                                &nbsp;&nbsp;&nbsp;Delivery Day:&nbsp;
                            </td>
                            <td id='day_of_week' runat="server" visible="false">
                                <asp:DropDownList ID="day_of_week_dd" runat="server" />
                            </td>
                            <td id='will_call' runat="server">
                                &nbsp;&nbsp;&nbsp;<asp:CheckBox ID="cb_will_call" Text="&nbsp;Pick Up" runat="server" />
                            </td>
                            <td width="600px">
                                &nbsp;
                            </td>
                            <td>
                                Order Total: <asp:Label ID="total" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td class='normal_label' id='comments1_label'>
                                Comments:&nbsp;
                            </td>
                            <td id='comments1'>
                                <input type='text' id='comments1_text' class='normal_input' maxlength='30' />
                            </td>
                            <td width="390px">
                                &nbsp;
                            </td>
                            <td runat="server" id="items_1" visible="false">
                                <asp:Label ID="items_label1" runat="server" Text="LWD Items: "/><asp:Label ID="items_lwd" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class='normal_label' id='comments2_label'>
                                &nbsp;
                            </td>
                            <td id='comments2'>
                                <input type='text' id='comments2_text' class='normal_input' maxlength='30' />
                            </td>
                            <td width="391px">
                                &nbsp;
                            </td>
                            <td runat="server" id="items_2" visible="false">
                                <asp:Label ID="items_label2" runat="server" Text="ABC Items: " /><asp:Label ID="items_abc" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table>
                        <tr>
                            <td class='normal_label' id='my_quickentry_item_no_label'>
                                Item #:
                            </td>
                            <td id='my_quickentry_item_no_value'>
                                <input type='text' id='my_quickentry_item_no_text' class='normal_input' maxlength='6'
                                    onkeypress="JavaScript:return NumbersOnly(event);" onkeyup="JavaScript:return handleKeyPressItem(event);" />
                            </td>
                            <td class='my_quickentry_spacing_col'>
                            </td>
                            <td class='normal_label' id='my_quickentry_qty_label'>
                                Qty:
                            </td>
                            <td id='my_quickentry_qty_value'>
                                <input type='text' id='my_quickentry_qty_text' class='normal_input' maxlength='3'
                                    onkeypress="JavaScript:return NumbersOnly(event);" onkeyup="JavaScript:return handleKeyPressQty(event);" />
                            </td>
                            <td class='my_quickentry_spacing_col'>
                            </td>
                            <td>
                                <input type='button' id='my_quickentry_add_button' class='normal_button' value='Add to Order'/>
                            </td>
                            <td class='my_quickentry_spacing_col'>
                            </td>
                            <td class='my_quickentry_spacing_col'>
                            </td>
                            <td class='my_quickentry_spacing_col'>
                            </td>
                            <td class='my_quickentry_spacing_col'>
                            </td>
                            <td class='my_quickentry_spacing_col'>
                            </td>
                            <td class='my_quickentry_spacing_col'>
                            </td>
                            <td class='my_quickentry_spacing_col'>
                            </td>
                            <td class='normal_label'>
                                Description:
                            </td>
                            <td id=''>
                                <input type="text" size="9" class="normal_input" id="search_oe_description_text" />
                            </td>
                            <td class='my_quickentry_spacing_col'>
                            </td>
                            <td>
                                <input type="button" class='normal_button' id="search_oe_search_button" value="Search" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id='my_table_div'>
                    <table class='normal' id='my_table' cellpadding='0' cellspacing='0'>
                        <thead>
                            <tr class='normal_header'>
                                <th class='IsChecked'>
                                    <input type='checkbox' id='my_checkbox_all' />
                                </th>
                                <th class='ItemNumber' onclick='OnSortOrder(SORT_ITEM);' style='cursor:pointer;'>
                                    Item #
                                </th>
                                <th class='LineNumber' onclick='OnSortOrder(SORT_LINE);' style='cursor:pointer;'>
                                    Line #
                                </th>
                                <th class='Quantity'>
                                    Qty
                                </th>
                                <th class='UPC'>
                                    Box UPC #
                                </th>
                                <th class='NDC'>
                                    NDC #
                                </th>
                                <th class='Description' onclick='OnSortOrder(SORT_DESCRIPTION);' style='cursor:pointer;'>
                                    Description
                                </th>
                                <th class='Price'>
                                    Price
                                </th>
                                <th class='Size'>
                                    Size
                                </th>
                                <th class='QOH' id="order_entry_hdr_qoh" runat="server">
                                    QOH
                                </th>
                                <th class='GM'>
                                    GM
                                </th>
                                <th class='Form'>
                                    Form
                                </th>
                                <th class='Caseqty'>
                                    Case Qty
                                </th>
                                <th class='RetailPrice'>
                                    Retail
                                </th>
                                <th class='StockStatus'>
                                    In Stock
                                </th>
                                <th class='LastPurchDate'>
                                    Last Purch Date
                                </th>
                                <th class='LastPurchQty'>
                                    Last Purch Qty
                                </th>
                                <th class='Qty30_60_90'>
                                    30-60-90
                                </th>
                                <th class='command delete_item_cmd'>
                                    Delete
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- <tr>'s are added in javascript -->
                        </tbody>
                    </table>
                </div>
                <div id='my_buttons_div'>
                    <table>
                        <tr>
                            <td>
                                <input type='button' id='my_save_button' class='normal_button' value='Save Order' />
                            </td>
                            <td class='my_buttons_col_spacing'>
                            </td>
                            <td>
                                <input type='button' id='my_checkout_button' class='normal_button' value='Submit Order' />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="newitems_tab">
                <div id='newitems_table_div'>
                    <table class='normal' id='newitems_table' cellpadding='0' cellspacing='0'>
                        <thead>
                            <tr class='normal_header'>
                                <th class='IsChecked'>
                                    <input type='checkbox' id='newitems_checkbox_all' />
                                </th>
                                <th class='ItemNumber'>
                                    Item #
                                </th>
                                <th class='Quantity'>
                                    Qty
                                </th>
                                <th class='UPC'>
                                    Box UPC #
                                </th>
                                <th class='NDC'>
                                    NDC #
                                </th>
                                <th class='Description'>
                                    Description
                                </th>
                                <th class='Price'>
                                    Price
                                </th>
                                <th class='Size'>
                                    Size
                                </th>
                                <th class='QOH' id="new_items_hdr_qoh" runat="server">
                                    QOH
                                </th>
                                <th class='GM'>
                                    GM
                                </th>
                                <th class='Form'>
                                    Form
                                </th>
                                <th class='Caseqty'>
                                    Case Qty
                                </th>
                                <th class='RetailPrice'>
                                    Retail
                                </th>
                                <th class='StockStatus'>
                                    In Stock
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- <tr>'s are added in javascript -->
                        </tbody>
                    </table>
                </div>
                <div id='newitems_buttons_div'>
                    <table>
                        <tr>
                            <td>
                                <input type='button' id='newitems_add_button' class='normal_button' value='Add to Order' />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="search_tab">
                <div id='search_params_div'>
                    <table>
                        <tr>
                            <td class='normal_label' id='search_params_upc_no_label'>
                                <asp:label id="search_params_item_title" runat="server" />
                            </td>
                            <td id='seach_params_upc_no_value'>
                                <input type="text" id="search_params_upc_no_text" class="normal_input" maxlength="14" />
                            </td>
                            <td class='search_params_col_spacing'>
                            </td>
                            <td class='normal_label' id='search_params_description_label'>
                                Description:
                            </td>
                            <td id='seach_params_description_value'>
                                <input type="text" size="9" class="normal_input" id="search_params_description_text" />
                            </td>
                        </tr>
                    </table>
                    <table style='margin-top: 2px;'>
                        <tr>
                            <td class='normal_label'>
                                Class:
                            </td>
                            <td>
                                <asp:DropDownList ID="search_params_class_dropdown" runat="server" CssClass='search_params_dropdown_class' />
                            </td>
                        </tr>
                    </table>
                    <table style='margin-top: 2px;'>
                        <tr>
                            <td class='normal_label'>
                                Vendor:
                            </td>
                            <td>
                                <asp:DropDownList ID="search_params_vendor_dropdown" runat="server" CssClass='search_params_dropdown_class' />
                            </td>
                        </tr>
                    </table>
                    <table style="margin-top: 8px;">
                        <tr>
                            <td>
                                <input type="button" class='normal_button' id="search_params_search_button" value="Search" />
                            </td>
                            <td class='search_params_col_spacing'>
                            </td>
                            <td>
                                <input type='checkbox' class='normal_checkbox' id="search_params_newitemsonly_checkbox" />New
                                Items Only
                            </td>
                        </tr>
                    </table>
                </div>
                <div id='search_table_div'>
                    <table class='normal' id='search_table' cellpadding='0' cellspacing='0'>
                        <thead>
                            <tr class='normal_header'>
                                <th class='IsChecked'>
                                    <input type='checkbox' id='search_checkbox_all' />
                                </th>
                                <th class='ItemNumber' onclick='OnSortSearchOrder(SORT_ITEM);' style='cursor:pointer;'>
                                    Item #
                                </th>
                                <th class='Quantity'>
                                    Qty
                                </th>
                                <th class='UPC'>
                                    Box UPC #
                                </th>
                                <th class='NDC'>
                                    NDC #
                                </th>
                                <th class='Description' onclick='OnSortSearchOrder(SORT_DESCRIPTION);' style='cursor:pointer;'>
                                    Description
                                </th>
                                <th class='Vendor' onclick='OnSortSearchOrder(SORT_VENDOR);' style='cursor:pointer;'>
                                    Vendor
                                </th>
                                <th class='Price'>
                                    Price
                                </th>
                                <th class='Size'>
                                    Size
                                </th>
                                <th class='QOH' id="search_hdr_qoh" runat="server">
                                    QOH
                                </th>
                                <th class='GM'>
                                    GM
                                </th>
                                <th class='Form'>
                                    Form
                                </th>
                                <th class='Caseqty'>
                                    Case Qty
                                </th>
                                <th class='RetailPrice'>
                                    Retail
                                </th>
                                <th class='StockStatus'>
                                    In Stock
                                </th>
                                <th class='LastPurchDate'>
                                    Last Purch Date
                                </th>
                                <th class='LastPurchQty'>
                                    Last Purch Qty
                                </th>
                                <th class='Qty30_60_90'>
                                    30-60-90
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- <tr>'s are added in javascript -->
                        </tbody>
                    </table>
                </div>
                <div id='search_buttons_div'>
                    <table>
                        <tr>
                            <td>
                                <input type='button' id='search_add_button' class='normal_button' value='Add to Order' />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    </div>
    </form>
</body>
</html>
