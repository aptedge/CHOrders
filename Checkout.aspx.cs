using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Turningpoint.Shared;
using Turningpoint.Data;

public partial class Checkout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserDetail usrDetails = null;
        if (Session["UserDetails"] != null)
            usrDetails = Session["UserDetails"] as UserDetail;
        else
        {
            Response.Redirect("~/login.aspx");
            return;
        }

        this.ShowQOH.Attributes["value"] = usrDetails.QOH;

        this.SubmitMessage.Attributes["value"] = GetSubmitMessage();

        string orderNo = Request.QueryString["orderno"];
        this.OrderNo.Attributes["value"] = orderNo;

        TurningpointDataComponent tpsData = new TurningpointDataComponent();
        this.CustNo.Attributes["value"] = tpsData.GetOrderCustomer(decimal.Parse(orderNo));

        if (ConfigurationManager.AppSettings["RX"] == "yes")
        {
            this.RX.Attributes["value"] = "Y";
        }
        else
        {
            this.RX.Attributes["value"] = "N";
        }
    }

    private string GetSubmitMessage()
    {
        string sMessage = "Thank you. Your order has been submitted.";

        try 
        {
            System.IO.StreamReader sr;
            System.IO.FileStream fs = new System.IO.FileStream(Server.MapPath("help/submitmessage.txt"), System.IO.FileMode.Open, System.IO.FileAccess.Read);
            sr = new System.IO.StreamReader(fs);

            if (! sr.EndOfStream)
            {
                sMessage = sr.ReadToEnd();
            }

            fs.Close();
        }
        catch
        {
        }

        return sMessage;
    }
}