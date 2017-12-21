using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Odbc;
using System.Data;
using System.Configuration;
using Turningpoint.Shared;
using Turningpoint.Data;

public partial class BrandTracking : System.Web.UI.Page
{
    public string CustNo = "";
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
                page_header_tp.setHeader("Brand Tracking");
            }

            this.CustomerNo.Attributes["value"] = usrDetails.TPSCustomerNumber;
            CustNo = usrDetails.TPSCustomerNumber;

            FillDropDowns();
        }
    }

    private void FillDropDowns()
    {
        TurningpointDataComponent turningPointComponent = new TurningpointDataComponent();

        ListItem li = new ListItem("- Select Brand Family -", "");
        li.Selected = true;
        brand_family_dropdown.Items.Add(li);
        foreach (KeyValuePair<string, string> kv in turningPointComponent.GetItemBrands())
        {
            brand_family_dropdown.Items.Add(new ListItem() { Text = kv.Value, Value = kv.Key });
        }
    }

    protected void Run_Click(object sender, EventArgs e)
    {
        string sCustomerNumber = CustomerNo.Value;
        string sStartDate = "";
        string sEndDate = "";
        string sBrandFamily = "";
        string sTargetPct = target_pct.Text;
        Double dTargetPct = 0.0;

        if ((!date_start.IsNull) && (date_start.IsDate))
        {
            sStartDate = createCYYMMDDFromDateTime(date_start.SelectedDate);
        }
        else
        {
            message.Text = "Please enter Start Date";
            return;
        }

        if ((! date_end.IsNull) && (date_end.IsDate))
        {
            sEndDate = createCYYMMDDFromDateTime(date_end.SelectedDate);
        }
        else
        {
            message.Text = "Please enter End Date";
            return;
        }

        foreach (ListItem item in brand_family_dropdown.Items)
        {
            if ((item.Selected == true) && (item.Value != ""))
            {
                sBrandFamily = item.Value;
                break;
            }
        }
        if (sBrandFamily == "")
        {
            message.Text = "Please select a Brand Family";
            return;
        }

        double.TryParse(sTargetPct, out dTargetPct);
        if (dTargetPct == 0)
        {
            target_pct.Text = "0";
        }

        message.Text = "";

        LoadItems(sCustomerNumber, sStartDate, sEndDate, sBrandFamily, dTargetPct);

        //Response.Write("<script>");
        //Response.Write("window.open('rpt_pricelist.aspx','PriceList','menubar=0,location=0,resizable=1,scrollbars=1')");
        //Response.Write("</script>");
        //Response.Redirect("rpt_velocity.aspx");
    }

    private string createCYYMMDDFromDateTime(string dtIn)
    {
        try
        {
            DateTime date = DateTime.Parse(dtIn);

            string yyyy = date.ToString("yyyy");
            string yy = date.ToString("yy");
            string mm = date.ToString("MM");
            string dd = date.ToString("dd");

            int century = int.Parse(yyyy.Substring(0, 2));
            string c = (century - 19).ToString();

            return c + yy + mm + dd;
        }
        catch
        {
            return "";
        }
    }

    private string createCYYMMDDFromDateTime(DateTime date)
    {
        try
        {
            string yyyy = date.ToString("yyyy");
            string yy = date.ToString("yy");
            string mm = date.ToString("MM");
            string dd = date.ToString("dd");

            int century = int.Parse(yyyy.Substring(0, 2));
            string c = (century - 19).ToString();

            return c + yy + mm + dd;
        }
        catch
        {
            return "";
        }
    }

    private void LoadItems(string sCustNo, string sDateStart, string sDateEnd, string sBrandFamily, double dTargetPct)
    {
        System.Data.Odbc.OdbcConnection odbcConnection = new System.Data.Odbc.OdbcConnection(ConfigurationManager.ConnectionStrings["TurningpointSystem"].ConnectionString);
        OdbcDataReader odbcDataReader = null;

        string selectCmd =
            " SELECT I.ITVSUF, G.GREFDT, 0 AS TOTAL, '' AS PCT, 0 AS SALES, 0 AS CREDITS, " +
            "        (SELECT SUM(S.WKQTY) FROM FPSLSBRN S" +
            "           LEFT JOIN FPITMMAS I1 ON S.WKITEM = I1.ITMNUM" +
            "           WHERE S.WKSHIP = " + sCustNo +
            "            AND S.WKTYPE = 'S' " +
            "            AND I1.ITVSUF = I.ITVSUF " +
            "            AND S.WKDATE BETWEEN " + sDateStart + " AND " + sDateEnd +
            "            AND I1.ITINVT IN (SELECT GREFKY FROM FPSYGREF WHERE GREFCD = 'WP')) AS SALES_COUNT, " +
            "        (SELECT SUM(C.WKQTY) FROM FPSLSBRN C" +
            "           LEFT JOIN FPITMMAS I2 ON C.WKITEM = I2.ITMNUM" +
            "           WHERE C.WKSHIP = " + sCustNo +
            "            AND C.WKTYPE = 'C' " +
            "            AND I2.ITVSUF = I.ITVSUF " +
            "            AND C.WKDATE BETWEEN " + sDateStart + " AND " + sDateEnd +
            "            AND I2.ITINVT IN (SELECT GREFKY FROM FPSYGREF WHERE GREFCD = 'WP')) AS CREDITS_COUNT" +
            " FROM FPSLSBRN A " +
            " LEFT JOIN FPITMMAS I ON A.WKITEM = I.ITMNUM" +
            " LEFT JOIN FPSYGREF G ON G.GREFCD = 'BF' AND I.ITVSUF = G.GREFKY" +
            " WHERE WKSHIP = " + sCustNo +
            "  AND WKDATE BETWEEN " + sDateStart + " AND " + sDateEnd +
            "  AND I.ITINVT IN (SELECT GREFKY FROM FPSYGREF WHERE GREFCD = 'WP')" +
            " GROUP BY ITVSUF, GREFDT";
        try
        {
            DataTable dt = new DataTable();

            odbcConnection.Open();
            OdbcCommand odbcCommand = new OdbcCommand(selectCmd, odbcConnection);

            System.Data.Odbc.OdbcDataAdapter da = new System.Data.Odbc.OdbcDataAdapter(odbcCommand);
            da.Fill(dt);

            double dTotal = 0;

            foreach (DataRow dr in dt.Rows)
            {
                try
                {
                    dr["SALES"] = Convert.ToInt32(dr["SALES_COUNT"]);
                }
                catch 
                {
                    dr["SALES"] = 0;
                }
                try
                {
                    dr["CREDITS"] = Convert.ToInt32(dr["CREDITS_COUNT"]);
                }
                catch 
                {
                    dr["CREDITS"] = 0;
                }

                dr["TOTAL"] = Convert.ToInt32(dr["SALES"]) - Convert.ToInt32(dr["CREDITS"]);
                dTotal += Convert.ToInt32(dr["TOTAL"]);
            }

            sales_total.Text = dTotal.ToString("#0");

            foreach (DataRow dr in dt.Rows)
            {
                double dPct = 0.0;
                try
                {
                    dPct = (Convert.ToInt32(dr["TOTAL"]) / dTotal) * 100;
                }
                catch 
                {
                    dPct = 0;
                }
                dr["PCT"] = dPct.ToString("#0.00");

                if (Convert.ToInt32(dr["ITVSUF"]) == Convert.ToInt32(brand_family_dropdown.SelectedValue))
                {
                    sales_current_pct.Text = dr["PCT"].ToString();
                    sales_brand.Text = dr["TOTAL"].ToString();

                    double dAddUnits = 0;
                    try
                    {
                        dAddUnits = (dTargetPct / 100 * dTotal) - Convert.ToInt32(dr["TOTAL"]);
                        sales_additional.Text = dAddUnits.ToString("#0");
                    }
                    catch
                    {
                    }
                }
            }

            DataView dv = new DataView(dt);

            item_list.DataSource = dv;
            item_list.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            if (odbcDataReader != null)
                odbcDataReader.Close();
            odbcConnection.Close();
        }
    }

}
