using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Turningpoint.Shared;
using System.Configuration;

public partial class InvoicesAndCredits : System.Web.UI.Page
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

        FillDropDowns();

        string type = Request.QueryString["type"];

        if (type == "C")
        {
            lblTitle.Text = "Credit History";
            iandc_search_type_dropdown.Items.FindByValue("credit").Selected = true;
        }
        else
        {
            lblTitle.Text = "Invoice History";
            iandc_search_type_dropdown.Items.FindByValue("invoice").Selected = true;
        }

        this.CustNo.Attributes["value"] = usrDetails.TPSCustomerNumber;

        if (ConfigurationManager.AppSettings["InvoiceImages"] == "yes")
        {
            manifest_preview.Visible = true;
        }

        if (!IsPostBack)
        {
            ClientScript.RegisterStartupScript(GetType(), "key", "InitialSearch();", true);
        }
    }

    private void FillDropDowns()
    {
        this.iandc_search_type_dropdown.Items.Add(new ListItem("Invoice", "invoice"));
        this.iandc_search_type_dropdown.Items.Add(new ListItem("Credit", "credit"));
    }

}