<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ItemInfoSearch.aspx.cs" Inherits="ItemInfoSearch" %>
<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header" Src="controls/page_header_tp.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Item Information</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
    <link rel="stylesheet" href="css/TPWebPortal.css" />
    <link rel="stylesheet" href="css/ItemInfoSearch.css" />
    <link rel="stylesheet" href="css/LayoutStyle.css" />
    <link rel="stylesheet" href="css/Reports.css" />
    <link rel="stylesheet" href="css/Styles.css" />
    <script src="script/json2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-ui-1.8.4.custom.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="script/tooltip/tiptip.css" />
    <script src="script/tooltip/jquery.tipTip.js" type="text/javascript"></script>
    <script src="script/tooltip/jquery.tipTip.minified.js" type="text/javascript"></script>
    <script src="script/date.format.js" type="text/javascript"></script>
    <script src="script/utility.js" type="text/javascript"></script>
    <script src="script/SearchItems.js" type="text/javascript"></script>
    <script src="script/TableHelper.js" type="text/javascript"></script>
    <script src="script/ItemInfoSearch.js" type="text/javascript"></script>
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
                        <asp:Label runat="server" ID="lblOrders" Text="Item Information" />
                        <input type="hidden" id="CustNo" runat="server" />
                    </td>
                </tr>
            </table>
        </div>

        <input type='hidden' id='CustomerNo' runat='server' />
        <input type='hidden' id='ShowQOH' runat='server' />
        <input type='hidden' id='RX' runat='server' />

        <div id='items_container'>

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
            <table class='normal' id='search_item_info_table' cellpadding='0' cellspacing='0'>
                <thead>
                    <tr class='normal_header'>
                        <th class='ItemNumber'>
                            Item #
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
                        <th class='GM'>
                            GM
                        </th>
                        <th class='Form'>
                            Form
                        </th>
                        <th class='Caseqty'>
                            Case Qty
                        </th>
                        <th class='RetailQty'>
                            Retail Qty
                        </th>
                        <th class='RetailUOM'>
                            Retail UOM
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
    </div>
    </div>
        </div>
    </form>
</body>
</html>
