<%@ Page Language="vb" AutoEventWireup="false" Inherits="invoice_pdf" CodeFile="invoice_pdf.aspx.vb" %>
<%@ Reference Control="~/controls/page_header_pdf.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header_pdf" Src="controls/page_header_pdf.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	<head>
		<title>Invoice</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

		<link href="/css/Layoutstyle.css" type="text/css" rel="stylesheet" />
	    <link href="/css/reports.css" rel="stylesheet" type="text/css" />
	    <link href="/css/tpwebportal.css" rel="stylesheet" type="text/css" />
	    <link href="/header_items/headerStyle.css" rel="stylesheet" type="text/css" />
	    <link href="/header_items/headerDisplay.css" rel="stylesheet" type="text/css" />

    </head>

	<body>

    <form id="Form1" method="post" runat="server">
  
    <div id="container"> 
    
	<div id="header_pdf"><uc1:page_header_pdf id="page_header_pdf" runat="server"></uc1:page_header_pdf></div>

    <div id="page_body" class="block_adjust">

    <div id="pdf_top_header">

    <div id="pdf_info_hdr">
        <table>
            <tr class="tableRowPdf">
                <td class="pdf_info_title">Invoice #: </td>
                <td class="pdf_info_data"><asp:Label ID="hdr_order_no" runat="server" /></td>
            </tr>
            <tr class="tableRowPdf">
                <td class="pdf_info_title">Date: </td>
                <td class="pdf_info_data"><asp:Label ID="hdr_order_invoice_date" runat="server" /></td>
            </tr>
            <tr class="tableRowPdf">
                <td class="pdf_info_title">Items: </td>
                <td class="pdf_info_data"><asp:Label ID="hdr_order_items" runat="server" /></td>
            </tr>
            <tr class="tableRowPdf">
                <td class="pdf_info_title">Total: </td>
                <td class="pdf_info_data"><asp:Label ID="hdr_order_total" runat="server" /></td>
            </tr>
        </table>   
    </div>

    <div id="pdf_to_hdr">
        <table>
            <tr class="tableRowPdf">
                <td class="cust_title_pdf">Ship To:</td>
                <td class="cust_title_pdf">
                    <asp:Label ID="customer_name" runat="server" /><br />
                    <asp:Label ID="customer_address" runat="server" /><br />
                    <asp:Label ID="customer_citystatezip" runat="server" /><br />
                    <asp:Label ID="customer_phone" runat="server" /><br />
                    <asp:Label ID="customer_fax" runat="server" /><br />
                    <asp:Label ID="customer_no" runat="server" /><br />
                </td>
            </tr>
        </table>   
    </div>

    <div id="pdf_terms" runat="server">
        <table>
            <tr class="tableRowPdf">
                <td class="pdf_info_title">Terms: </td>
                <td class="pdf_info_data"><asp:Label ID="hdr_terms" runat="server" /></td>
            </tr>
        </table>   
    </div>

    <div id="pdf_not_original">
        <table>
            <tr class="tableRowPdf">
                <td class="pdf_msg_data"><asp:Label ID="hdr_msg" runat="server" Text="NOT AN ORIGINAL INVOICE" /></td>
            </tr>
        </table>   
    </div>
    </div>

    <div id="pdf_table_header">
        <div id="repeating_table_pdf2">
            <asp:datagrid id="item_list" runat="server" ShowFooter="true" AllowSorting="false" AutoGenerateColumns="False" AllowPaging="false" EnableViewState="true">
            <AlternatingItemStyle CssClass="tr_odd_pdf1" />
        	<ItemStyle CssClass="tr_even_pdf1" />
        	<HeaderStyle CssClass="report_header" />
        	<FooterStyle CssClass="report_header" BackColor="#A9D0F5" ForeColor="Blue" />

        	<Columns>
            	<asp:TemplateColumn SortExpression="line_no" HeaderText="&nbsp;Line&nbsp;No&nbsp;">
                    <HeaderStyle CssClass="Price_TITLE_NEW" />
        			<ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" ID="line_no"><%# DataBinder.Eval(Container.DataItem, "line_no")%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>

            	<asp:TemplateColumn SortExpression="item_no" HeaderText="&nbsp;Item&nbsp;No&nbsp;">
                    <HeaderStyle CssClass="Price_TITLE_NEW" />
        			<ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" ID="item_no"><%# DataBinder.Eval(Container.DataItem, "item_no")%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>

            	<asp:TemplateColumn SortExpression="item_desc" HeaderText="Description">
                    <HeaderStyle CssClass="Description_TITLE_PDF" />
        			<ItemTemplate><div id="Description_DATA_PDF"><asp:label Runat="server" ID="item_desc"><%# DataBinder.Eval(Container.DataItem, "item_desc")%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>

            	<asp:TemplateColumn SortExpression="vendor_name" HeaderText="Vendor" Visible="false">
                    <HeaderStyle CssClass="Description_TITLE_PDF" />
        			<ItemTemplate><div id="Description_DATA_PDF"><asp:label Runat="server" ID="vendor_name"><%# DataBinder.Eval(Container.DataItem, "vendor_name")%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>

            	<asp:TemplateColumn SortExpression="item_unit_upc" HeaderText="Box UPC">
                    <HeaderStyle CssClass="UPC_TITLE2" />
        			<ItemTemplate><div id="UPC_DATA2"><asp:label Runat="server" ID="item_unit_upc"><%# DataBinder.Eval(Container.DataItem, "item_unit_upc")%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>

            	<asp:TemplateColumn HeaderText="Size" >
                    <HeaderStyle CssClass="SizeForm_TITLE" />
        			<ItemTemplate><div id="SizeForm_DATA2"><asp:label Runat="server" ID="item_size"><%# DataBinder.Eval(Container.DataItem, "item_size")%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>

            	<asp:TemplateColumn HeaderText="Form" >
                    <HeaderStyle CssClass="SizeForm_TITLE" />
        			<ItemTemplate><div id="SizeForm_DATA2"><asp:label Runat="server" ID="item_form"><%# DataBinder.Eval(Container.DataItem, "item_form")%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>

            	<asp:TemplateColumn HeaderText="Shipped<br />Qty">
                    <HeaderStyle CssClass="Price_TITLE_NEW" />
        			<ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" id="Quantity2" ><%#DataBinder.Eval(Container.DataItem, "qty_shipped")%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>

            	<asp:TemplateColumn SortExpression="order_price" HeaderText="Price">
                    <HeaderStyle CssClass="Price_TITLE_NEW" />
        			<ItemTemplate><div id="Price_DATA_EXT"><asp:label Runat="server" id="PriceId"><%# FormatNumber(DataBinder.Eval(Container.DataItem, "price"), 2)%></asp:label></div></ItemTemplate>
                    <FooterTemplate><div id="Price_DATA_EXT" style="background-color:#A9D0F5; font-weight:bold">Total:</div></FooterTemplate>
                </asp:TemplateColumn>

            	<asp:TemplateColumn SortExpression="order_ext" HeaderText="Ext&nbsp;Price">
                    <HeaderStyle CssClass="Price_TITLE_EXT2" />
        			<ItemTemplate><div id="Price_DATA_EXT2"><asp:label Runat="server" id="PriceId1"><%# FormatNumber(DataBinder.Eval(Container.DataItem, "ext_amt"), 2)%></asp:label></div></ItemTemplate>
                    <FooterTemplate><div id="Price_DATA_EXT2"><asp:label Runat="server"><%=InvoiceTotal%></asp:label></div></FooterTemplate>
                </asp:TemplateColumn>

                </Columns>
            </asp:datagrid>
        </div>

        <div id="notes_id" runat="server" visible="false">
            <table>
                <tr class="tableRowPdf" runat="server" id="row_AddNote">
                    <td class="form_title_pdf">Notes</td>
                    <td class="form_data_pdf"><asp:TextBox Width="100%" style="overflow:hidden" TextMode="MultiLine" MaxLength="255" Rows="5" ID="note_text" Wrap="true" runat="server"></asp:TextBox></td>
                </tr>
    	    </table>   
        </div>

    </div>

    </div>

    </div>
</form>

</body>
</html>

