<%@ Reference Control="~/controls/page_header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header" Src="controls/page_header.ascx" %>
<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header_tp" Src="controls/page_header_tp.ascx" %>
<%@ Page Language="vb" EnableEventValidation ="false" AutoEventWireup="false" Inherits="InvoiceHistory" CodeFile="InvoiceDetail.aspx.vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<head>
	<title>Invoice</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
	<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
	<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
	<meta content="JavaScript" name="vs_defaultClientScript" />

    <link rel="stylesheet" href="/css/TPS.css" />
    <link rel="stylesheet" href="/css/TPWebPortal.css" />
    <link rel="stylesheet" href="/css/LayoutStyle.css" />
    <link rel="stylesheet" href="/css/Reports.css" />

    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

    <script type="text/javascript">
        function ShowPrintView() {
            var url = encodeURI("InvoicePrint.aspx?orderno=" + document.getElementById('header_invoice_no').innerText);
            var win = window.open(url, "PrintOrder", "menubar=0,location=0,resizable=1,scrollbars=1,width=1000,height=400");
            win.moveTo(100, 100);
        }
    </script>
</head>
	
<body id="body" runat="server">
	<form id="Form1" method="post" runat="server">

	<div id="header_new" runat="server" visible="false"><uc1:page_header_tp id="page_header_tp" runat="server"></uc1:page_header_tp></div>
	<div id="header" runat="server" visible="false"><uc1:page_header id="page_header" runat="server"></uc1:page_header></div>

    <div id="container"> 

    <table style="width:100%; border:none;" cellspacing="0" cellpadding="0">
        <tr align="center">
            <td class="normal_label" style="text-align:center; font-size:14px">
                Invoice&nbsp;No&nbsp;<asp:label runat="server" Font-Bold="true" id="header_invoice_no" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Date&nbsp;&nbsp;<asp:label runat="server" Font-Bold="true" id="header_invoice_date" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Amount&nbsp;&nbsp;<asp:label runat="server" Font-Bold="true" id="header_invoice_amt" />
            </td>
        </tr>
    </table>

    <table style="width:100%; border:none; margin-bottom:5px; margin-top:15px" cellspacing="0" cellpadding="0">
        <tr style="height:40px" align="center">
            <td style="text-align:right; width:30%">
                <asp:linkbutton id="print_button" runat="server" OnClientClick="ShowPrintView();"><img src="images/printer.png" border="0" height="20px" alt="" /></asp:linkbutton>
            </td>
            <td style="text-align:left; width:10%" id="print_text" runat="server">
                &nbsp;Print&nbsp;
            </td>
            <td style="text-align:right; width:10%">
                <asp:imagebutton id="export_link" runat="server" ToolTip="Export To CSV" ImageUrl="/images/button_export.png" ImageAlign="AbsBottom" />
            </td>
            <td style="text-align:left; width:10%">
                &nbsp;Export&nbsp;To&nbsp;CSV&nbsp;
            </td>
            <td style="text-align:right; width:10%">
                <asp:imagebutton id="exportpdf_link" Visible="false" runat="server" ToolTip="Export To PDF" ImageUrl="/images/icon-pdf.png" Height="20px" ImageAlign="AbsBottom" />
            </td>
            <td style="text-align:left; width:10%" id="exportpdf_label" visible="false" runat="server">
                &nbsp;Export&nbsp;To&nbsp;PDF&nbsp;
            </td>
            <td style="text-align:left; width:20%">
                <asp:button ID="btnCopy" Visible="false" Height="25px" Width="180px" runat="server" CssClass="normal_button" Text=" Copy Invoice Items to Order " />
            </td>
        </tr>
    </table>

    <table style="width:100%; border:none; margin-bottom:5px; margin-top:15px" cellspacing="0" cellpadding="0">
        <tr>
            <td style="text-align:center;"">
                <asp:datagrid id="item_list" runat="server" style="margin:auto" Width="80%" GridLines="none" AllowSorting="true" AutoGenerateColumns="False"  AllowPaging="false" EnableViewState="true">
                <AlternatingItemStyle CssClass="tr_odd_1" />
        	    <ItemStyle CssClass="tr_even_1" />
        	    <HeaderStyle CssClass="report_header_new" />

        	    <Columns>
            	    <asp:TemplateColumn SortExpression="ORDTLN" HeaderText="Line #">
                        <HeaderStyle CssClass="Price_TITLE_NEW" />
        			    <ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" id="ORDTLN"><%#DataBinder.Eval(Container.DataItem, "ORDTLN")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="ITEM" HeaderText="Item #">
                        <HeaderStyle CssClass="Price_TITLE_NEW" />
        			    <ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" id="ITMNUM"><%#DataBinder.Eval(Container.DataItem, "ITEM")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="ITDESC" HeaderText="Description">
                        <HeaderStyle CssClass="Description_TITLE" />
        			    <ItemTemplate><div id="Description_DATA"><asp:label Runat="server" id="ITDESC"><%#DataBinder.Eval(Container.DataItem, "ITDESC")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="ITMUPC" HeaderText="Box UPC">
                        <HeaderStyle CssClass="UPC_TITLE" />
        			    <ItemTemplate><div id="UPC_DATA"><asp:label Runat="server" id="ITMUPC"><%#DataBinder.Eval(Container.DataItem, "UPC")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="ITNDCI" HeaderText="Retail UPC">
                        <HeaderStyle CssClass="UPC_TITLE" />
        			    <ItemTemplate><div id="UPC_DATA"><asp:label Runat="server" id="ITNDCI"><%#DataBinder.Eval(Container.DataItem, "NDCI")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="ITMNDC" HeaderText="NDC">
                        <HeaderStyle CssClass="UPC_TITLE" />
        			    <ItemTemplate><div id="UPC_DATA"><asp:label Runat="server" id="ITMNDC"><%#DataBinder.Eval(Container.DataItem, "ITMNDC")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="ITSIZE" HeaderText="Size">
                        <HeaderStyle CssClass="SizeForm_TITLE" />
        			    <ItemTemplate><div id="SizeForm_DATA2"><asp:label Runat="server" id="ITSIZE"><%#DataBinder.Eval(Container.DataItem, "ITSIZE")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="ITFORM" HeaderText="Form">
                        <HeaderStyle CssClass="SizeForm_TITLE" />
        			    <ItemTemplate><div id="SizeForm_DATA2"><asp:label Runat="server" id="ITFORM"><%#DataBinder.Eval(Container.DataItem, "ITFORM")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="ORDTQT" HeaderText="Ordered Qty">
                        <HeaderStyle CssClass="Price_TITLE_NEW" />
        			    <ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" id="ORDTQT"><%#DataBinder.Eval(Container.DataItem, "ORDTQT")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="ORDTSQ" HeaderText="Shipped Qty">
                        <HeaderStyle CssClass="Price_TITLE_NEW" />
        			    <ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" id="ORDTSQ"><%#DataBinder.Eval(Container.DataItem, "ORDTSQ")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="ORDTSR" HeaderText="Retail">
                        <HeaderStyle CssClass="Price_TITLE_NEW" />
        			    <ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" id="Retail"><%#DataBinder.Eval(Container.DataItem, "ORDTSR")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn SortExpression="OTCACT" HeaderText="Price">
                        <HeaderStyle CssClass="Price_TITLE_NEW" />
        			    <ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" id="Price"><%#DataBinder.Eval(Container.DataItem, "OTCACT")%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
            	    <asp:TemplateColumn HeaderText="Ext Price">
                        <HeaderStyle CssClass="Price_TITLE_EXT" />
        			    <ItemTemplate><div id="Price_DATA_EXT"><asp:label Runat="server" id="Ext"><%#FormatNumber(DataBinder.Eval(Container.DataItem, "EXT"), 2)%></asp:label></div></ItemTemplate>
                    </asp:TemplateColumn>
			        <asp:TemplateColumn Visible="false" HeaderText="RX History">
                        <HeaderStyle CssClass="command_TITLE" />
				        <ItemTemplate><div id="command_DATA"><asp:imagebutton ID="button_pdf" Runat="server" ToolTip="RX Compliance PDF" CommandName="export_pdf" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ITEM_ARGS")%>' ImageUrl="../images/icon-pdf.png" BorderColor="0" Height="20" Visible='<%# DataBinder.Eval(Container.DataItem, "SHOW_PDF")%>' />&nbsp;&nbsp;</div>
				        </ItemTemplate>
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
