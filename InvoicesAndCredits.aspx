<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvoicesAndCredits.aspx.cs" Inherits="InvoicesAndCredits" %>
<%@ Register TagPrefix="bdp" Namespace="BasicFrame.WebControls" Assembly="BasicFrame.WebControls.BasicDatePicker" %>
<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header" Src="controls/page_header_tp.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Invoices</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
    <link rel="stylesheet" href="css/TPWebPortal.css" />
    <link rel="stylesheet" href="css/InvoicesAndCredits.css" />
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
    <script src="script/TableHelper.js" type="text/javascript"></script>
    <script src="script/InvoicesAndCredits.js" type="text/javascript"></script>
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
                        <asp:Label runat="server" ID="lblTitle" Text="Invoices" />
                    </td>
                </tr>
            </table>
        </div>

        <div id='inv_container'>

        <input type="hidden" id="CustNo" runat="server" />

        <div id="iandc_search_div">
            <table id="iandc_search_layout">
                <tr>
                    <td class="normal_label" id="iandc_search_type_label" runat="server">
                        Type:
                    </td>
                    <td id="iandc_search_type_value">
                        <asp:DropDownList ID="iandc_search_type_dropdown" runat="server" CssClass='iandc_search_type_dropdown' Enabled="false" />
                    </td>
                    <td id="iandc_search_spacer1">
                    </td>
                    <td class="normal_label" id="iandc_search_date_label">
                        Date(s):
                    </td>
                    <td class="normal_label" id="iandc_search_date_value">
                        <bdp:BDPLite ID="iandc_search_date_input" TextBoxStyle-Width="80px" ButtonImageHeight="18px" ShowCalendarOnTextBoxFocus="true" DateFormat="ShortDate" runat="server"></bdp:BDPLite>
                    </td>
                    <td class="normal_label" id="iandc_search_to_date_label">
                        &nbsp;&nbsp;To&nbsp;&nbsp;
                    </td>
                    <td class="normal_label" id="iandc_search_to_date_value">
                        <bdp:BDPLite ID="iandc_search_to_date_input" TextBoxStyle-Width="80px" ButtonImageHeight="18px" ShowCalendarOnTextBoxFocus="true" DateFormat="ShortDate" runat="server"></bdp:BDPLite>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td class="normal_label" id="iandc_search_number_label">
                        Invoice/Credit No:
                    </td>
                    <td id="iandc_search_number_value">
                        <input class="normal_input" type='text' id='iandc_search_number_input' 
                            maxlength='7' onkeypress="JavaScript:return NumbersOnly(event);" />
                    </td>
                    <td id="iandc_search_spacer3">
                    </td>
                    <td>
                        <input type='button' id='iandc_search_button' class='normal_button' value='Search' />
                    </td>
                </tr>
            </table>
        </div>
        <div id="iandc_i_search_results_div">
            <table class='normal' id='iandc_i_search_results_table' cellpadding='0' cellspacing='0'>
                <thead>
                    <tr class='normal_header'>
                        <th class='Date'>
                            Invoice Date
                        </th>
                        <th class='InvoiceNo'>
                            Invoice<br />Number
                        </th>
                        <th class='OrderNo'>
                            Order<br />Number
                        </th>
                        <th class='PONumber'>
                            PO Number
                        </th>
                        <th class='Amount'>
                            Amount
                        </th>
                        <th class='command manifest_preview_cmd' id='manifest_preview_cmd'>
                            <div id='manifest_preview' runat="server" visible="false" >
                            Manifest
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <!-- <tr>'s are added in javascript -->
                </tbody>
            </table>
        </div>
        <div id="iandc_c_search_results_div">
            <table class='normal' id='iandc_c_search_results_table' cellpadding='0' cellspacing='0'>
                <thead>
                    <tr class='normal_header'>
                        <th class='CreditDate'>
                            Date
                        </th>
                        <th class='CreditNumber'>
                            Credit Number
                        </th>
                        <th class='Amount'>
                            Amount
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
