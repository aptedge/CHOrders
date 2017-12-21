<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="TurningpointSystems.ForgotPassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1; no-cache" />
    <title>Forgot Password</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
    <link rel="stylesheet" href="css/TPS.css" />
    <link rel="stylesheet" href="css/TpWebPortal.css" />
    <script type="text/javascript">
        function noBack() { window.history.forward() }
        noBack();
        window.onload = noBack;
        window.onpageshow = function (evt) { if (evt.persisted) noBack() }
        window.onunload = function () { void (0) }
    </script>
</head>

<body runat="server" id="body" style="height:auto">

    <form id="forgot_password" runat="server">

    <div id="container" style="margin-top:100px">
        <table style="width:100%; border:none;" cellspacing="0" cellpadding="0">
            <tr>
                <td style="text-align:center;" colspan="2">
                    <img id="company_logo" src="images/logo/logo.svg" height="100" runat="server" alt="Company Logo" />
                </td>
            </tr>
            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td style="width:50%; text-align:right; height:40px;">
                    Username:&nbsp;&nbsp;
                </td>
                <td style="width:50%; text-align:left; height:40px;">
                    <asp:TextBox Width="100px" ID="txt_username" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width:50%; text-align:right; height:40px;">
                    User Question:&nbsp;&nbsp;
                </td>
                <td style="width:50%; text-align:left; height:40px;">
                    <asp:label ID="txt_question" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width:50%; text-align:right; height:40px;">
                    Enter Answer:&nbsp;&nbsp;
                </td>
                <td style="width:50%; text-align:left; height:40px;">
                    <asp:TextBox Width="400px" ID="txt_answer" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="text-align:center; height:40px;" colspan="2">
                    <asp:Button ID="btnGetQuestion" Text="Get Question" runat="server" CssClass="normal_button" OnClick="btnGetQuestion_Click" />
                </td>
            </tr>
            <tr>
                <td style="text-align:center; height:40px;" colspan="2">
                    <asp:Button ID="btnSubmit" Text="Get Password" runat="server" CssClass="normal_button" OnClick="btnSubmit_Click" />
                </td>
            </tr>
            <tr>
                <td style="text-align:center; height:40px;" colspan="2">
                    <asp:Button ID="btnGoToLogin" Text="Go To Login" runat="server" CssClass="normal_button" OnClick="btnGoToLogin_Click" />
                </td>
            </tr>
            <tr>
                <td style="text-align:center; height:40px;" colspan="2">
                    <asp:Label ID="lbl_password" runat="server" CssClass='password_msg'/>
                </td>
            </tr>
            <tr>
                <td style="text-align:center; height:40px;" colspan="2">
                    <asp:Label ID="cust_service" runat="server"/>
                </td>
            </tr>
        </table>
    </div>

    </form>
</body>
</html>
