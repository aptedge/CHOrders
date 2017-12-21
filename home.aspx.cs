using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.WebControls;
using Turningpoint.Shared;
using System.IO;

namespace TurningpointSystems
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            fr_header.Attributes["src"] = "../header_items/page_header_tp.aspx";
            fr_main.Attributes["src"] = "messages.aspx";
        }
    }
}
