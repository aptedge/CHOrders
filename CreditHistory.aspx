<%@ Page Language="vb" AutoEventWireup="false" Inherits="CreditHistory" CodeFile="CreditHistory.aspx.vb" %>
<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header_tp" Src="controls/page_header_tp.ascx" %>
<%@ Reference Control="~/controls/page_header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header" Src="controls/page_header.ascx" %>
<%@ Register TagPrefix="bdp" Namespace="BasicFrame.WebControls" Assembly="BasicFrame.WebControls.BasicDatePicker" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>Credits</title>
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
    
    <table style="width:100%; border:none;" cellspacing="0" cellpadding="0">
        <tr align="center">
            <td class="normal_label" id="iandc_search_number_label" style="text-align:center">
                Credit No&nbsp;<asp:textbox class="normal_input" runat="server" style="width: 80px;" id='credit_number' maxlength='7' onkeypress="JavaScript:return NumbersOnly(event);" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
                <asp:datagrid id="item_list" runat="server" Width="30%" style="margin:auto; width:30%" GridLines="none" AllowSorting="true" AutoGenerateColumns="False"  AllowPaging="true" PageSize="25" EnableViewState="true">
                <AlternatingItemStyle CssClass="tr_odd_1" />
        	    <ItemStyle CssClass="tr_even_1" />
        	    <HeaderStyle CssClass="report_header_new" />

        	    <Columns>
            	    <asp:TemplateColumn SortExpression="CHARNO" HeaderText="Credit&nbsp;No">
                        <HeaderStyle CssClass="Price_TITLE_NEW" />
        			    <ItemTemplate><div id="Price_DATA2"><a style="text-decoration:none; color:black;" href='CreditDetail.aspx?no=<%# DataBinder.Eval(Container.DataItem, "CHARNO") %>&dt=<%# DataBinder.Eval(Container.DataItem, "CHCMDT") %>'><%# DataBinder.Eval(Container.DataItem, "CHARNO")%></a></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="CHCMDT" HeaderText="Date">
                        <HeaderStyle CssClass="Date_TITLE" />
        			    <ItemTemplate><div id="Date_DATA"><%# DataBinder.Eval(Container.DataItem, "CrdDate")%></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="CHTAMT" HeaderText="Amount">
                        <HeaderStyle CssClass="Price_TITLE_NEW" />
        			    <ItemTemplate><div id="Price_DATA2"><%# DataBinder.Eval(Container.DataItem, "CHTAMT")%></div></ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
                <PagerStyle CssClass="PagerControl" HorizontalAlign="Center" Height="23px" ForeColor="Blue" BackColor="#A9D0F5" Wrap="False" Mode="NumericPages" PageButtonCount="10" ></PagerStyle>
                </asp:datagrid>
            </td>
        </tr>
    </table>

    </div>
          
    </form>
</body>

</html>
