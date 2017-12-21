using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Turningpoint.Shared;

namespace TurningpointSystems
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String sLogin = "login2.aspx";
            try
            {
                sLogin = ConfigurationManager.AppSettings["LoginPage"].ToString();
            }
            catch
            {
                sLogin = "login2.aspx";
            }
            if (sLogin == "login.aspx")
            {
                sLogin = "login2.aspx";
            }

            Session["UserDetails"] = null;
            Session["LibList"] = ConfigurationManager.AppSettings["Site1_Libraries"].ToString();
            Response.Redirect(sLogin);
        }
    }
}
