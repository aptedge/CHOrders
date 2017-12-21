using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.WebControls;
using Turningpoint.Shared;
using Turningpoint.Data;
using System.Data;

public partial class AR : System.Web.UI.Page
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

        body.Style.Add("background-color", Session["PageBackColor"].ToString());

        if (ConfigurationManager.AppSettings["WelcomePage"].ToString() == "welcome2.aspx")
        {
            header.Visible = true;
        }
        else
        {
            header_new.Visible = true;
            page_header_tp.setHeader("Accounts Payable");
        }

        this.CustNo.Attributes["value"] = usrDetails.TPSCustomerNumber;

        if (! IsPostBack) 
        {
            LoadView();
        }
    }

    private void LoadView()
    {
        TurningpointDataComponent tpsData = new TurningpointDataComponent();
        AccountStatus acct = tpsData.GetCustAccount(this.CustNo.Attributes["value"]);

        header_amount_due.Text = String.Format("{0:C}", acct.AmountOpen);
        header_last_payment_date.Text = acct.LastPaymentDate.ToShortDateString();
        header_last_payment_amt.Text = String.Format("{0:C}", acct.LastPaymentAmount);

        SearchAccountsPayableParameters parms = new SearchAccountsPayableParameters();
        parms.CustomerNumber = this.CustNo.Attributes["value"];
        if (date_start.IsDate && !date_start.IsNull)
        {
            parms.Date = date_start.SelectedDate;
        }
        if (date_end.IsDate && !date_end.IsNull)
        {
            parms.ToDate = date_end.SelectedDate;
        }
        parms.DocumentNumber = txn_number.Text.Trim();

        SearchAccountsPayableResponse response = tpsData.SearchAccountsPayable(parms);

        DataTable dt = new DataTable();

        dt.Columns.Add("TxnDate");
        dt.Columns.Add("TxnNo");
        dt.Columns.Add("TxnType");
        dt.Columns.Add("Amount");
        dt.Columns.Add("Closed", typeof(bool));

        foreach (AccountPayable ap in response.AccountPayableList)
        {
            int iClosed;

            if (ap.ARClosed == 0)
            {
                iClosed = 1;
            }
            else
            {
                iClosed = 0;
            }

            dt.Rows.Add(ap.Date.ToShortDateString(), ap.DocNo, ap.DocType, ap.Amount, iClosed);
        }

        DataView dv = new DataView(dt);

        item_list.DataSource = dv;
        item_list.DataBind();
    }

    protected void Run_Click(object sender, EventArgs e)
    {
        LoadView();
    }

}