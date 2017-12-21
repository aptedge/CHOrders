<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BrandTracking.aspx.cs" Inherits="BrandTracking" %>
<%@ Register TagPrefix="bdp" Namespace="BasicFrame.WebControls" Assembly="BasicFrame.WebControls.BasicDatePicker" %>
<%@ Reference Control="~/controls/page_header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header" Src="controls/page_header.ascx" %>
<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header_tp" Src="controls/page_header_tp.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BRAND TRACKING</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 

    <link rel="stylesheet" href="/css/TPS.css" />
    <link rel="stylesheet" href="/css/TPWebPortal.css" />
    <link rel="stylesheet" href="/css/LayoutStyle.css" />
    <link rel="stylesheet" href="/css/Reports.css" />
    
    <script src="script/json2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-ui-1.8.4.custom.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="script/tooltip/tiptip.css" />
    <script src="script/tooltip/jquery.tipTip.js" type="text/javascript"></script>
    <script src="script/tooltip/jquery.tipTip.minified.js" type="text/javascript"></script>
    <script src="script/date.format.js" type="text/javascript"></script>
    <script src="script/utility.js" type="text/javascript"></script>
    <script type="text/javascript">
        function noBack() { window.history.forward() }
        noBack();
        window.onload = noBack;
        window.onpageshow = function (evt) { if (evt.persisted) noBack() }
        window.onunload = function () { void (0) }
    </script>
</head>

<body id="body" runat="server">

    <form id="form1" runat="server">

	<div id="header_new" runat="server" visible="false"><uc1:page_header_tp id="page_header_tp" runat="server"></uc1:page_header_tp></div>
	<div id="header" runat="server" visible="false"><uc1:page_header id="page_header" runat="server"></uc1:page_header></div>

    <div id="container"> 
    
    <input type='hidden' id='CustomerNo' runat='server' />

    <table style="width:100%; border:none; margin-top:20px;margin-bottom:5px" cellspacing="0" cellpadding="0">
        <tr style="height: 35px;">
            <td class="normal_label" style="text-align:center;">
                Date(s) <bdp:BDPLite ID="date_start" TextBoxStyle-Width="80px" TextBoxStyle-Height="18px" ButtonImageHeight="18px" ShowCalendarOnTextBoxFocus="true" DateFormat="ShortDate" runat="server"></bdp:BDPLite>
                &nbsp;&nbsp;To&nbsp;&nbsp;
                <bdp:BDPLite ID="date_end" TextBoxStyle-Width="80px" TextBoxStyle-Height="18px" ButtonImageHeight="18px" ShowCalendarOnTextBoxFocus="true" DateFormat="ShortDate" runat="server"></bdp:BDPLite>
            </td>
        </tr>
        <tr style="height:35px;">
            <td class='normal_label' style="text-align:center">
                <asp:DropDownList ID="brand_family_dropdown" runat="server" CssClass='search_params_dropdown_class' />
            </td>
        </tr>
        <tr style="height:35px;">
            <td class='normal_label' style="text-align:center">
                Target Pct <asp:TextBox ID="target_pct" runat="server" CssClass='search_params_textbox_class' />
            </td>
        </tr>
        <tr style="height: 40px;" >
            <td style="text-align:center">
                <asp:button runat="server" class='normal_button' id="report_button" OnClick="Run_Click" Text=" Calculate Now "/>
            </td>
        </tr>
        <tr style="height: 40px;" >
            <td style="text-align:center">
                <asp:label runat="server" id="message" ForeColor="Red" Text="" />
            </td>
        </tr>
    </table>

    <table style="width:100%; border:none; margin-top:20px;margin-bottom:5px" cellspacing="0" cellpadding="0">
        <tr style="height:30px">
            <td class='normal_label' style="text-align:right; width:50%;">
                Current Sales Pct&nbsp;
            </td>
            <td class='normal_label' style="text-align:left; width:50%;">
                <asp:TextBox ID="sales_current_pct" runat="server" ReadOnly CssClass='search_params_textbox_class' />
            </td>
        </tr>
        <tr style="height:30px">
            <td class='normal_label' style="text-align:right; width:50%;">
                Total Brand Sales&nbsp;
            </td>
            <td class='normal_label' style="text-align:left; width:50%;">
                <asp:TextBox ID="sales_brand" runat="server" ReadOnly CssClass='search_params_textbox_class' />
            </td>
        </tr>
        <tr style="height:30px">
            <td class='normal_label' style="text-align:right; width:50%;">
                Total Sales&nbsp;
            </td>
            <td class='normal_label' style="text-align:left; width:50%;">
                <asp:TextBox ID="sales_total" runat="server" ReadOnly CssClass='search_params_textbox_class' />
            </td>
        </tr>
        <tr style="height:30px">
            <td class='normal_label' style="text-align:right; width:50%;">
                Additional Units Required to Reach Target Pct&nbsp;
            </td>
            <td class='normal_label' style="text-align:left; width:50%;">
                <asp:TextBox ID="sales_additional" runat="server" ReadOnly CssClass='search_params_textbox_class' />
            </td>
        </tr>
    </table>

    <table style="width:100%; border:none;" cellspacing="0" cellpadding="0">
        <tr style="height: 40px;">-
            <td class="normal_label" style="text-align:center;">
                <asp:datagrid id="item_list" runat="server" Width="60%" GridLines="none" style="margin:auto; width:60%" AllowSorting="true" AutoGenerateColumns="False" AllowPaging="false" EnableViewState="true">
                <AlternatingItemStyle CssClass="tr_odd_1" />
        	    <ItemStyle CssClass="tr_even_1" />
        	    <HeaderStyle CssClass="report_header_new" />

        	    <Columns>
            	    <asp:TemplateColumn SortExpression="ITVSUF" HeaderText="Brand">
                        <HeaderStyle CssClass="Description_TITLE_SHORT" />
        			    <ItemTemplate><div id="Description_DATA_SHORT"><asp:label Runat="server" id="ITVSUF"><%#DataBinder.Eval(Container.DataItem, "ITVSUF")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="GREFDT" HeaderText="Description">
                        <HeaderStyle CssClass="Description_TITLE" />
        			    <ItemTemplate><div id="Description_DATA"><asp:label Runat="server" id="GREFDT"><%#DataBinder.Eval(Container.DataItem, "GREFDT")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="SALES" HeaderText="Sales">
                        <HeaderStyle CssClass="Price_TITLE_NEW" />
        			    <ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" id="SALES"><%# DataBinder.Eval(Container.DataItem, "SALES").ToString()%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="CREDITS" HeaderText="Credits">
                        <HeaderStyle CssClass="Price_TITLE_NEW" />
        			    <ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" id="CREDITS"><%#DataBinder.Eval(Container.DataItem, "CREDITS")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="TOTAL" HeaderText="Total">
                        <HeaderStyle CssClass="Price_TITLE_NEW" />
        			    <ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" id="TOTAL"><%#DataBinder.Eval(Container.DataItem, "TOTAL")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="PCT" HeaderText="%">
                        <HeaderStyle CssClass="Price_TITLE_NEW" />
        			    <ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" id="PCT"><%#DataBinder.Eval(Container.DataItem, "PCT")%></asp:label></div></ItemTemplate>
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
