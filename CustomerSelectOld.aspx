<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CustomerSelectOld.aspx.cs" Inherits="TurningpointSystems.CustomerSelect" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1;no-cache" />
    <title>Customer Select</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
    <link rel="stylesheet" href="css/TpWebPortal.css" />
    <link rel="stylesheet" href="css/Login2.css" />
    <script src="script/json2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="script/tooltip/tiptip.css" />
    <script src="script/tooltip/jquery.tipTip.js" type="text/javascript"></script>
    <script src="script/tooltip/jquery.tipTip.minified.js" type="text/javascript"></script>
    <script src="script/date.format.js" type="text/javascript"></script>
    <script src="script/utility.js" type="text/javascript"></script>
    <script src="script/TableHelper.js" type="text/javascript"></script>
    <script src="script/CustomerSelect.js" type="text/javascript"></script>
</head>
<body>

    <form id="customer" runat="server">
    <input type='hidden' id='ChainNo' runat='server' />
    <input type='hidden' id='Salesman' runat='server' />
    <div id="wrapper">
        <div id="display_region">
            <div id="login_container">
                <img id="company_logo" src="images/logo/logo.svg" alt="Company Logo" />
                <div id="choose_account">Select a Customer Account</div>
        <div style="margin-top: 20px; margin-bottom: 20px; margin-left: 15px; overflow: auto; width: 770px; height:430px;">
                <table class='normal' id='customers_table' cellpadding='0' cellspacing='0'>
                    <thead>
                        <tr class='normal_header'>
                            <th class='CustomerNumber'>
                                Customer #
                            </th>
                            <th class='CustomerName'>
                                Name
                            </th>
                            <th class='CustomerAddress'>
                                Address
                            </th>
                            <th class='CustomerCity'>
                                City
                            </th>
                            <th class='CustomerState'>
                                State
                            </th>
                            <th class='command select_cmd'>
                                Select
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- <tr>'s are added in javascript -->
                    </tbody>
                </table>
            </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
