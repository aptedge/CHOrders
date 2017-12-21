using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Turningpoint.Shared;
using Turningpoint.Data;

public partial class EditOrder : System.Web.UI.Page
{
    public UserDetail usrDetails = null;
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

            this.ShowQOH.Attributes["value"] = usrDetails.QOH;

            string orderNo = Request.QueryString["orderno"];
            this.OrderNo.Attributes["value"] = orderNo;

            if (decimal.Parse(orderNo) > 0)
            {
                TurningpointDataComponent tpsData = new TurningpointDataComponent();
                this.CustomerNo.Attributes["value"] = tpsData.GetOrderCustomer(decimal.Parse(orderNo));
            }
            else
            {
                this.CustomerNo.Attributes["value"] = usrDetails.TPSCustomerNumber;
            }

            string formName = Request.QueryString["form"];
            this.FormName.Attributes["value"] = formName;

            string editType = Request.QueryString["type"];
            this.EditType.Attributes["value"] = editType;

            if (editType == "form")
                lblOrders.Text = "Edit Form";

            FillDropDowns();

            if (ConfigurationManager.AppSettings["RX"] == "yes")
            {
                this.RX.Attributes["value"] = "Y";
                search_params_item_title.Text = "Item#:";
                order_entry_hdr_qoh.InnerText = "BOH";
                new_items_hdr_qoh.InnerText = "BOH";
                search_hdr_qoh.InnerText = "BOH";
            }
            else
            {
                this.RX.Attributes["value"] = "N";
                search_params_item_title.Text = "UPC or Item#:";
            }

            if (ConfigurationManager.AppSettings["LWD"] == "yes")
            {
                items_1.Visible = true;
                items_2.Visible = true;
            }

            if (ConfigurationManager.AppSettings["ShowDayOfWeek"] == "yes")
            {
                day_of_week.Visible = true;
                day_of_week_label.Visible = true;
            }

            if (ConfigurationManager.AppSettings["ShowWillCall"] == "no")
            {
                will_call.Visible = false;
                will_call.Visible = false;
            }
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

        this.day_of_week_dd.Items.Add(new ListItem("", ""));
        this.day_of_week_dd.Items.Add(new ListItem("MONDAY", "MO"));
        this.day_of_week_dd.Items.Add(new ListItem("TUESDAY", "TU"));
        this.day_of_week_dd.Items.Add(new ListItem("WEDNESDAY", "WE"));
        this.day_of_week_dd.Items.Add(new ListItem("THURSDAY", "TH"));
        this.day_of_week_dd.Items.Add(new ListItem("FRIDAY", "FR"));
        this.day_of_week_dd.Items.Add(new ListItem("SATURDAY", "SA"));
        this.day_of_week_dd.Items.Add(new ListItem("SUNDAY", "SU"));
    }
}
