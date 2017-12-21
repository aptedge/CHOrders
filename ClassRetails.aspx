<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClassRetails.aspx.cs" Inherits="Retails" %>
<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header" Src="controls/page_header_tp.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>RETAILS</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
    <link rel="stylesheet" href="css/TPWebPortal.css" />
    <link rel="stylesheet" href="css/LayoutStyle.css" />
    <link rel="stylesheet" href="css/Reports.css" />
    <link rel="stylesheet" href="css/Styles.css" />
    <link rel="stylesheet" href="css/ClassRetails.css" />
    <script src="script/json2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-ui-1.8.4.custom.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="script/tooltip/tiptip.css" />
    <script src="script/tooltip/jquery.tipTip.js" type="text/javascript"></script>
    <script src="script/tooltip/jquery.tipTip.minified.js" type="text/javascript"></script>
    <script src="script/date.format.js" type="text/javascript"></script>
    <script src="script/utility.js" type="text/javascript"></script>
    <script src="script/TableHelper.js" type="text/javascript"></script>
    <script src="script/SearchItems.js" type="text/javascript"></script>
    <script src="script/RetailItem.js" type="text/javascript"></script>
    <script src="script/ClassRetails.js" type="text/javascript"></script>
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
                        <asp:Label runat="server" ID="lblTitle" Text="Retails" />
                        <input type='hidden' id='CustomerNo' runat='server' />
                        <input type='hidden' id='RetailsHelpFile' runat='server' />
                        <input type='hidden' id='bUpdating' runat='server' />
                    </td>
                    <td width="850">
                        &nbsp;
                    </td>
                    <td width="16">
                        <a id="help_li" href="JavaScript:ShowHelpFile()" style="text-decoration:none;  outline-style:none; border-style:none;" ><img id='help_img' style="border-style:none" src='images/help.bmp' alt='Help' height="20" runat="server" /></a>
                    </td>
                </tr>
            </table>
        </div>

        <div id='inv_container'>

        <div id="tabs">
            <ul>
                <li id="li_class" runat="server"><a id="retail_class_li" href="#retail_class_tab" runat="server" onclick="JavaScript:OnClassRetailsClick();">Class Retails</a></li>
                <li id="li_items" runat="server"><a id="retail_items_li" href="#retail_items_tab" runat="server" onclick="JavaScript:OnClassItemsClick();">Class Item Exceptions</a></li>
                <li id="li_all" runat="server"><a id="retail_all_items_li" href="#retail_all_items_tab" runat="server" onclick="JavaScript:OnAllItemsClick();">All Item Exceptions</a></li>
                <li id="li_search" runat="server"><a id="search_li" href="#search_tab" runat="server" onclick="JavaScript:OnSearchClick();">Search Items</a></li>
                <li id="li_loading" runat="server" visible="false"><a id="loading_li" visible="false" href="#loading_tab" runat="server">Updating ...</a></li>
            </ul>

            <div id="retail_class_tab">
                <div id='retail_class_menu_div'>
                    <table>
                        <tr>
                            <td class='normal_label' id='class_label'>
                                Retail&nbsp;Class:&nbsp;
                            <input type='hidden' id='class_CSSISC' runat='server' />
                            <input type='hidden' id='class_CSSNSC' runat='server' />
                            <input type='hidden' id='class_CSSNSM' runat='server' />
                            </td>
                            <td class='normal_label'>
                                <input type='text' id='class_no' class='normal_input' style="width:50px" runat="server" />&nbsp;<input type='text' id='class_desc' class='normal_input' style="width:260px" runat="server" />
                            </td>
                            <td class='spacing_col'></td>
                            <td class='normal_label' id='inv_label'>
                                Inv&nbsp;Category:&nbsp;
                            </td>
                            <td class='normal_label'>
                                <asp:DropDownList ID="class_dropdown" runat="server" CssClass='class_dropdown_class' onchange="JavaScript:ChangeClassDropdown();" />
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td class='spacing_col_start'></td>
                            <td class='normal_label' id='f_s_label' style="width:50px; text-align:right;">
                                F&nbsp;/&nbsp;%:
                            </td>
                            <td>
                                <input type='text' id='f_s_text' class='normal_input' maxlength='1'
                                    onkeypress="JavaScript:return FixedPctOnly(event);" />
                            </td>
                            <td class='spacing_col'></td>
                            <td class='normal_label'>
                                Amount:
                            </td>
                            <td>
                                <input type='text' id='amount_text' class='normal_input' maxlength='6'
                                    onkeypress="JavaScript:return FloatingNumbersOnly(event);" />
                            </td>
                            <td class='spacing_col'></td>
                            <td class='normal_label'>
                                Rounding:
                            </td>
                            <td>
                                <asp:DropDownList ID="rounding_dropdown" runat="server" CssClass='rounding_dropdown_class' />
                            </td>
                            <td class='spacing_col'></td>
                            <td class='normal_label'>
                                R&nbsp;/&nbsp;S:
                            </td>
                            <td>
                                <input type='text' id='r_s_text' class='normal_input' maxlength='1'
                                    onkeypress="JavaScript:return RSOnly(event);" />
                            </td>
                            <td class='spacing_col'></td>
                            <td class="normal_label" runat="server" visible="false">
                                Date:
                            </td>
                            <td id="date_value">
                                <input type="hidden" class="normal_input" id='date_input' runat="server"
                                    maxlength='10' onkeypress="JavaScript:return DateCharsOnly(event);" />
                            </td>
                            <td class='spacing_col'></td>
                            <td>
                                <input type='button' id='clear_class_retail_button' class='normal_button3' value='Clear'/>
                            </td>
                            <td class='spacing_col'></td>
                            <td>
                                <input type='button' id='create_all_class_retail_button' class='normal_button1' value='Create All'/>
                            </td>
                            <td class='spacing_col'></td>
                            <td>
                                <input type='button' id='delete_class_retail_button' class='normal_button1' value='Delete Class'/>
                            </td>
                            <td class='spacing_col'></td>
                            <td>
                                <input type='button' id='add_class_retail_button' class='normal_button1' value='Save Class'/>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id='retail_class_table_div'>
                    <table class='normal' id='class_table' cellpadding='0' cellspacing='0' >
                        <thead>
                            <tr class='normal_header'>
                                <th class='RetailClass'>
                                    Class
                                </th>
                                <th class='command items_cmd'>
                                    Items
                                </th>
                                <th class='Description'>
                                    Description
                                </th>
                                <th class='InvClass'>
                                    Category
                                </th>
                                <th class='InvDescription'>
                                    Description
                                </th>
                                <th class='Fixed_Pct'>
                                    F / %
                                </th>
                                <th class='RetailsAmount'>
                                    Amount
                                </th>
                                <th class='Rounding'>
                                    Rounding
                                </th>
                                <th class='UOM'>
                                    R / S
                                </th>
                                <th class='Date'>
                                    Date
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- <tr>'s are added in javascript -->
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="retail_items_tab">
                <div id='retail_items_menu_div'>
                    <table>
                        <tr>
                            <td class='normal_label' id='retail_class_item_label'>
                                Retail&nbsp;Class:&nbsp;
                            <input type='hidden' id='class_CSANSC' runat='server' />
                            <input type='hidden' id='class_CSANSM' runat='server' />
                            </td>
                            <td class='normal_label'>
                                <input type='text' id='class_no_item' class='normal_input' style="width:50px" runat="server" readonly />&nbsp;<input type='text' id='class_desc_item' class='normal_input' style="width:260px" runat="server" readonly />
                            </td>
                            <td class='spacing_col'></td>
                            <td class='normal_label' id='retail_inv_item_label'>
                                Inv&nbsp;Category:&nbsp;
                            </td>
                            <td class='normal_label'>
                                <input type='text' id='inv_class_no_item' class='normal_input' style="width:50px" runat="server" readonly />&nbsp;<input type='text' id='inv_class_desc_item' class='normal_input' style="width:260px" runat="server" readonly />
                            </td>
                        </tr>
                    </table>
                    <table runat="server" visible="false">
                        <tr>
                            <td class='normal_label' id='item_in_label' style="width:75px; text-align:right;">
                                Item:&nbsp;
                            </td>
                            <td class='normal_label'>
                                <input type='text' id='item_no_class_item' class='normal_input' style="width:50px" runat="server" readonly />&nbsp;
                                <input type='text' id='item_desc_class_item' class='normal_input' style="width:260px" runat="server" readonly />
                            </td>
                            <td class='spacing_col'></td>
                            <td class='spacing_col'></td>
                            <td class='spacing_col'></td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td class='spacing_col_start'></td>
                            <td class='normal_label' style="width:50px; text-align:right;">
                                F&nbsp;/&nbsp;%:
                            </td>
                            <td>
                                <input readonly type='text' id='f_s_text_item' class='normal_input' maxlength='1'
                                    onkeypress="JavaScript:return FixedPctOnly(event);" />
                            </td>
                            <td class='spacing_col'></td>
                            <td class='normal_label'>
                                Amount:
                            </td>
                            <td>
                                <input readonly type='text' id='amount_text_item' class='normal_input' maxlength='6'
                                    onkeypress="JavaScript:return FloatingNumbersOnly(event);" />
                            </td>
                            <td class='spacing_col'></td>
                            <td class='normal_label'>
                                Rounding:
                            </td>
                            <td>
                                <asp:DropDownList Enabled="false" ID="rounding_dropdown_item" runat="server" CssClass='rounding_dropdown_item' />
                            </td>
                            <td class='spacing_col'></td>
                            <td class='normal_label'>
                                R&nbsp;/&nbsp;S:
                            </td>
                            <td>
                                <input readonly type='text' id='r_s_text_item' class='normal_input' maxlength='1'
                                    onkeypress="JavaScript:return RSOnly(event);" />
                            </td>
                            <td class='spacing_col'></td>
                            <td class="normal_label">
                                Date:
                            </td>
                            <td id="date_value_item">
                                <input readonly class="normal_input" type='text' id='date_input_item' runat="server"
                                    maxlength='10' onkeypress="JavaScript:return DateCharsOnly(event);" />
                            </td>
                            <td class='spacing_col'></td>
                            <td class='spacing_col'></td>
                            <td colspan="3">
                                <input type='button' id='all_class_items_button' class='normal_button' value='All Items'/>
                                <input type='button' id='class_items_exceptions_button' class='normal_button' value='Item Exceptions'/>
                            </td>
                            <td class='spacing_col'></td>
                            <td>
                                <input type='button' id='add_item_retail_button' class='normal_button' value='Add/Save Items'/>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id='retail_items_table_div'>
                    <table class='normal' id='class_items_table' cellpadding='0' cellspacing='0' >
                        <thead>
                            <tr class='normal_header'>
                                <th class='RetailItemNumber' onclick='OnSortClassItem(SORT_ITEM);' style='cursor:pointer;'>
                                    Item #
                                </th>
                                <th class='Description' onclick='OnSortClassItem(SORT_DESCRIPTION);' style='cursor:pointer;'>
                                    Description
                                </th>
                                <th class='VendorName' onclick='OnSortClassItem(SORT_VENDOR);' style='cursor:pointer;'>
                                    Vendor
                                </th>
                                <th class='Fixed_Pct'>
                                    F / %
                                </th>
                                <th class='RetailsAmount'>
                                    Amount
                                </th>
                                <th class='Rounding'>
                                    Rounding
                                </th>
                                <th class='UOM'>
                                    R / S
                                </th>
                                <th class='Date'>
                                    Date
                                </th>
                                <th class='New_Amount_F'>
                                    Fixed Amt
                                </th>
                                <th class='New_Amount_S'>
                                    % Amount
                                </th>
                                <th class='command delete_retail_item'>
                                    Delete&nbsp;
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- <tr>'s are added in javascript -->
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="retail_all_items_tab">
                <div id='retail_all_items_table_div'>
                    <table class='normal' id='all_items_table' cellpadding='0' cellspacing='0' >
                        <thead>
                            <tr class='normal_header'>
                                <th class='RetailItemNumberClass' onclick='OnSortClassAllItem(SORT_ITEM);' style='cursor:pointer;'>
                                    Item #
                                </th>
                                <th class='Description' onclick='OnSortClassAllItem(SORT_DESCRIPTION);' style='cursor:pointer;'>
                                    Description
                                </th>
                                <th class='VendorName' onclick='OnSortClassAllItem(SORT_VENDOR);' style='cursor:pointer;'>
                                    Vendor
                                </th>
                                <th class='ItemClass'>
                                    Category
                                </th>
                                <th class='InvDescription'>
                                    Description
                                </th>
                                <th class='Fixed_Pct'>
                                    F / %
                                </th>
                                <th class='RetailsAmount'>
                                    Amount
                                </th>
                                <th class='Rounding'>
                                    Rounding
                                </th>
                                <th class='UOM'>
                                    R / S
                                </th>
                                <th class='Date'>
                                    Date
                                </th>
                                <th class='command delete_retail_item'>
                                    Delete&nbsp;
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- <tr>'s are added in javascript -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div id="search_tab">
                <div id='search_params_div'>
                    <table>
                        <tr>
                            <td class='normal_label' id='search_params_upc_no_label'>
                                UPC or Item#:
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
                                <input type='checkbox' class='normal_checkbox' id="search_params_newitemsonly_checkbox" style="position: relative; top: -1px;" />
                            </td>
                            <td style="white-space:nowrap; width:300px">New&nbsp;Items&nbsp;Only</td>
                            <td class='search_retails_add_col_spacing'>
                            </td>
                            <td>
                                <input type='button' id='add_srch_retail_button' class='normal_button' value='Add/Save Items'/>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id='search_table_div'>
                    <table class='normal' id='search_table' cellpadding='0' cellspacing='0' >
                        <thead>
                            <tr class='normal_header'>
                                <th class='RetailItemNumber' onclick='OnSortSearchItem(SORT_ITEM);' style='cursor:pointer;'>
                                    Item #
                                </th>
                                <th class='Description' onclick='OnSortSearchItem(SORT_DESCRIPTION);' style='cursor:pointer;'>
                                    Description
                                </th>
                                <th class='VendorName' onclick='OnSortSearchItem(SORT_VENDOR);' style='cursor:pointer;'>
                                    Vendor
                                </th>
                                <th class='Fixed_Pct'>
                                    F / %
                                </th>
                                <th class='RetailsAmount'>
                                    Amount
                                </th>
                                <th class='Rounding'>
                                    Rounding
                                </th>
                                <th class='UOM'>
                                    R / S
                                </th>
                                <th class='Date'>
                                    Date
                                </th>
                                <th class='New_Amount_F'>
                                    Fixed Amt
                                </th>
                                <th class='New_Amount_S'>
                                    % Amount
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- <tr>'s are added in javascript -->
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="loading_tab">
                <p>
                    <br />                
                    <br />                
                    <br />                
                    <br />                
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Retail data is currently being updated.  We appologize for the inconvenience.  Please try again shortly.
                </p>
            </div>

        </div>
    </div>
    </div>
    </div>
    </form>
</body>
</html>
