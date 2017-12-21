<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="Checkout" %>
<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header" Src="controls/page_header_tp.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Submit</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
    <link rel="stylesheet" href="css/TPWebPortal.css" />
    <link rel="stylesheet" href="css/LayoutStyle.css" />
    <link rel="stylesheet" href="css/Reports.css" />
    <link rel="stylesheet" href="css/Checkout.css" />
    <script src="script/json2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
     <link rel="stylesheet" href="script/tooltip/tiptip.css" />
    <script src="script/tooltip/jquery.tipTip.js" type="text/javascript"></script>
    <script src="script/tooltip/jquery.tipTip.minified.js" type="text/javascript"></script>
   <script src="script/date.format.js" type="text/javascript"></script>
    <script src="script/utility.js" type="text/javascript"></script>
    <script src="script/TableHelper.js" type="text/javascript"></script>
    <script src="script/Checkout.js" type="text/javascript"></script>
    <script type="text/javascript">
        function noBack() { window.history.forward() }
        noBack();
        window.onload = noBack;
        window.onpageshow = function (evt) { if (evt.persisted) noBack() }
        window.onunload = function () { void (0) }
    </script>
</head>
<body>
    <form id='checkout' runat='server'>

    <div id="container"> 
    
	<div id="header"><uc1:page_header id="page_header" runat="server"></uc1:page_header></div>

    <div id="page_body" class="block_adjust">

        <div id="report_title">
            <table>
                <tr style="line-height: 50px;" >
                    <td id="Report_TITLE" colspan="2">
                        <asp:Label runat="server" ID="lblOrders" Text="Submit Order" />
                        <input type='hidden' id='OrderNo' runat='server' />
                        <input type='hidden' id='CustNo' runat='server' />
                        <input type='hidden' id='SubmitMessage' runat='server' />
                        <input type='hidden' id='ShowQOH' runat='server' />
                        <input type='hidden' id='RX' runat='server' />
                    </td>
                </tr>
            </table>
        </div>

        <div id='checkout_header_layout_div'>
            <table id='checkout_header_layout'>
                <tr>
                    <td class='table_layout_label'>
                        Order No:
                    </td>
                    <td class='table_layout_value' id='OrderNumber'>
                    </td>
                    <td class='table_layout_spacing_col'>
                    </td>
                    <td class='table_layout_label'>
                        Date:
                    </td>
                    <td class='table_layout_value' id='DateCreated'>
                    </td>
                </tr>
                <tr>
                    <td class='table_layout_label'>
                        Customer No:
                    </td>
                    <td class='table_layout_value' id='CustomerNumber'>
                    </td>
                    <td class='table_layout_spacing_col'>
                    </td>
                    <td class='table_layout_label'>
                        Order Total:
                    </td>
                    <td class='table_layout_value' id='OrderTotal'>
                    </td>
                </tr>
                <tr>
                    <td class='table_layout_label'>
                        Lines Total:
                    </td>
                    <td class='table_layout_value' id='LinesTotal'>
                    </td>
                    <td class='table_layout_spacing_col'>
                    </td>
                    <td class='table_layout_label'>
                        Units Ordered:
                    </td>
                    <td class='table_layout_value' id='UnitsOrdered'>
                    </td>
                </tr>
            </table>
        </div>
        <div id='checkout_table_div'>
            <table class='normal' id='checkout_table' cellpadding='0' cellspacing='0'>
                <thead>
                    <tr class='normal_header'>
                        <th class='ItemNumber' onclick='OnSortOrder(SORT_ITEM);' style='cursor:pointer;'>
                            Item #
                        </th>
                        <th class='LineNumber' onclick='OnSortOrder(SORT_LINE);' style='cursor:pointer;'>
                            Line #
                        </th>
                        <th class='UPC'>
                            UPC #
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
                        <th class='QOH'>
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
                        <th class='Quantity'>
                            Qty
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <!-- <tr>'s are added in javascript -->
                </tbody>
            </table>
        </div>
        <div id='checkout_buttons'>
            <table>
                <tr>
                    <td>
                        <input type='button' id='btn_edit_order' class='normal_button' value='Edit Order' />
                    </td>
                    <td id='checkout_spacing_buttons'>
                    </td>
                    <td>
                        <input type='button' id='btn_submit_order' class='normal_button' value='Submit Order' />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </div>
    </form>
</body>
</html>
