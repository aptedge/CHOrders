using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Turningpoint.Shared;
using Turningpoint.Data;

public partial class ItemInfoSearch : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
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
            this.ShowQOH.Attributes["value"] = usrDetails.QOH;

            if (ConfigurationManager.AppSettings["RX"] == "yes")
            {
                this.RX.Attributes["value"] = "Y";
                search_params_item_title.Text = "Item#:";
            }
            else
            {
                this.RX.Attributes["value"] = "N";
                search_params_item_title.Text = "UPC or Item#:";
            }

            FillDropDowns();
        }
    }

    private void FillDropDowns()
    {
        UserDetail usrDetails = Session["UserDetails"] as UserDetail;

        TurningpointDataComponent turningPointComponent = new TurningpointDataComponent();

        search_params_class_dropdown.Items.Add(new ListItem() { Text = "", Value = "" });
        if (ConfigurationManager.AppSettings["RX_V6"] == "yes")
        {
            foreach (KeyValuePair<string, string> kv in turningPointComponent.GetItemClasses2())
                search_params_class_dropdown.Items.Add(new ListItem() { Text = kv.Value, Value = kv.Key });
        }
        else
        {
            foreach (KeyValuePair<string, string> kv in turningPointComponent.GetItemClasses(usrDetails.TPSCustomerNumber))
                search_params_class_dropdown.Items.Add(new ListItem() { Text = kv.Value, Value = kv.Key });
        }

        search_params_vendor_dropdown.Items.Add(new ListItem() { Text = "", Value = "" });
        foreach (KeyValuePair<string, string> kv in turningPointComponent.GetItemVendors())
            search_params_vendor_dropdown.Items.Add(new ListItem() { Text = kv.Value, Value = kv.Key });
    }

}