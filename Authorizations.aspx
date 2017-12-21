<%@ Page Language="vb" AutoEventWireup="false" Inherits="Authorizations" CodeFile="Authorizations.aspx.vb" %>
<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header_tp" Src="controls/page_header_tp.ascx" %>
<%@ Reference Control="~/controls/page_header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header" Src="controls/page_header.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	<head>
		<title>Authorizations</title>
        <link rel="icon" href="favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

        <link rel="stylesheet" href="css/TPS.css" />
        <link rel="stylesheet" href="css/TPWebPortal.css" />
        <link rel="stylesheet" href="css/Reports.css" />
        <link rel="stylesheet" href="css/LayoutStyle.css" />
        <link rel="stylesheet" href="css/ClassRetails.css" />
        <script src="script/json2.min.js" type="text/javascript"></script>
        <script src="script/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
        <script src="script/jquery/jquery-ui-1.8.4.custom.min.js" type="text/javascript"></script>
        <script src="script/utility.js" type="text/javascript"></script>
        <script src="script/retails.js" type="text/javascript"></script>
        <script type="text/javascript">
            function noBack() { window.history.forward() }
            noBack();
            window.onload = noBack;
            window.onpageshow = function (evt) { if (evt.persisted) noBack() }
            window.onunload = function () { void (0) }

            function simple_tooltip(target_items, name) {
                $(target_items).each(function (i) {
                    $("body").append("<div class='" + name + "' id='" + name + i + "'><p>" + $(this).attr('title') + "</p></div>");
                    var my_tooltip = $("#" + name + i);

                    if ($(this).attr("title") != "") { // checks if there is a title

                        my_tooltip.css('z-index', '9999');

                        $(this).removeAttr("title").mouseover(function () {
                            my_tooltip.css({ display: "none" }).fadeIn(50);
                        }).mouseover(function (kmouse) {
                            my_tooltip.css({ left: kmouse.pageX + 20, top: kmouse.pageY - 110 });
                        }).mouseout(function () {
                            my_tooltip.fadeOut(50);
                        });

                    }
                });
            }

            $(document).ready(function () {
                simple_tooltip("a", "tooltip");
            });
        </script>
    </head>

	<body id="body" runat="server">

    <form id="Form1" name="Form1" method="post" runat="server">
  
	<div id="header_new" runat="server" visible="false"><uc1:page_header_tp id="page_header_tp" runat="server"></uc1:page_header_tp></div>
	<div id="header" runat="server" visible="false"><uc1:page_header id="page_header" runat="server"></uc1:page_header></div>

    <div id="container"> 

    <asp:DropDownList ID="rounding_dropdown" runat="server" CssClass='class_dropdown' Visible="false" />
    <input type='hidden' id='CustomerNo' runat='server' />
    <input type='hidden' id='CurrentRecs' runat='server' value="25" />
    
    <table style="width:100%; border:none; margin-top:20px;" cellspacing="0" cellpadding="0">
        <tr>
            <td style="text-align:center">
                <asp:DropDownList ID="cat_dropdown" runat="server" CssClass='class_dropdown' />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:DropDownList ID="vendor_dropdown" runat="server" CssClass='class_dropdown' />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Records Per Page&nbsp;&nbsp;
                <asp:dropdownlist id="records_per_page" runat="server" AutoPostBack="true" cssclass="input_item" onchange="ChangeRecsDropdown();">
			        <asp:ListItem Value="25" Selected="True">&nbsp;25&nbsp;</asp:ListItem>
			        <asp:ListItem Value="50">&nbsp;50&nbsp;</asp:ListItem>
			        <asp:ListItem Value="100">&nbsp;100&nbsp;</asp:ListItem>
			        <asp:ListItem Value="250">&nbsp;250&nbsp;</asp:ListItem>
			        <asp:ListItem Value="500">&nbsp;500&nbsp;</asp:ListItem>
		        </asp:dropdownlist>
            </td>
        </tr>
    </table>

    <table style="width:100%; border:none; margin-top:20px;" cellspacing="0" cellpadding="0">
        <tr>
            <td style="text-align:center">
                Item&nbsp;#,&nbsp;UPC&nbsp;or&nbsp;Desc&nbsp;&nbsp;
                <asp:textbox runat="server" size="25" class="normal_input" id="txt_search" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:checkbox runat="server" class='normal_checkbox' id="cb_show_all" ToolTip="Show All Items or if unchecked Show Authorized Items Only" text=" Show All Items"/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:checkbox runat="server" class='normal_checkbox' id="cb_retails_top" ToolTip="Sort the list so that the items with retails will be first in each section" text=" Show Items With Retails First"/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:button id='search_button' class='normal_button' runat="server" Text='Search' onclientclick="JavaScript: return ValidateSearchParams();"/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:button id='save_items_button' class='normal_button' runat="server" Text='Save Changes' />
            </td>
        </tr>
    </table>

    <table style="width:100%; border:none; margin-top:20px;" cellspacing="0" cellpadding="0">
        <tr>
            <td style="text-align:center">
                <asp:datagrid id="item_list" runat="server" width="100%" style="margin:auto" GridLines="none" AllowSorting="true" AutoGenerateColumns="False" AllowPaging="true" PageSize="25" EnableViewState="true">
                <AlternatingItemStyle CssClass="tr_odd_1" />
        	    <ItemStyle CssClass="tr_even_1" />
        	    <HeaderStyle CssClass="report_header_new" />
        	    <Columns>
			        <asp:TemplateColumn HeaderText="Auth">
                        <HeaderStyle CssClass="command_TITLE" />
				        <ItemTemplate><asp:CheckBox id="cb_auth" runat="server" Checked='<%# DataBinder.Eval(Container.DataItem, "IsAuth") %>'></asp:CheckBox></ItemTemplate>
			        </asp:TemplateColumn>
            	    <asp:TemplateColumn HeaderText="Is Auth" Visible="false">
        			    <ItemTemplate><asp:label Runat="server" id="IsAuth" Text='<%# DataBinder.Eval(Container.DataItem, "IsAuth") %>'></asp:label></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn HeaderText="Retail Class" Visible="false">
        			    <ItemTemplate><asp:label Runat="server" id="RetailClass" Text='<%#DataBinder.Eval(Container.DataItem, "RetailClass")%>'></asp:label></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn HeaderText="Item Class" Visible="false">
        			    <ItemTemplate><asp:label Runat="server" id="ItemClass" Text='<%#DataBinder.Eval(Container.DataItem, "ItemClass")%>'></asp:label></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn HeaderText="Rounding" Visible="false">
        			    <ItemTemplate><asp:label Runat="server" id="Rounding" Text='<%#DataBinder.Eval(Container.DataItem, "Rounding")%>'></asp:label></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="ItemNumber" HeaderText="Item #">
                        <HeaderStyle CssClass="ItemNo_TITLE2" />
        			    <ItemTemplate><div id="ItemNo_DATA"><a style="text-decoration:none; color:black" title='<%#DataBinder.Eval(Container.DataItem, "Tooltip")%>' href="#"><asp:label Runat="server" id="ItemNumber" Text='<%#DataBinder.Eval(Container.DataItem, "ItemNumber")%>'></asp:label></a></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="ItemDesc" HeaderText="Description">
                        <HeaderStyle CssClass="Description_TITLE_SHORT3" />
        			    <ItemTemplate><div id="Description_DATA_SHORT3"><asp:label Runat="server" id="ItemDesc" Text='<%#DataBinder.Eval(Container.DataItem, "ItemDesc")%>' /></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="Vendor" HeaderText="Vendor">
                        <HeaderStyle CssClass="Description_TITLE_SHORT3" />
        			    <ItemTemplate><div id="Description_DATA_SHORT3"><asp:label Runat="server" id="Vendor"><%#DataBinder.Eval(Container.DataItem, "Vendor")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="RetailSRP" HeaderText="Retail<br/>Price">
                        <HeaderStyle CssClass="ItemNo_TITLE2" />
        			    <ItemTemplate><div id="ItemNo_DATA"><asp:label Runat="server" id="RetailSRP"><%#DataBinder.Eval(Container.DataItem, "RetailSRP")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="RetailClassDesc" HeaderText="Retail Class">
                        <HeaderStyle CssClass="Description_TITLE_SHORT3" />
        			    <ItemTemplate><div id="Description_DATA_SHORT3"><asp:label Runat="server" id="RetailClassDesc" Text='<%#DataBinder.Eval(Container.DataItem, "RetailClassDesc")%>' /></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="RetailDate" HeaderText="Date">
                        <HeaderStyle CssClass="Date_TITLE" />
        			    <ItemTemplate><div id="Date_DATA"><asp:label Runat="server" id="RetailDate"><%#DataBinder.Eval(Container.DataItem, "DisplayDate")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="Fixed_Pct" HeaderText="F / %">
                        <HeaderStyle CssClass="flag_TITLE" />
        			    <ItemTemplate><div id="flag_DATA"><asp:label Runat="server" id="Fixed_Pct"><%#DataBinder.Eval(Container.DataItem, "Fixed_Pct")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="RetailsAmount" HeaderText="Amount">
                        <HeaderStyle CssClass="Price_TITLE" />
        			    <ItemTemplate><div id="Price_DATA"><asp:label Runat="server" id="RetailsAmount"><%#DataBinder.Eval(Container.DataItem, "RetailsAmount")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="UOM" HeaderText="R / S" >
                        <HeaderStyle CssClass="flag_TITLE" />
        			    <ItemTemplate><div id="flag_DATA"><asp:label Runat="server" id="UOM"><%#DataBinder.Eval(Container.DataItem, "UOM")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="" HeaderText="Rounding">
                        <HeaderStyle CssClass="Rounding_TITLE" />
        			    <ItemTemplate><div id="Rounding_DATA"><asp:dropdownlist Height="18" Runat="server" id="ItemRoundingDropdown"></asp:dropdownlist></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn HeaderText="Fixed Amt">
                        <HeaderStyle CssClass="Amount_TITLE" />
        			    <ItemTemplate><div id="Amount_DATA"><asp:textbox Runat="server" id="FixedAmt" Width="40px" Text='' onkeypress="JavaScript:return FloatOnly(event);"/></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn HeaderText="% Amt">
                        <HeaderStyle CssClass="Amount_TITLE" />
        			    <ItemTemplate><div id="Amount_DATA"><asp:textbox Runat="server" id="PctAmt" Width="40px" Text='' onkeypress="JavaScript:return FloatOnly(event);"/></div></ItemTemplate>
                    </asp:TemplateColumn>
			        <asp:TemplateColumn HeaderText="Delete<br/>Exception">
                        <HeaderStyle CssClass="command_TITLE" />
				        <ItemTemplate><asp:CheckBox id="cb_delete" runat="server" Checked="false" Visible='<%# DataBinder.Eval(Container.DataItem, "IsException") %>'></asp:CheckBox></ItemTemplate>
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

