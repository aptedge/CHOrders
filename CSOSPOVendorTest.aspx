<%@ Reference Control="~/controls/page_header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header" Src="controls/page_header.ascx" %>
<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header_tp" Src="controls/page_header_tp.ascx" %>
<%@ Page Language="vb" EnableEventValidation ="false" AutoEventWireup="false" Inherits="PODetail" CodeFile="CSOSPOVendorTest.aspx.vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<head>
	<title>Vendor EDI850 Test</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
	<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
	<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
	<meta content="JavaScript" name="vs_defaultClientScript" />
    <link rel="stylesheet" href="css/TPWebPortal.css" />
    <link rel="stylesheet" href="css/LayoutStyle.css" />
    <link rel="stylesheet" href="css/Reports.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
</head>
	
<body>
	<form id="Form1" method="post" runat="server">

    <div id="container"> 
    
	<div id="header_new" runat="server" visible="false"><uc1:page_header_tp id="page_header_tp" runat="server"></uc1:page_header_tp></div>

    <div id="page_body" class="block_adjust">
       
    <div id="invoice_detail_header2" runat="server" style="margin-left:100px">
        <table>
            <tr>
                <td style="font-size:13px; margin-left:50px; color:red"><asp:label runat="server" id="message" Text="&nbsp;" /></td>
            </tr>
            <tr>
                <td style="font-size:13px">PO&nbsp;No:&nbsp;&nbsp;<asp:TextBox Width="80" runat="server" ID="po"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:button runat="server" class='normal_button' id="btn_load" Text=" Load "/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:button runat="server" class='normal_button' id="btn_clear" Text=" Clear "/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:button runat="server" class='normal_button' id="btn_resend" Text=" Send EDI850 test to Express222 "/><br /><br />
                </td>
            </tr>
            <tr>
                <td style="font-size:13px">Vendor:&nbsp;&nbsp;<asp:label runat="server" id="header_vendor" /></td>
            </tr>
            <tr>
                <td style="font-size:13px">DEA&nbsp;Blank&nbsp;#:&nbsp;&nbsp;<asp:label runat="server" id="header_dea_no" /></td>
            </tr>
            <tr>
                <td style="font-size:13px">Date:&nbsp;&nbsp;<asp:label runat="server" id="header_po_date" /></td>
            </tr>
            <tr>
                <td style="font-size:13px">Lines:&nbsp;&nbsp;<asp:label runat="server" id="header_po_lines" /></td>
            </tr>
            <tr>
                <td style="font-size:13px">Amount:&nbsp;&nbsp;<asp:label runat="server" id="header_po_amt" /></td>
            </tr>
        </table>
    </div>
 
     <div id="invoice_detail_header3" style="margin-left:90px">
        <div id="repeating_table">
            <asp:datagrid id="item_list" runat="server" AllowSorting="true" AutoGenerateColumns="False"  AllowPaging="false" EnableViewState="true">
            <AlternatingItemStyle CssClass="tr_odd_1" />
        	<ItemStyle CssClass="tr_even_1" />
        	<HeaderStyle CssClass="report_header_new" />

        	<Columns>
            	<asp:TemplateColumn SortExpression="ITMNUM" HeaderText="Item #">
                    <HeaderStyle CssClass="Price_TITLE_NEW" />
        			<ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" id="ITMNUM"><%#DataBinder.Eval(Container.DataItem, "ITMNUM")%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="ITDESC" HeaderText="Description">
                    <HeaderStyle CssClass="Description_TITLE" />
        			<ItemTemplate><div id="Description_DATA"><asp:label Runat="server" id="ITDESC"><%#DataBinder.Eval(Container.DataItem, "ITDESC")%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="ITMNDC" HeaderText="NDC">
                    <HeaderStyle CssClass="UPC_TITLE" />
        			<ItemTemplate><div id="UPC_DATA"><asp:label Runat="server" id="ITMNDC"><%#DataBinder.Eval(Container.DataItem, "ITMNDC")%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="PODSEQ" HeaderText="Line #">
                    <HeaderStyle CssClass="Price_TITLE_NEW" />
        			<ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" id="PODSEQ"><%#DataBinder.Eval(Container.DataItem, "PODSEQ")%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="ITSIZE" HeaderText="Size">
                    <HeaderStyle CssClass="SizeForm_TITLE" />
        			<ItemTemplate><div id="SizeForm_DATA2"><asp:label Runat="server" id="ITSIZE"><%#DataBinder.Eval(Container.DataItem, "ITSIZE")%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="ITFORM" HeaderText="Form">
                    <HeaderStyle CssClass="SizeForm_TITLE" />
        			<ItemTemplate><div id="SizeForm_DATA2"><asp:label Runat="server" id="ITFORM"><%#DataBinder.Eval(Container.DataItem, "ITFORM")%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="PODUOR" HeaderText="Ordered Qty">
                    <HeaderStyle CssClass="Price_TITLE_NEW" />
        			<ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" id="PODUOR"><%#DataBinder.Eval(Container.DataItem, "PODUOR")%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="PODUCS" HeaderText="Price">
                    <HeaderStyle CssClass="Price_TITLE_NEW" />
        			<ItemTemplate><div id="Price_DATA2"><asp:label Runat="server" id="Price"><%#FormatNumber(DataBinder.Eval(Container.DataItem, "PODUCS"), 2)%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>
            	<asp:TemplateColumn SortExpression="PODAMT" HeaderText="Ext Price">
                    <HeaderStyle CssClass="Price_TITLE_EXT" />
        			<ItemTemplate><div id="Price_DATA_EXT"><asp:label Runat="server" id="PODAMT"><%#FormatNumber(DataBinder.Eval(Container.DataItem, "PODAMT"), 2)%></asp:label></div></ItemTemplate>
                </asp:TemplateColumn>

            </Columns>
            <PagerStyle CssClass="PagerControl" HorizontalAlign="Center" Height="23px" ForeColor="Blue" BackColor="#A9D0F5" Wrap="False" Mode="NumericPages" PageButtonCount="10" ></PagerStyle>
            </asp:datagrid>
        </div>  
    </div>
          
    <div runat="server" style="margin-left:90px">
        <table>
            <tr>
                <asp:TextBox Visible="false" Width="800" runat="server" ID="edi850_data" TextMode="MultiLine" Height="300"></asp:TextBox>
            </tr>
        </table>
    </div>

    </div>

    </div>

    </form>
</body>

</html>
