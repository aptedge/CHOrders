<%@ Page Language="vb" EnableEventValidation ="false" AutoEventWireup="false" Inherits="OrderPrint" CodeFile="InvoicePrint.aspx.vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<head>
	<title>Invoice</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
	<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
	<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
	<meta content="JavaScript" name="vs_defaultClientScript" />
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

    <style type="text/css">
        body
        {
            font-family: Arial,Helvetica,sans-serif;
            font-size: 12px;
        }
    </style>
</head>
	
<body>
	<form id="Form1" method="post" runat="server">

    <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value=" Print " onclick="window.print()" /><br /><br />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Customer: <%=CustomerNo%> - <%=CustomerName%> <br/>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Invoice No: <%=InvoiceNo%><br />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date: <%=OrderDate%><br />
    <asp:Label ID="dea_blank" runat="server">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DEA #: <%=DEANumber%><br /></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lines: <%=OrderLines%><br />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total: <%=OrderTotal%><br /><br /><br />
    
    <div id="repeating_table" runat="server" style="margin-left: 15px">
        <asp:datagrid id="item_list" runat="server" AllowSorting="true" AutoGenerateColumns="False" AllowPaging="false" EnableViewState="true" BorderStyle="none" GridLines="None">
        <HeaderStyle Font-Bold="true" />
        <Columns>
            <asp:TemplateColumn HeaderText="Line #" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
            	<ItemTemplate><div id="Line_DATA"><asp:label Runat="server" id="LineNo" Text='<%#DataBinder.Eval(Container.DataItem, "LineNumber")%>'></asp:label></div></ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Item #" HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
            	<ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" id="ItemNo" Text='<%#DataBinder.Eval(Container.DataItem, "ItemNumber")%>'></asp:label></div></ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Qty"  HeaderStyle-Width="60px" ItemStyle-Width="60px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
        		<ItemTemplate><div id="Price_DATA2"><%#DataBinder.Eval(Container.DataItem, "Quantity")%></div></ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderStyle-Width="20px" ItemStyle-Width="20px">
        		<ItemTemplate><div id="Description_DATA"></div></ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Description"  HeaderStyle-Width="260px" ItemStyle-Width="260px" HeaderStyle-HorizontalAlign="Left">
        		<ItemTemplate><div id="Description_DATA"><%# DataBinder.Eval(Container.DataItem, "Description")%></div></ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Size"  HeaderStyle-Width="60px" ItemStyle-Width="60px">
            	<ItemTemplate><div id="SizeForm_DATA2"><asp:label Runat="server" id="Size" Text='<%#DataBinder.Eval(Container.DataItem, "Size")%>'></asp:label></div></ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Form" HeaderStyle-Width="60px" ItemStyle-Width="60px" >
            	<ItemTemplate><div id="SizeForm_DATA2"><asp:label Runat="server" id="Form" Text='<%#DataBinder.Eval(Container.DataItem, "Form")%>'></asp:label></div></ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="NDC" HeaderStyle-Width="100px" ItemStyle-Width="100px" >
            	<ItemTemplate><div id="UPC_DATA"><asp:label Runat="server" id="NDC" Text='<%#DataBinder.Eval(Container.DataItem, "NDC")%>'></asp:label></div></ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Box UPC" HeaderStyle-Width="100px" ItemStyle-Width="100px" >
            	<ItemTemplate><div id="UPC_DATA"><asp:label Runat="server" id="UPC" Text='<%#DataBinder.Eval(Container.DataItem, "UPC")%>'></asp:label></div></ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Retail" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px" ItemStyle-Width="100px" >
            	<ItemTemplate><div id="Price_DATA2" ><asp:label Runat="server" id="Retail" Text='<%#DataBinder.Eval(Container.DataItem, "Retail")%>'></asp:label></div></ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Price" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px" ItemStyle-Width="100px" >
            	<ItemTemplate><div id="Price_DATA2" ><asp:label Runat="server" id="Price" Text='<%#DataBinder.Eval(Container.DataItem, "Price")%>'></asp:label></div></ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Ext Price" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px" ItemStyle-Width="100px" >
            	<ItemTemplate><div id="Price_DATA_EXT1"><asp:label Runat="server" id="ExtPrice" Text='<%#DataBinder.Eval(Container.DataItem, "ExtPrice")%>'></asp:label></div></ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
        </asp:datagrid>
    </div>

    </form>
</body>

</html>
