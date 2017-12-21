using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Turningpoint.Shared;

public partial class ItemInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string itemNo = Request.QueryString["item"];
        this.ItemNo.Attributes["value"] = itemNo;

        string custNo = Request.QueryString["cust"];
        this.CustNo.Attributes["value"] = custNo;

        body.Style.Add("background-color", "white");

        if (ConfigurationManager.AppSettings["RX"] == "yes")
        {
            rowRetail.Visible = false;
            rowRetailQty.Visible = false;
            rowRetailUOM.Visible = false;
            rowUPC.Visible = false;
            rowUnitUPC.Visible = false;
            rowCaseUPC.Visible = false;
        }
        else
        {
            rowNDC.Visible = false;
        }
    }
}