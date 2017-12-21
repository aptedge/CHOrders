<%@ Page Language="vb" AutoEventWireup="false" Inherits="Documents" CodeFile="Documents.aspx.vb" %>
<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header_tp" Src="controls/page_header_tp.ascx" %>
<%@ Reference Control="~/controls/page_header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header" Src="controls/page_header.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title><% =lbl_title%></title>
        <link rel="icon" href="favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
        <link rel="stylesheet" href="/css/TPS.css" />
        <link rel="stylesheet" href="/css/TPWebPortal.css" />
        <link rel="stylesheet" href="/css/LayoutStyle.css" />
        <link rel="stylesheet" href="/css/Reports.css" />
    </head>

	<body id="body" runat="server">

    <form id="Form1" method="post" runat="server">
  
	<div id="header_new" runat="server" visible="false"><uc1:page_header_tp id="page_header_tp" runat="server"></uc1:page_header_tp></div>
	<div id="header" runat="server" visible="false"><uc1:page_header id="page_header" runat="server"></uc1:page_header></div>

    <div id="container"> 
    
    <table id="report_header_div" runat="server" style="width:100%; border:none; margin-top:20px;margin-bottom:5px" cellspacing="0" cellpadding="0">
        <tr align="center">
            <td style="text-align:center; height:40px" colspan="4" >
                <asp:label runat="server" ID="message" Text="To download or view a selection click on the filename"></asp:label>
            </td>
        </tr>
    </table>

    <table style="width:100%; border:none;" cellspacing="0" cellpadding="0">
        <tr>
            <td class="normal_label" style="text-align:center;">
                <asp:datagrid id="item_list" runat="server" Width="30%" GridLines="none" style="margin:auto; width:30%" AllowSorting="true" AutoGenerateColumns="False" AllowPaging="false" PageSize="25" EnableViewState="true">
                <AlternatingItemStyle CssClass="tr_odd_1" />
        	    <ItemStyle CssClass="tr_even_1" />
        	    <HeaderStyle CssClass="report_header_new" />
        	    <Columns>
            	    <asp:TemplateColumn SortExpression="NAME" HeaderText="Filename">
                        <HeaderStyle CssClass="Description_TITLE" />
        			    <ItemTemplate><div id="Description_DATA_DOC"><asp:linkbutton runat="server" ID="name" Text='<%# DataBinder.Eval(Container.DataItem, "NAME")%>' CommandName="download" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "NAME") %>' ForeColor="black" /></div></ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
                </asp:datagrid>
            </td>
        </tr>
    </table>

    </div>

    </form>
</body>
</html>
