<%@ Page Language="vb" AutoEventWireup="false" Inherits="CustomerSelect" CodeFile="CustomerSelect.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	<head>
		<title>Select Customer</title>
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

        <script src="script/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
        <script src="script/jquery/jquery-ui-1.8.4.custom.min.js" type="text/javascript"></script>
        <script src="/script/utility.js" type="text/javascript"></script>

        <script type="text/javascript">
        function noBack() { window.history.forward() }
        noBack();
        window.onload = noBack;
        window.onpageshow = function (evt) { if (evt.persisted) noBack() }
        window.onunload = function () { void (0) }

        function handleKeyPressCust(e) {
            var key = e.keyCode || e.which;
            if (key == 13)
                $("#search_button").click();
        };

    </script>

    </head>

	<body id="body" runat="server" style="height:auto">

    <form id="Form1" method="post" runat="server">
  
    <div id="container"> 
    
    <table style="width:100%; border:none;" cellspacing="0" cellpadding="0">
        <tr align="center">
            <td style="text-align:right; width:30%">
                <img id="company_logo" src="images/logo/logo.svg" height="100" alt="Company Logo" />
            </td>
            <td style="text-align:center; width:40%; font-size:16px;">
                Please select a Customer
            </td>
            <td style="text-align:right; width:30%">
                &nbsp;
            </td>
        </tr>
    </table>

    <table style="width:100%; border:none;" cellspacing="0" cellpadding="0">
        <tr align="center">
            <td style="text-align:center">
                    Customer&nbsp;#&nbsp;&nbsp;
                    <asp:textbox class="normal_input" runat="server" style="width: 80px;" id='cust_number' maxlength='7' onkeypress="JavaScript:return NumbersOnly(event);" onkeyup="JavaScript:return handleKeyPressCust(event);"/>
                    &nbsp;&nbsp;&nbsp;&nbsp;<asp:button runat="server" class='normal_button' id="search_button" Text=" Select "/>
                    &nbsp;&nbsp;&nbsp;&nbsp;<asp:button runat="server" class='normal_button' id="cancel_button" Text=" Cancel "/>
            </td>
        </tr>
        <tr>
            <td style="text-align:center; height:30px">
                <asp:Label ID="message" ForeColor="Red" runat="server" Text="" />&nbsp;
            </td>
        </tr>
    </table>

    <table style="width:100%; border:none;" cellspacing="0" cellpadding="0">
        <tr align="center">
            <td style="text-align:center">
                <asp:datagrid id="item_list" runat="server" Width="90%" style="margin:auto; width:90%" GridLines="none" AllowSorting="true" AutoGenerateColumns="False" EnableViewState="true">
                <AlternatingItemStyle CssClass="tr_odd_1" />
        	    <ItemStyle CssClass="tr_even_1" />
        	    <HeaderStyle CssClass="report_header_new" />
        	    <Columns>
            	    <asp:TemplateColumn SortExpression="CustomerNumber" HeaderText="Cust #">
                        <HeaderStyle CssClass="Price_TITLE" />
 				        <ItemTemplate><div id="Price_DATA"><asp:linkbutton ID="button_cust" Runat="server" ForeColor="Black" CommandName="select_cust" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "CustomerNo")%>'><%#DataBinder.Eval(Container.DataItem, "CustomerNumber")%></asp:linkbutton></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="CustomerName" HeaderText="Name">
                        <HeaderStyle CssClass="Description_TITLE_SHORT3" />
        			    <ItemTemplate><div id="Description_DATA_SHORT3"><asp:label Runat="server" id="CustomerName"><%#DataBinder.Eval(Container.DataItem, "CustomerName")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="CustomerAddress" HeaderText="Address">
                        <HeaderStyle CssClass="Description_TITLE_SHORT3" />
        			    <ItemTemplate><div id="Description_DATA_SHORT3"><asp:label Runat="server" id="CustomerAddress"><%#DataBinder.Eval(Container.DataItem, "CustomerAddress")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="CustomerCity" HeaderText="City">
                        <HeaderStyle CssClass="City_TITLE" />
        			    <ItemTemplate><div id="City_DATA"><asp:label Runat="server" id="CustomerCity"><%#DataBinder.Eval(Container.DataItem, "CustomerCity")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="CustomerState" HeaderText="State">
                        <HeaderStyle CssClass="State_TITLE" />
        			    <ItemTemplate><div id="State_DATA"><asp:label Runat="server" id="CustomerState"><%#DataBinder.Eval(Container.DataItem, "CustomerState")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="CustomerPhone" HeaderText="Phone">
                        <HeaderStyle CssClass="City_TITLE" />
        			    <ItemTemplate><div id="City_DATA"><asp:label Runat="server" id="CustomerPhone"><%#DataBinder.Eval(Container.DataItem, "CustomerPhone")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
			        <asp:TemplateColumn HeaderText="Select">
                        <HeaderStyle CssClass="command_TITLE" />
				        <ItemTemplate><div id="command_DATA"><asp:imagebutton ID="button_select" Runat="server" CommandName="select_cust" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "CustomerNo")%>' ImageUrl="../images/select.png" Height="18" BorderColor="0" /></div></ItemTemplate>
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

