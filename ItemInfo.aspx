<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ItemInfo.aspx.cs" Inherits="ItemInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Item Details</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
    <link rel="stylesheet" href="css/TPWebPortal.css" />
    <link rel="stylesheet" href="css/ItemInfo.css" />
    <script src="script/json2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-ui-1.8.4.custom.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="script/tooltip/tiptip.css" />
    <script src="script/tooltip/jquery.tipTip.js" type="text/javascript"></script>
    <script src="script/tooltip/jquery.tipTip.minified.js" type="text/javascript"></script>
    <script src="script/utility.js" type="text/javascript"></script>
    <script src="script/ItemInfo.js" type="text/javascript"></script>
    <script type="text/javascript">
        function noBack() { window.history.forward() }
        noBack();
        window.onload = noBack;
        window.onpageshow = function (evt) { if (evt.persisted) noBack() }
        window.onunload = function () { void (0) }
    </script>
</head>
<body id="body" runat="server" style="height:auto;">
    <form id="form1" runat="server">
    <div id="container">
        <input type='hidden' id='CustNo' runat='server' />
        <input type='hidden' id='ItemNo' runat='server' />
        <div id="ii_details_div">
            <table>
                <tr>
                    <td class="normal_label">
                        Item #:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="ItemNumber">
                    </td>
                </tr>
                <tr>
                    <td class="normal_label">
                        Description:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="Description">
                    </td>
                </tr>
                <tr>
                    <td class="normal_label">
                        Size:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="Size">
                    </td>
                </tr>
                <tr>
                    <td class="normal_label">
                        Form:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="Form">
                    </td>
                </tr>
                <tr id="rowNDC" runat="server">
                    <td class="normal_label">
                        NDC #:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="NDC">
                    </td>
                </tr>
                <tr id="rowUPC" runat="server">
                    <td class="normal_label">
                        Box UPC:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="UPC">
                    </td>
                </tr>
                <tr id="rowUnitUPC" runat="server">
                    <td class="normal_label">
                        Unit UPC:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="SellUPC">
                    </td>
                </tr>
                <tr id="rowCaseUPC" runat="server">
                    <td class="normal_label">
                        Case UPC:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="CaseUPC">
                    </td>
                </tr>
                <tr>
                    <td class="normal_label">
                        Case Qty:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="SellUnit">
                    </td>
                </tr>
                <tr>
                    <td class="normal_label">
                        Manufacturer:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="Manufacturer">
                    </td>
                </tr>
                <tr>
                    <td class="normal_label">
                        Class:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="Class">
                    </td>
                </tr>
                <tr>
                    <td class="normal_label">
                        Price:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="Price">
                    </td>
                </tr>
                <tr id="rowRetail" runat="server">
                    <td class="normal_label">
                        Retail:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="RetailPrice">
                    </td>
                </tr>
                <tr id="rowRetailQty" runat="server">
                    <td class="normal_label">
                        Retail Qty:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="RetailQty">
                    </td>
                </tr>
                <tr id="rowRetailUOM" runat="server">
                    <td class="normal_label">
                        Retail UOM:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="RetailUOM">
                    </td>
                </tr>
                <tr>
                    <td class="normal_label">
                        Comments:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="Comments">
                    </td>
                </tr>
                <tr>
                    <td class="normal_label">
                        Web Desc 1:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="WebComment1">
                    </td>
                </tr>
                <tr>
                    <td class="normal_label">
                        Web Desc 2:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="WebComment2">
                    </td>
                </tr>
                <tr>
                    <td class="normal_label">
                        Web Desc 3:
                    </td>
                    <td class="ii_column_spacer">
                    </td>
                    <td class="normal_readonly_value" id="WebComment3">
                    </td>
                </tr>
            </table>
        </div>
        <div id="ii_image_div">
            <img id='ii_image' src="" alt='Item Image' />
        </div>
    </div>
    </form>
</body>
</html>
