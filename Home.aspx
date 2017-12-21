<%@ Page Language="C#" AutoEventWireup="true" CodeFile="home.aspx.cs" Inherits="TurningpointSystems.Home" %>
<%@ Register TagPrefix="uc1" TagName="header_tabs" Src="~/controls/header_tabs_tp.ascx" %>

<head id="Head1" runat="server">
    <meta http-equiv="Page-Enter" content="Alpha(opacity=100)" />

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1; no-cache" />
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
    <link href="../css/styles.css" rel="stylesheet" type="text/css" />
    <link href="../css/tpwebportal.css" rel="stylesheet" type="text/css" />
    <link href="../header_items/headerStyle.css" rel="stylesheet" type="text/css" />
    <link href="../header_items/headerDisplay.css" rel="stylesheet" type="text/css" />
    <script src="script/json2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="script/jquery/jquery.formatCurrency-1.4.0.min.js" type="text/javascript"></script>
    <script src="script/utility.js" type="text/javascript"></script>
</head>

<html>
<body runat="server" id="body">
    <div id="container">
    <div style="height:100%; width:100%" >
        <div class="tabs" style="z-index:1001;"><uc1:header_tabs id="Header_tabs1" runat="server"></uc1:header_tabs></div>
        <iframe height="100" style="top:0; left:0; width:100%;" name="fr_header" id="fr_header" runat="server" src="main.aspx" frameborder="0" scrolling="no" />
        <iframe style="top:100px; left:0; height:100%; width:100%; overflow:visible;" name="fr_main" id="fr_main" runat="server" frameborder="0" src="main.aspx" scrolling="no" />
    </div>
    </div>
</body>
</html>