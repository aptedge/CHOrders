<%@ Page Language="vb" AutoEventWireup="false" Inherits="Documents" CodeFile="CSOSSupport.aspx.vb" %>
<%@ Reference Control="~/controls/page_header_tp.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header_tp" Src="controls/page_header_tp.ascx" %>
<%@ Reference Control="~/controls/page_header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="page_header" Src="controls/page_header.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>CSOS Support</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
    <link rel="stylesheet" href="css/TPWebPortal.css" />
    <link rel="stylesheet" href="css/LayoutStyle.css" />
    <link rel="stylesheet" href="css/Reports.css" />

    <script type="text/javascript">
        function open_support() {
            window.open("http://www.legisym.com/support.php");
        }

    </script>
</head>
	<body id="body" runat="server">

    <form id="Form1" method="post" runat="server">
  
	<div id="header_new" runat="server"><uc1:page_header_tp id="page_header_tp" runat="server"></uc1:page_header_tp></div>

    <div id="container"> 
    
        <table style="width:100%; border:none;" cellspacing="0" cellpadding="0">
            <tr>
                <td style="text-align:center" id="Report_TITLE"><asp:Label runat="server" ID="title2" Text="CSOS Order Support (Legisym Customer Support)" /></td>
            </tr>
        </table>
        <table style="width:100%; border:none;" cellspacing="0" cellpadding="0">
            <tr>
                <td>&nbsp;<br />&nbsp;<br />&nbsp;</td>
            </tr>
            <tr>
                <td class='normal_label' style="text-align:center; font-size: 14px;">
                    Phone&nbsp;&nbsp;
                    <asp:Label runat="server" Text="254-933-4452&nbsp;&nbsp;Option 2" ForeColor="Blue" />
                </td>
            </tr>
            <tr style="height:40px;">
                <td class='normal_label' style="text-align:center; font-size: 14px;">
                    Support Link&nbsp;&nbsp;
                    <asp:LinkButton runat="server" id="btn_support" OnClientClick="javascript:open_support();" ForeColor="blue" Font-Underline="true">http://www.legisym.com/support.php</asp:LinkButton>
                </td>
            </tr>
        </table>
        <br /><br /><br /><br />
        <table style="width:100%; border:none;" cellspacing="0" cellpadding="0">
            <tr>
                <td style="text-align:center"><asp:Label runat="server" ID="lblNote" Text="Please note this is for CSOS Orders only.&nbsp;&nbsp;For all other inquiries please contact us directly." /></td>
            </tr>
        </table>
    </div>

    </form>
</body>
</html>
