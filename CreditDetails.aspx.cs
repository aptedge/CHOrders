using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Turningpoint.Shared;
using System.Data;
using System.Configuration;

public partial class CreditDetails : System.Web.UI.Page
{
    public String creditNo = "";
    public DataGrid dg;
    public String sCSV = "";

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

        this.CustNo.Attributes["value"] = usrDetails.TPSCustomerNumber;

        creditNo = Request.QueryString["no"];
        this.CreditNo.Attributes["value"] = creditNo;

        string creditDate = Request.QueryString["date"];
        this.CreditDate.Attributes["value"] = creditDate;

        string amount = Request.QueryString["amt"];
        this.Amount.Attributes["value"] = amount;

        export_link.Click += new EventHandler(this.export_Click);
    }

    private void LoadView()
    {
        System.Data.Odbc.OdbcConnection OdbcConnection = new System.Data.Odbc.OdbcConnection(ConfigurationManager.ConnectionStrings["TurningpointSystem"].ConnectionString);

        try
        {
            DataTable dt = new DataTable();
            dg = item_list;

            System.Data.Odbc.OdbcCommand oCmd = new System.Data.Odbc.OdbcCommand();

            OdbcConnection.Open();
            oCmd.Connection = OdbcConnection;

            string selectCmd;

            if (ConfigurationManager.AppSettings["RX"] == "yes")
            {
                selectCmd = String.Format(
                    " SELECT distinct A.CRITEM, CRSEQ, '' as CIGITM, A.CRCRTT, A.CRQTSR, B.ITDESC, B.ITSIZE, B.ITINVT, B.ITMUPC" +
                    " FROM FPCRDDTL A LEFT JOIN FPITMMAS B ON A.CRITEM=B.ITMNUM" +
                    // " LEFT OUTER JOIN FPCIGTAX Z ON Z.CIGSHP = A.CRITEM" +
                    " WHERE A.CRARNO = {0} ", creditNo);
            }
            else
            {
                selectCmd = String.Format(
                    " SELECT distinct A.CRITEM, CRSEQ, Z.CIGITM, A.CRCRTT, A.CRQTSR, B.ITDESC, B.ITSIZE, B.ITINVT, B.ITMUPC" +
                    " FROM FPCRDDTL A LEFT JOIN FPITMMAS B ON A.CRITEM=B.ITMNUM" +
                    " LEFT OUTER JOIN FPCIGTAX Z ON Z.CIGSHP = A.CRITEM" +
                    " WHERE A.CRARNO = {0} ", creditNo);
            }

            oCmd.CommandText = selectCmd;

            System.Data.Odbc.OdbcDataAdapter da = new System.Data.Odbc.OdbcDataAdapter(oCmd);
            da.Fill(dt);

            sCSV = "";
            for (int k = 0; k <= dg.Columns.Count - 1; k++)
            {
                sCSV += dg.Columns[k].HeaderText + ",";
            }
            sCSV += "\n";

            for (int i = 0; i <= dt.Rows.Count - 1; ++i)
            {
                DataRow dr = dt.Rows[i];

                if (dr["CIGITM"].ToString().Trim() != "")
                {
                    dr["CRITEM"] = dr["CIGITM"];
                }

                sCSV += dr["CRITEM"].ToString() + ",";
                sCSV += "\"" + dr["ITDESC"].ToString().Trim() + "\"" + ",";
                sCSV += "\"" + dr["ITMUPC"].ToString().Trim() + "\"" + ",";
                sCSV += dr["CRCRTT"].ToString() + ",";
                sCSV += dr["ITSIZE"].ToString() + ",";
                sCSV += dr["CRQTSR"].ToString() + ",";
                sCSV += "\n";
            }

            DataView dv = new DataView(dt);

            dg.DataSource = dv;
            dg.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            OdbcConnection.Close();
        }
    }

    private void export_Click(System.Object sender, System.EventArgs e)
    {
        ExportToCSV();
    }

    private void ExportToCSV()
    {
        Response.Clear();
        Response.Charset = "";
        Response.Buffer = true;

        Response.ContentType = "application/text";
        Response.AddHeader("content-disposition", "attachment;filename=Credit_" + creditNo.ToString() + ".csv");

        System.IO.StringWriter sw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(sw);

        DataGrid dg = new DataGrid();
        dg = item_list;

        dg.GridLines = GridLines.None;
        dg.HeaderStyle.Font.Bold = true;
        dg.FooterStyle.Font.Bold = true;

        dg.AllowPaging = false;
        dg.AllowSorting = false;

        LoadView();

        Response.Output.Write(sCSV.ToString());
        Response.Flush();
        Response.End();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}