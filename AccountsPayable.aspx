<%@ Page Language="vb" AutoEventWireup="false" Inherits="AP" CodeFile="AccountsPayable.aspx.vb" %>
<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header_tp" Src="controls/page_header_tp.ascx" %>
<%@ Reference Control="~/controls/page_header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header" Src="controls/page_header.ascx" %>
<%@ Register TagPrefix="bdp" Namespace="BasicFrame.WebControls" Assembly="BasicFrame.WebControls.BasicDatePicker" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>Accounts Payable</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 

    <link rel="stylesheet" href="/css/TPS.css" />
    <link rel="stylesheet" href="/css/TPWebPortal.css" />
    <link rel="stylesheet" href="/css/LayoutStyle.css" />
    <link rel="stylesheet" href="/css/Reports.css" />

    <script src="script/json2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-ui-1.8.4.custom.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery.formatCurrency-1.4.0.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="script/tooltip/tiptip.css" />
    <script src="script/tooltip/jquery.tipTip.js" type="text/javascript"></script>
    <script src="script/tooltip/jquery.tipTip.minified.js" type="text/javascript"></script>
    <script src="script/utility.js" type="text/javascript"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
</head>
	
<body id="body" runat="server">
	<form id="Form1" method="post" runat="server">

	<div id="header_new" runat="server" visible="false"><uc1:page_header_tp id="page_header_tp" runat="server"></uc1:page_header_tp></div>
	<div id="header" runat="server" visible="false"><uc1:page_header id="page_header" runat="server"></uc1:page_header></div>

    <div id="container"> 
    
    <input type="hidden" id="CustNo" runat="server" />

    <table style="width:100%; border:none; margin-top:15px;" cellspacing="0" cellpadding="0">
        <tr align="center">
            <td class="normal_label" style="text-align:center; font-size:14px">
                Amount&nbsp;Due&nbsp;&nbsp;<asp:label runat="server" Font-Bold="true" id="header_amount_due" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Last&nbsp;Payment&nbsp;&nbsp;<asp:label runat="server" Font-Bold="true" id="header_last_payment_amt" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Received&nbsp;On&nbsp;&nbsp;<asp:label runat="server" Font-Bold="true" id="header_last_payment_date" />
            </td>
        </tr>
    </table>

    <table style="width:100%; border:none; margin-top:15px;" cellspacing="0" cellpadding="0">
        <tr align="center">
            <td class="normal_label" id="iandc_search_number_label" style="text-align:center">
                Transaction No&nbsp;<asp:textbox class="normal_input" runat="server" style="width: 80px;" id='txn_number' maxlength='8' onkeypress="JavaScript:return NumbersOnly(event);" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Date(s)&nbsp;&nbsp;
                <bdp:BDPLite ID="date_start" TextBoxStyle-Height="16px" TextBoxStyle-Width="80px" ButtonImageHeight="18px" ShowCalendarOnTextBoxFocus="true" DateFormat="ShortDate" runat="server"></bdp:BDPLite>
                &nbsp;&nbsp;To&nbsp;&nbsp;
                <bdp:BDPLite ID="date_end" TextBoxStyle-Height="16px" TextBoxStyle-Width="80px" ButtonImageHeight="18px" ShowCalendarOnTextBoxFocus="true" DateFormat="ShortDate" runat="server"></bdp:BDPLite>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:button runat="server" class='normal_button' id="search_button" Text=" Search "/>
            </td>
        </tr>
    </table>

    <table style="width:100%; border:none; margin-top:20px;" cellspacing="0" cellpadding="0">
        <tr align="center">
            <td style="text-align:center">
                <asp:datagrid id="item_list" Width="50%" style="margin:auto; width:50%" GridLines="none" runat="server" AutoGenerateColumns="False"  AllowPaging="true" PageSize="25" EnableViewState="true">
                <AlternatingItemStyle CssClass="tr_odd_1" />
        	    <ItemStyle CssClass="tr_even_1" />
        	    <HeaderStyle CssClass="report_header_new" />

        	    <Columns>
            	    <asp:TemplateColumn HeaderText="Date&nbsp;&nbsp;&nbsp;&nbsp;">
                        <HeaderStyle CssClass="Date_TITLE_Right" />
        			    <ItemTemplate><div id="Date_DATA"><%# DataBinder.Eval(Container.DataItem, "TxnDate")%></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn HeaderText="Transaction&nbsp;No">
                        <HeaderStyle CssClass="ItemNo_TITLE2" />
        			    <ItemTemplate><div id="ItemNo_DATA"><%# DataBinder.Eval(Container.DataItem, "TxnNo") %></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn HeaderText="Type">
                        <HeaderStyle CssClass="Description_TITLE_SHORT" />
        			    <ItemTemplate><div id="Description_DATA_SHORT"><%# DataBinder.Eval(Container.DataItem, "TxnType")%></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn HeaderText="Amount">
                        <HeaderStyle CssClass="ItemNo_TITLE2" />
        			    <ItemTemplate><div id="ItemNo_DATA"><%# DataBinder.Eval(Container.DataItem, "Amount")%></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn HeaderText="Closed">
                        <HeaderStyle CssClass="command_TITLE" />
        			    <ItemTemplate><div id="command_DATA">&nbsp;&nbsp;&nbsp;<asp:imagebutton ID="Closed" runat="server" ImageUrl='/images/x.png' Height="16" BorderColor="0" Visible='<%# DataBinder.Eval(Container.DataItem, "Closed")%>'  /></div></ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
                <PagerStyle CssClass="PagerControl" HorizontalAlign="Center" Height="23" ForeColor="Blue" BackColor="#A9D0F5" Wrap="False" Mode="NumericPages" PageButtonCount="10" ></PagerStyle>
                </asp:datagrid>
            </td>
        </tr>
    </table>

    </div>
          
    </form>
</body>

</html>
