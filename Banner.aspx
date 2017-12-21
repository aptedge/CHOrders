<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Banner.aspx.cs" Inherits="TurningpointSystems.Banner" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
        <link rel="stylesheet" href="style.css" />
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
</head>
<body>
    <form id="form1" runat="server">
    <div id="bannerMain" style='background-image:url(<%= ConfigurationManager.AppSettings["BannerImage"] %>/welcomebanner.jpg);'>
    </div>
    </form>
</body>
</html>
