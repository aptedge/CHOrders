<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header_tp" Src="controls/page_header_tp.ascx" %>
<%@ Reference Control="~/controls/page_header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header" Src="controls/page_header.ascx" %>
<%@ Register TagPrefix="bdp" Namespace="BasicFrame.WebControls" Assembly="BasicFrame.WebControls.BasicDatePicker" %>
<%@ Page Language="vb" AutoEventWireup="false" Inherits="InvoiceHistory" CodeFile="InvoiceHistory.aspx.vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<head>
	<title>Invoices</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
	<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
	<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />

    <link rel="stylesheet" href="/css/TPS.css" />
    <link rel="stylesheet" href="/css/TPWebPortal.css" />
    <link rel="stylesheet" href="/css/LayoutStyle.css" />
    <link rel="stylesheet" href="/css/Reports.css" />

    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
</head>
	
<body id="body" runat="server">
	<form id="Form1" method="post" runat="server">

	<div><uc1:page_header_tp id="page_header_tp" runat="server" visible="false"></uc1:page_header_tp></div>
	<div><uc1:page_header id="page_header" runat="server" visible="false"></uc1:page_header></div>

    <div id="container"> 
    
    <table style="width:100%; border:none;" cellspacing="0" cellpadding="0">
        <tr align="center">
            <td class="normal_label" id="iandc_search_number_label" style="text-align:center">
                Invoice No&nbsp;<asp:textbox class="normal_input" runat="server" style="width: 80px;" id='inv_number' maxlength='7' onkeypress="JavaScript:return NumbersOnly(event);" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
                <asp:datagrid id="item_list" Width="70%" style="margin:auto; width:70%" GridLines="none" runat="server" AllowSorting="true" AutoGenerateColumns="False"  AllowPaging="true" PageSize="25" EnableViewState="true">
                <AlternatingItemStyle CssClass="tr_odd_1" />
        	    <ItemStyle CssClass="tr_even_1" />
        	    <HeaderStyle CssClass="report_header_new" />

        	    <Columns>
            	    <asp:TemplateColumn SortExpression="IRINV#" HeaderText="Invoice&nbsp;No">
                        <HeaderStyle CssClass="ItemNo_TITLE2" />
        			    <ItemTemplate><div id="ItemNo_DATA"><a style="text-decoration:none; color:black;" href='InvoiceDetail.aspx?no=<%# DataBinder.Eval(Container.DataItem, "IRINV#") %>&dt=<%# DataBinder.Eval(Container.DataItem, "IRIVDT") %>&amt=<%# DataBinder.Eval(Container.DataItem, "IR$AMT") %>'><%# DataBinder.Eval(Container.DataItem, "IRINV#")%></a></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="IRIVDT" HeaderText="Invoice Date">
                        <HeaderStyle CssClass="Date_TITLE" />
        			    <ItemTemplate><div id="Date_DATA"><%# DataBinder.Eval(Container.DataItem, "InvDate")%></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="IRODAT" HeaderText="Order Date">
                        <HeaderStyle CssClass="Date_TITLE" />
        			    <ItemTemplate><div id="Date_DATA"><%# DataBinder.Eval(Container.DataItem, "OrdDate")%></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="IRORD" HeaderText="Order&nbsp;No">
                        <HeaderStyle CssClass="ItemNo_TITLE2" />
        			    <ItemTemplate><div id="ItemNo_DATA"><%# DataBinder.Eval(Container.DataItem, "IRORD") %></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="ORDLIN" HeaderText="Lines">
                        <HeaderStyle CssClass="ItemNo_TITLE2" />
        			    <ItemTemplate><div id="ItemNo_DATA"><%# DataBinder.Eval(Container.DataItem, "ORDLIN")%></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="IR$AMT" HeaderText="Amount">
                        <HeaderStyle CssClass="Price_TITLE_NEW" />
        			    <ItemTemplate><div id="Price_DATA2"><%# DataBinder.Eval(Container.DataItem, "IR$AMT")%></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="SHIPPER" HeaderText="Shipper">
                        <HeaderStyle CssClass="Description_TITLE_SHORT" />
        			    <ItemTemplate><div id="Description_DATA_SHORT"><%# DataBinder.Eval(Container.DataItem, "SHIPPER")%></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="IRSCAR" HeaderText="Tracking No">
                        <HeaderStyle CssClass="Description_TITLE_SHORT" />
        			    <ItemTemplate><div id="Description_DATA_SHORT"><%# DataBinder.Eval(Container.DataItem, "IRSCAR")%></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="ORDRUT" HeaderText="Route No">
                        <HeaderStyle CssClass="Price_TITLE_NEW" />
        			    <ItemTemplate><div id="Price_DATA2"><%# DataBinder.Eval(Container.DataItem, "RTENUM")%></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="RUDESC" HeaderText="Route Desc">
                        <HeaderStyle CssClass="Description_TITLE" />
        			    <ItemTemplate><div id="Description_DATA"><%# DataBinder.Eval(Container.DataItem, "RUDESC")%></div></ItemTemplate>
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
