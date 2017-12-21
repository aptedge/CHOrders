<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header_tp" Src="controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="bdp" Namespace="BasicFrame.WebControls" Assembly="BasicFrame.WebControls.BasicDatePicker" %>
<%@ Page Language="vb" AutoEventWireup="false" Inherits="InvoiceHistory" CodeFile="CSOSPurchaseOrders.aspx.vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<head>
	<title>Purchase Orders</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
	<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
	<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
    <link rel="stylesheet" href="css/TPWebPortal.css" />
    <link rel="stylesheet" href="css/LayoutStyle.css" />
    <link rel="stylesheet" href="css/Reports.css" />
    <link rel="stylesheet" href="css/OpenOrders.css" />
    <link rel="stylesheet" href="css/EditOrder.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
</head>
	
<body>
	<form id="Form1" method="post" runat="server">

    <div id="container"> 
    
	<div id="header" runat="server"><uc1:page_header_tp id="page_header_tp" runat="server"></uc1:page_header_tp></div>

    <div id="page_body" class="block_adjust">
       
        <div id="po_table_header">
            <table>
                <tr>
                    <td class='normal_label' colspan="3">
                        <asp:CheckBox ID="cb_open_only" Checked="true" Text="&nbsp;Open&nbsp;POs&nbsp;Only" runat="server" />
                    </td>
                    <td id="iandc_search_spacer3" style="width:40px">
                    </td>
                    <td class="normal_label" id="iandc_search_number_label">
                        PO #:
                    </td>
                    <td id="iandc_search_number_value">
                        <asp:textbox class="normal_input" runat="server" style="width: 80px;" id='inv_number' 
                            maxlength='7' onkeypress="JavaScript:return NumbersOnly(event);" />
                    </td>
                    <td id="iandc_search_spacer3">
                    </td>
                    <td class="normal_label" style="width:70px; text-align:right;">
                        Date(s):
                    </td>
                    <td class="normal_label" style="width:120px">
                        <bdp:BDPLite ID="date_start" TextBoxStyle-Width="80px" TextBoxStyle-Height="19px" ButtonImageHeight="18px" ShowCalendarOnTextBoxFocus="true" DateFormat="ShortDate" runat="server"></bdp:BDPLite>
                    </td>
                    <td class="normal_label">
                        &nbsp;&nbsp;To&nbsp;&nbsp;
                    </td>
                    <td class="normal_label" style="width:120px">
                        <bdp:BDPLite ID="date_end" TextBoxStyle-Width="80px" TextBoxStyle-Height="19px" ButtonImageHeight="18px" ShowCalendarOnTextBoxFocus="true" DateFormat="ShortDate" runat="server"></bdp:BDPLite>
                    </td>
                    <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;<asp:button runat="server" class='normal_button' id="search_button" Text=" Search "/>
                    </td>
                </tr>
                <tr>
                </tr>
            </table>
        </div>

        <div id="repeating_table" style="margin-left:0px">
            <asp:datagrid id="item_list" runat="server" AllowSorting="true" AutoGenerateColumns="False"  AllowPaging="false" EnableViewState="true">
            <AlternatingItemStyle CssClass="tr_odd_1" />
        	<ItemStyle CssClass="tr_even_1" />
        	<HeaderStyle CssClass="report_header_new" />

        	<Columns>
            	<asp:TemplateColumn SortExpression="WPMNUM" HeaderText="PO&nbsp;#">
                    <HeaderStyle CssClass="Price_TITLE_NEW" />
        			<ItemTemplate><div id="Price_DATA2"><a style="text-decoration:none; color:black;" href='CSOSPODetail.aspx?no=<%# DataBinder.Eval(Container.DataItem, "WPMNUM")%>'><%# DataBinder.Eval(Container.DataItem, "WPMNUM")%></a></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="VNDLNM" HeaderText="Vendor">
                    <HeaderStyle CssClass="Description_TITLE" />
        			<ItemTemplate><div id="Description_DATA"><%# DataBinder.Eval(Container.DataItem, "VNDLNM")%></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="Status" HeaderText="Status">
                    <HeaderStyle CssClass="POStatus_TITLE" />

        			<ItemTemplate><div id="POStatus_DATA"><%# DataBinder.Eval(Container.DataItem, "Status")%></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="POMDAT" HeaderText="Date">
                    <HeaderStyle CssClass="Date_TITLE_SHORT" />
        			<ItemTemplate><div id="Date_DATA"><%# DataBinder.Eval(Container.DataItem, "PODate")%></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="POMITO" HeaderText="Lines">
                    <HeaderStyle CssClass="Line_TITLE" />
        			<ItemTemplate><div id="Line_DATA"><%# DataBinder.Eval(Container.DataItem, "POMITO")%></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="POMAMT" HeaderText="Amount">
                    <HeaderStyle CssClass="Price_TITLE_EXT" />
        			<ItemTemplate><div id="Price_DATA_EXT"><%# DataBinder.Eval(Container.DataItem, "POMAMT")%></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="WPMBLN" HeaderText="DEA&nbsp;Blank&nbsp;#">
                    <HeaderStyle CssClass="BLANK_TITLE" />
        			<ItemTemplate><div id="BLANK_DATA"><%# DataBinder.Eval(Container.DataItem, "WPMBLN")%></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="WPEMSG" HeaderText="Message">
                    <HeaderStyle CssClass="Message_TITLE" />
        			<ItemTemplate><div id="Message_DATA"><%# DataBinder.Eval(Container.DataItem, "WPEMSG")%></div></ItemTemplate>
                </asp:TemplateColumn>
			    <asp:TemplateColumn HeaderText="">
                    <HeaderStyle CssClass="command_TITLE" />
				    <ItemTemplate><div id="command_DATA"><asp:button ID="button_resend" Runat="server" CommandName="resend" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "WPMNUM")%>' Font-Size="8" ForeColor="Black" Visible='<%# DataBinder.Eval(Container.DataItem, "show_resend")%>' Text=" Resend " BackColor="#99FF66" Height="16" BorderStyle="None"  style="cursor: pointer" OnClientClick="return confirm('Do you really want to resend this Purchase Order to Express 222?');"/></div></ItemTemplate>
			    </asp:TemplateColumn>
            </Columns>
            <PagerStyle CssClass="PagerControl" HorizontalAlign="Center" Height="23px" ForeColor="Blue" BackColor="#A9D0F5" Wrap="False" Mode="NumericPages" PageButtonCount="10" ></PagerStyle>
            </asp:datagrid>
        </div>  
    </div>
          
    </div>

    </form>
</body>

</html>
