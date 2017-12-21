<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header_tp" Src="controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="bdp" Namespace="BasicFrame.WebControls" Assembly="BasicFrame.WebControls.BasicDatePicker" %>
<%@ Page Language="vb" AutoEventWireup="false" Inherits="CSOSVendors" CodeFile="CSOSVendors.aspx.vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<head>
	<title>Vendors</title>
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
                        <asp:CheckBox ID="cb_csos_only" Checked="true" Text="&nbsp;Active&nbsp;CSOS&nbsp;Vendors&nbsp;Only" runat="server" />
                    </td>
                    <td id="iandc_search_spacer3" style="width:40px">
                    </td>
                    <td class="normal_label" id="iandc_search_number_label">
                        Vendor #:
                    </td>
                    <td id="iandc_search_number_value">
                        <asp:textbox class="normal_input" runat="server" style="width: 80px;" id='vendor_number' 
                            maxlength='7' onkeypress="JavaScript:return NumbersOnly(event);" />
                    </td>
                    <td id="iandc_search_spacer3" style="width:30px">
                    </td>
                    <td>
                        <asp:button runat="server" class='normal_button' id="search_button" Text=" Search "/>
                    </td>
                </tr>
                <tr>
                </tr>
            </table>
        </div>
       
        <div id="repeating_table" style="margin-left:-30px">
            <asp:datagrid id="item_list" runat="server" AllowSorting="true" AutoGenerateColumns="False"  AllowPaging="false" EnableViewState="true">
            <AlternatingItemStyle CssClass="tr_odd_1" />
        	<ItemStyle CssClass="tr_even_1" />
        	<HeaderStyle CssClass="report_header_new" />

        	<Columns>
            	<asp:TemplateColumn SortExpression="VNDNUM" HeaderText="Vendor&nbsp;#">
                    <HeaderStyle CssClass="Price_TITLE_NEW" />
        			<ItemTemplate><div id="Price_DATA2"><%# DataBinder.Eval(Container.DataItem, "VNDNUM")%></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="VNDLNM" HeaderText="Name">
                    <HeaderStyle CssClass="Description_TITLE" />
        			<ItemTemplate><div id="Description_DATA"><%# DataBinder.Eval(Container.DataItem, "VNDLNM")%></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="VNDDEA" HeaderText="DEA&nbsp;#">
                    <HeaderStyle CssClass="UPC_TITLE" />
        			<ItemTemplate><div id="UPC_DATA"><%# DataBinder.Eval(Container.DataItem, "VNDDEA")%></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="VNDSTR" HeaderText="Address">
                    <HeaderStyle CssClass="Description_TITLE" />
        			<ItemTemplate><div id="Description_DATA"><%# DataBinder.Eval(Container.DataItem, "VNDSTR")%></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="VNDCTY" HeaderText="City">
                    <HeaderStyle CssClass="City_TITLE" />
        			<ItemTemplate><div id="City_DATA"><%# DataBinder.Eval(Container.DataItem, "VNDCTY")%></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="VNDSTA" HeaderText="State">
                    <HeaderStyle CssClass="State_TITLE" />
        			<ItemTemplate><div id="State_DATA"><%# DataBinder.Eval(Container.DataItem, "VNDSTA")%></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="VNDZIP" HeaderText="&nbsp;&nbsp;Zip">
                    <HeaderStyle CssClass="Zip_TITLE" />
        			<ItemTemplate><div id="Zip_DATA"><%# DataBinder.Eval(Container.DataItem, "VNDZIP")%></div></ItemTemplate>
                </asp:TemplateColumn>
			    <asp:TemplateColumn HeaderText="">
                    <HeaderStyle CssClass="command_TITLE" />
				    <ItemTemplate><div id="command_DATA"><asp:button ID="button_activate" Runat="server" CommandName="activate" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "VNDNUM")%>' Font-Size="8" ForeColor="Black" Visible='<%# DataBinder.Eval(Container.DataItem, "show_activate")%>' Text=" Activate " BackColor="#99FF66" Height="16" BorderStyle="None"  style="cursor: pointer" OnClientClick="return confirm('Do you really want to activate this vendor?');"/></div></ItemTemplate>
			    </asp:TemplateColumn>
            </Columns>
            </asp:datagrid>
        </div>  
    </div>
          
    </div>

    </form>
</body>

</html>
