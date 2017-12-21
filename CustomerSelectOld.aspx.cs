using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Turningpoint.Shared;
using Turningpoint.Data;

namespace TurningpointSystems
{
    public partial class CustomerSelect : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UserDetail usrDetails = null;
            if (Session["UserDetails"] != null)
                usrDetails = Session["UserDetails"] as UserDetail;
            else
            {
                Response.Write("<script>window.open('login.aspx','_top');</script>");
                return;
            }

            this.ChainNo.Attributes["value"] = usrDetails.TPSChainNumber;
            this.Salesman.Attributes["value"] = usrDetails.Salesman;
        }
    }
}
