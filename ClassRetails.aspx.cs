using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Turningpoint.Shared;
using Turningpoint.Data;

public partial class Retails : System.Web.UI.Page
{
    public UserDetail usrDetails = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        this.bUpdating.Attributes["value"] = "0";
        page_header.setHeader("Retails");

        if (ConfigurationManager.AppSettings["SqlServer"] == "yes")
        {
            TurningpointDataComponent turningPointComponent = new TurningpointDataComponent();

            if (turningPointComponent.IsRetailsBlocked())
            {
                retail_class_li.Visible = false;
                retail_items_li.Visible = false;
                retail_all_items_li.Visible = false;
                search_li.Visible = false;
                loading_li.Visible = true;

                li_class.Visible = false;
                li_items.Visible = false;
                li_all.Visible = false;
                li_search.Visible = false;
                li_loading.Visible = true;

                this.bUpdating.Attributes["value"] = "1";
            }
        }
        
        if (!Page.IsPostBack)
        {
            UserDetail usrDetails = null;
            if (Session["UserDetails"] != null)
                usrDetails = Session["UserDetails"] as UserDetail;
            else
            {
                Response.Write("<script>window.open('login.aspx','_top');</script>");
                return;
            }

            this.CustomerNo.Attributes["value"] = usrDetails.TPSCustomerNumber;
            this.RetailsHelpFile.Attributes["value"] = ConfigurationManager.AppSettings["RetailsHelpFile"];

            FillDropDowns();

            //DateTime dtNow = DateTime.Today;
            //date_input.Value = dtNow.ToShortDateString();
            //date_input_item.Value = dtNow.ToShortDateString();
        }
    }

    private void FillDropDowns()
    {
        UserDetail usrDetails = Session["UserDetails"] as UserDetail;

        TurningpointDataComponent turningPointComponent = new TurningpointDataComponent();

        search_params_class_dropdown.Items.Add(new ListItem() { Text = "", Value = "" });
        foreach (KeyValuePair<string, string> kv in turningPointComponent.GetItemClasses(usrDetails.TPSCustomerNumber))
            search_params_class_dropdown.Items.Add(new ListItem() { Text = kv.Value, Value = kv.Key });

        search_params_vendor_dropdown.Items.Add(new ListItem() { Text = "", Value = "" });
        foreach (KeyValuePair<string, string> kv in turningPointComponent.GetItemVendors())
            search_params_vendor_dropdown.Items.Add(new ListItem() { Text = kv.Value, Value = kv.Key });

        foreach (KeyValuePair<string, string> kv in turningPointComponent.GetRoundingCodes())
            rounding_dropdown.Items.Add(new ListItem() { Text = kv.Value, Value = kv.Key });

        foreach (KeyValuePair<string, string> kv in turningPointComponent.GetRoundingCodes())
            rounding_dropdown_item.Items.Add(new ListItem() { Text = kv.Value, Value = kv.Key });

        class_dropdown.Items.Add(new ListItem() { Text = "", Value = "" });
        foreach (KeyValuePair<string, string> kv in turningPointComponent.GetItemClasses(usrDetails.TPSCustomerNumber))
            class_dropdown.Items.Add(new ListItem() { Text = kv.Value, Value = kv.Key });
    }
}
