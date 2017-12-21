<%@ Reference Control="~/controls/page_header.ascx" %>
<%@ Reference Control="~/controls/page_footer.ascx" %>
<%@ Register TagPrefix="uc2" TagName="page_footer" Src="controls/page_footer.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header" Src="controls/page_header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Inherits="ContactUs2" CodeFile="ContactUs2.aspx.vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>

<head>
	<title>Contact Us</title>
	<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
	<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
	<meta content="JavaScript" name="vs_defaultClientScript" />
	<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
	<link href="css/TPWebPortal.css" type="text/css" rel="stylesheet" />
	<link href="css/LayoutStyle.css" type="text/css" rel="stylesheet" />
    <link href="css/reports.css" rel="stylesheet" type="text/css" />
    <link href="header_items/headerStyle.css" rel="stylesheet" type="text/css" />
    <link href="header_items/headerDisplay.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/Login2.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
</head>
	
<body>
    <form id="login" runat="server">
    <div id="container">
        <div id="display_region">
            <div id="login_container">
                <img id="company_logo" src="images/login/logo.svg" alt="Company Logo" />
                <br />
                <br />
                <br />
                     <div id="invoice_table_header">
                    <div id="title_Header"><span class="PAGE_TITLE">Contact Us</span></div><br />
                    <div id="contact_info">
                        <b><asp:Label runat="server" ID="contact_company" /></b><br />
                        <asp:Label runat="server" ID="contact_address" /><br />
                        <asp:Label runat="server" ID="contact_city" />,&nbsp;<asp:Label runat="server" ID="contact_state" /><asp:Label runat="server" ID="contact_zip" /><br />
                        <asp:Label runat="server" ID="contact_phone" /><br />
                        <asp:Label runat="server" ID="contact_fax" /><br /><br />
                        <a style="color:Black"  runat="server" ID="contact_email" href="" /><br /> 
                    </div>
                    </div>
            </div>
        </div>
    </div>
    </form>
</body>

</html>
