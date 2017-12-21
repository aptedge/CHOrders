<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login1.aspx.cs" Inherits="TurningpointSystems.Login2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1; no-cache" />
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
     <title>Login</title>
    <link rel="stylesheet" href="css/TPS.css" />
    <link rel="stylesheet" href="css/TpWebPortal.css" />
    <link rel="stylesheet" href="css/LayoutStyle.css" />
    <link rel="stylesheet" href="css/Reports.css" />

    <script src="script/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //if ($("#login_name").text == null)
                $("#login_name").focus();
            //else
               // $("#login_password").focus();
                $("#banner_top").attr("src", "images/login/banner_top.jpg?timestamp=" + new Date().getTime());
                $("#banner_bottom").attr("src", "images/login/banner_bottom.jpg?timestamp=" + new Date().getTime());
                $("#company_logo").attr("src", "images/login/logo.svg?timestamp=" + new Date().getTime());
            });

        function notempty() {
            if (notempty_name() == false)
                return false;
            if (notempty_password() == false)
                return false;
            return true;
        }
        function notempty_name() {
            if (login.login_name.value == "") {-
                alert("Enter Username");
                return false;
            }
            return true;
        }
        function notempty_password() {
            if (login.login_password.value == "") {
                alert("Enter Password");
                return false;
            }
            return true;
        }
        function open_not_a_cust() {
            window.open('help/not_a_customer.pdf', '_top');
        }

        function stopRKey(evt) {
            var evt = (evt) ? evt : ((event) ? event : null);
            if (evt.keyCode == 13) { return false; }
        }

        //document.onkeypress = stopRKey; 

    </script>
</head>

<body runat="server" id="body" style="height:auto">
    <form id="login" runat="server">

    <div id="container">

    <table style="width:100%; border:none;" cellspacing="0" cellpadding="0">
        <tr align="center">
            <td style="text-align:center;">
                <img id="company_logo" src="" height="100" runat="server" alt="Company Logo" />
            </td>
        </tr>
        <tr align="center">
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td style="text-align:center;">
                <img id="banner_top" src="" alt="Top Banner" runat="server"/>
            </td>
        </tr>
        <tr align="center">
            <td style="text-align:center;">
                Customer&nbsp;&nbsp;<input type="text" class="normal_input" id="login_name" style="width:80px" maxlength="26" title="Enter Username" runat="server" />
            </td>
        </tr>
        <tr align="center">
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td style="text-align:center;">
                Password&nbsp;&nbsp;<input type="password" class="normal_input" id="login_password" style="width:80px" onblur="notempty" maxlength="26" runat="server" />
            </td>
        </tr>
        <tr align="center">
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td style="text-align:center;">
            </td>
        </tr>
        <tr align="center">
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td style="text-align:center;">
                <a id="forgot_password" runat="server" visible="true" style="color:black" href="forgotpassword.aspx">Forgot Password?</a>            
            </td>
        </tr>
        <tr align="center">
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td style="text-align:center;">
                <a id="not_a_cust" runat="server" style="color:black" href="javascript:open_not_a_cust();">Click here if you are not a Customer</a>
            </td>
        </tr>
        <tr align="center">
            <td style="text-align:center;">
                <img id="banner_bottom" src="" height="100" alt="Bottom Banner" runat="server" />
            </td>
        </tr>
        <tr align="center">
            <td>&nbsp;</td>
        </tr>
    </table>

    </div>

    </form>
</body>
</html>
