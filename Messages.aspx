<%@ Page Language="vb" EnableEventValidation ="false" AutoEventWireup="false" ValidateRequest="false" Inherits="Messages" CodeFile="Messages.aspx.vb" %>
<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header" Src="controls/page_header_tp.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<head>
    <title>Messages</title>

    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 

	<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
	<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
	<meta content="JavaScript" name="vs_defaultClientScript" />
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

    <link rel="stylesheet" href="css/TPS.css" />
    <link rel="stylesheet" href="css/TpWebPortal.css" />
    <link rel="stylesheet" href="css/LayoutStyle.css" />
    <link rel="stylesheet" href="css/Reports.css" />

    <script src="script/json2.min.js" type="text/javascript"></script>
</head>
	
<body runat="server" id="body">
    <form id="Form1" method="post" runat="server">

	<div id="header_new"><uc1:page_header id="page_header" runat="server"></uc1:page_header></div>

    <div id="container"> 
    
    <table style="width:100%; border:none; margin-top:20px;" cellspacing="0" cellpadding="0">
        <tr align="center">
            <td style="text-align:left;width:20%">
                &nbsp;
            </td>
            <td style="text-align:left; width:80%">
                <asp:CheckBox ID="show_hidden" runat="server" AutoPostBack="true" Text="&nbsp;Show Read Messages"/>
            </td>
        </tr>
    </table>

    <table style="width:100%; border:none; margin-top:20px;" cellspacing="0" cellpadding="0">
        <tr align="center">
            <td style="text-align:center">
                <asp:datagrid id="item_list" runat="server" Width="80%" style="margin:auto" BorderStyle="none" GridLines="none" AllowSorting="true" AutoGenerateColumns="False"  AllowPaging="false" EnableViewState="true">
                <AlternatingItemStyle CssClass="tr_odd_1" />
        	    <ItemStyle CssClass="tr_even_1" />
        	    <HeaderStyle CssClass="report_header_new" />
                <Columns>
         	        <asp:TemplateColumn HeaderText="Type">
                        <HeaderStyle CssClass="command_TITLE" />
                        <ItemTemplate><div id="command_DATA"><img align="middle" src='<%# DataBinder.Eval(Container.DataItem, "Icon")%>' height="40" hspace="1" border="0" alt="" /></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn HeaderText="Date">
                        <HeaderStyle CssClass="Date_TITLE" />
        			    <ItemTemplate><div id="Date_DATA"><asp:label Runat="server" id="MessageDate"><%#DataBinder.Eval(Container.DataItem, "MessageDate")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn HeaderText="Expires">
                        <HeaderStyle CssClass="Date_TITLE" />
        			    <ItemTemplate><div id="Date_DATA"><asp:label Runat="server" id="ExpDate"><%#DataBinder.Eval(Container.DataItem, "ExpDate")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn HeaderText="Message">
                        <HeaderStyle CssClass="Description_TITLE_MSG" />
        			    <ItemTemplate>
                            <div runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "ShowLink")%>'>
                                <a href="#" style="color:black" onclick="window.open('<%#DataBinder.Eval(Container.DataItem, "Link")%>');">
                                <div id="Description_DATA_LINE2" style="margin-top:5px"><asp:label Runat="server" id="Text1"><%#DataBinder.Eval(Container.DataItem, "Text1")%></asp:label></div>
                                <div id="Description_DATA_LINE2"><asp:label Runat="server" id="Text2"><%#DataBinder.Eval(Container.DataItem, "Text2")%></asp:label></div>
                                <div id="Description_DATA_LINE2"><asp:label Runat="server" id="Text3"><%#DataBinder.Eval(Container.DataItem, "Text3")%></asp:label></div>
                                <div id="Description_DATA_LINE2"><asp:label Runat="server" id="Text4"><%#DataBinder.Eval(Container.DataItem, "Text4")%></asp:label></div>
                                <div id="Description_DATA_LINE2" style="margin-bottom:5px"><asp:label Runat="server" id="Text5"><%#DataBinder.Eval(Container.DataItem, "Text5")%></asp:label></div>
                                </a>
                            </div>
                            <div runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "ShowNoLink")%>'>
                                <div id="Description_DATA_LINE2" style="margin-top:5px"><asp:label Runat="server" id="Text6"><%#DataBinder.Eval(Container.DataItem, "Text1")%></asp:label></div>
                                <div id="Description_DATA_LINE2"><asp:label Runat="server" id="Text7"><%#DataBinder.Eval(Container.DataItem, "Text2")%></asp:label></div>
                                <div id="Description_DATA_LINE2"><asp:label Runat="server" id="Text8"><%#DataBinder.Eval(Container.DataItem, "Text3")%></asp:label></div>
                                <div id="Description_DATA_LINE2"><asp:label Runat="server" id="Text9"><%#DataBinder.Eval(Container.DataItem, "Text4")%></asp:label></div>
                                <div id="Description_DATA_LINE2" style="margin-bottom:5px"><asp:label Runat="server" id="Text10"><%#DataBinder.Eval(Container.DataItem, "Text5")%></asp:label></div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn>
                        <HeaderStyle CssClass="command_TITLE" />
    				        <ItemTemplate>
                                <div id="command_DATA"><asp:linkbutton ForeColor="black" ID="button_hide" Runat="server" CommandName="hide" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "MessageId")%>' Text=" Read " Height="16" BorderStyle="None" visible='<%#DataBinder.Eval(Container.DataItem, "ShowHide")%>' /></div>
                                <div id="command_DATA"><asp:linkbutton ForeColor="black"  ID="button_unhide" Runat="server" CommandName="unhide" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "MessageId")%>' Text=" UnRead " Height="16" BorderStyle="None" visible='<%#DataBinder.Eval(Container.DataItem, "ShowUnhide")%>' /></div>
    				        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
                </asp:datagrid>
            </td>
        </tr>
    </table>

    <table style="width:100%; border:none; margin-top:20px;" cellspacing="0" cellpadding="0">
        <tr>
            <td style="text-align:center">
                <img align="middle" src='/images/critical.png' height="15" hspace="1" border="0" style="margin-bottom:2px" alt="" />&nbsp;-&nbsp;Critical
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <img align="middle" src='/images/warning.png' height="15" hspace="1" border="0" style="margin-bottom:2px" alt="" />&nbsp;-&nbsp;Warning
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <img align="middle" src='/images/info.png' height="15" hspace="1" border="0" style="margin-bottom:3px" alt="" />&nbsp;-&nbsp;Information
            </td>
        </tr>
    </table>

    </div>
    </form>

</body>

</html>
