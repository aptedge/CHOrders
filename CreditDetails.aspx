<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreditDetails.aspx.cs" Inherits="CreditDetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CREDIT DETAIL</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
    <link rel="stylesheet" href="css/TPWebPortal.css" />
    <link rel="stylesheet" href="css/CreditDetails.css" />
    <script src="script/json2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-ui-1.8.4.custom.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="script/tooltip/tiptip.css" />
    <script src="script/tooltip/jquery.tipTip.js" type="text/javascript"></script>
    <script src="script/tooltip/jquery.tipTip.minified.js" type="text/javascript"></script>
    <script src="script/date.format.js" type="text/javascript"></script>
    <script src="script/utility.js" type="text/javascript"></script>
    <script src="script/TableHelper.js" type="text/javascript"></script>
    <script src="script/CreditDetails.js" type="text/javascript"></script>
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
    <div>
        <input type="hidden" id="CustNo" runat="server" />
        <input type="hidden" id="CreditNo" runat="server" />
        <input type="hidden" id="CreditDate" runat="server" />
        <input type="hidden" id="Amount" runat="server" />
        <div id="credit_caption_bar_div">
            <table class="caption_bar" id="credit_caption_bar">
                <tr>
                    <td>
                        <label id="caption_label">
                            Credit Detail</label>
                    </td>
                </tr>
            </table>
        </div>
        <div id="credit_header_div">
            <table id="credit_header_layout">
                <tr>
                    <td class="normal_label" id="credit_header_credit_no_label">
                        Credit No:
                    </td>
                    <td class="normal_readonly_value" id="credit_header_credit_no_value">
                    </td>
                    <td id="credit_header_spacer1">
                    </td>
                    <td class="normal_label" id="credit_header_date_label">
                        Credit Date:
                    </td>
                    <td class="normal_readonly_value" id="credit_header_date_value">
                    </td>
                    <td id="credit_header_spacer2">
                    </td>
                    <td class="normal_label" id="credit_header_amount_label">
                        Amount:
                    </td>
                    <td class="normal_readonly_value" id="credit_header_amount_value">
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td><asp:linkbutton id="export_link" runat="server" ToolTip="Export To CSV"><img src="images/button_export.png" border="0" alt="" /></asp:linkbutton></td>
                    <td colspan="7">&nbsp;Export To CSV</td>
                </tr>
            </table>
        </div>
        <div id="credit_items_div">
            <table class='normal' id='credit_items_table' cellpadding='0' cellspacing='0'>
                <thead>
                    <tr class='normal_header'>
                        <th class='ItemNumber'>
                            Item #
                        </th>
                        <th class='Description'>
                            Description
                        </th>
                        <th class='UPC'>
                            Box UPC
                        </th>
                        <th class='Price'>
                            Price
                        </th>
                        <th class='Size'>
                            Size
                        </th>
                        <th class='CreditQty'>
                            Qty&nbsp;
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <!-- <tr>'s are added in javascript -->
                </tbody>
            </table>
        </div>

        <asp:datagrid id="item_list" runat="server" AllowSorting="true" AutoGenerateColumns="False" AllowPaging="false" EnableViewState="true" Visible="true">
        <AlternatingItemStyle CssClass="tr_odd" />
        <ItemStyle CssClass="tr_even" />
        <HeaderStyle CssClass="report_header" />
        <Columns>
            <asp:TemplateColumn SortExpression="CRITEM" HeaderText="Item #">
                <HeaderStyle CssClass="ItemNo_TITLE" />
        		<ItemTemplate><div id="ItemNo_DATA"><asp:label Runat="server" id="CRITEM"><%#DataBinder.Eval(Container.DataItem, "CRITEM")%></asp:label></div></ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn SortExpression="ITDESC" HeaderText="Description">
                <HeaderStyle CssClass="Description_TITLE" />
        		<ItemTemplate><div id="Description_DATA"><asp:label Runat="server" id="ITDESC"><%#DataBinder.Eval(Container.DataItem, "ITDESC")%></asp:label></div></ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn SortExpression="ITMUPC" HeaderText="Box UPC">
                <HeaderStyle CssClass="InvClass_TITLE" />
        		<ItemTemplate><div id="InvClass_DATA"><asp:label Runat="server" id="ITMUPC"><%#DataBinder.Eval(Container.DataItem, "ITMUPC")%></asp:label></div></ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn SortExpression="" HeaderText="Price">
                <HeaderStyle CssClass="ItemNo_TITLE" />
        		<ItemTemplate><div id="ItemNo_DATA"><asp:label Runat="server" id="CRCRTT"><%#DataBinder.Eval(Container.DataItem, "CRCRTT")%></asp:label></div></ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn SortExpression="ITSIZE" HeaderText="Size">
                <HeaderStyle CssClass="InvClass_TITLE" />
        		<ItemTemplate><div id="InvClass_DATA"><asp:label Runat="server" id="ITSIZE"><%#DataBinder.Eval(Container.DataItem, "ITSIZE")%></asp:label></div></ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn SortExpression="CRQTSR" HeaderText="Qty">
                <HeaderStyle CssClass="InvClass_TITLE" />
        		<ItemTemplate><div id="InvClass_DATA"><asp:label Runat="server" id="CRQTSR"><%#DataBinder.Eval(Container.DataItem, "CRQTSR")%></asp:label></div></ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
        </asp:datagrid>

    </div>
    </form>
</body>
</html>
