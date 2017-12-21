using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Web.UI.WebControls;
using System.Configuration;
using Turningpoint.Shared;
using Turningpoint.Data;
using System.Text;

public partial class InvoiceDetails : System.Web.UI.Page
{
    public String invoiceNo = "";
    public String invoiceDate = "";
    public String amount = "";
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

        invoiceNo = Request.QueryString["no"];
        this.InvoiceNo.Attributes["value"] = invoiceNo;

        invoiceDate = Request.QueryString["date"];
        this.InvoiceDate.Attributes["value"] = invoiceDate;

        amount = Request.QueryString["amt"];
        this.Amount.Attributes["value"] = amount;

        export_link.Click += new EventHandler(this.export_Click);

        if (ConfigurationManager.AppSettings["RX"] == "yes")
        {
            this.RX.Attributes["value"] = "Y";
        }
        else
        {
            this.RX.Attributes["value"] = "N";
        }
        //LoadView();
    }

    private void LoadView() 
    {
        System.Data.Odbc.OdbcConnection OdbcConnection = new System.Data.Odbc.OdbcConnection(ConfigurationManager.ConnectionStrings["TurningpointSystem"].ConnectionString);

        try
        {
            DataTable dt = new DataTable();
            dg = item_list;
            StringBuilder sCSVBuilder = new StringBuilder();

            System.Data.Odbc.OdbcCommand oCmd = new System.Data.Odbc.OdbcCommand();

            OdbcConnection.Open();
            oCmd.Connection = OdbcConnection;

            string selectCmd;

            if (ConfigurationManager.AppSettings["RX_V6"] == "yes")
            {
                selectCmd = String.Format(
                " SELECT distinct A.ORDTIT, 0 as ORUSIT, A.OTCACT, '' AS EXTPRICE, '' AS RETAIL, A.ORDTSQ, A.ORDTQT, A.ORDTSP, '' as ORPKCT, B.*, 0 as OCLNX$" +
                " FROM FPORDDTL A LEFT JOIN FPITMMAS B ON A.ORDTIT = B.ITMNUM" +
                //" LEFT JOIN FPORDCRD C ON C.OCDOC# = A.OTINV# AND C.OCDLNE = A.ORDTLN" +
                " WHERE A.OTINV# = {0} ", invoiceNo);
            }
            else if (ConfigurationManager.AppSettings["RX"] == "yes")
            {
                selectCmd = String.Format(
                " SELECT distinct A.ORDTIT, 0 as ORUSIT, A.OTCACT, '' AS EXTPRICE, '' AS RETAIL, A.ORDTSQ, A.ORDTQT, A.ORDTSP, '' as ORPKCT, B.*, C.OCLNX$" +
                " FROM FPORDDTL A LEFT JOIN FPITMMAS B ON A.ORDTIT = B.ITMNUM" +
                " LEFT JOIN FPORDCRD C ON C.OCDOC# = A.OTINV# AND C.OCDLNE = A.ORDTLN" +
                " WHERE A.OTINV# = {0} ", invoiceNo);
            }
            else
            {
                selectCmd = String.Format(
                " SELECT distinct A.ORDTIT, A.ORUSIT, A.OTCACT, '' AS EXTPRICE, '' AS RETAIL, A.ORDTSQ, A.ORDTQT, A.ORDTSP, A.ORPKCT, B.*, C.OCLNX$" +
                " FROM FPORDDTL A LEFT JOIN FPITMMAS B ON A.ORDTIT = B.ITMNUM" +
                " LEFT JOIN FPORDCRD C ON C.OCDOC# = A.OTINV# AND C.OCDLNE = A.ORDTLN" +
                " WHERE A.OTINV# = {0} ", invoiceNo);
            }

            oCmd.CommandText = selectCmd;

            System.Data.Odbc.OdbcDataAdapter da = new System.Data.Odbc.OdbcDataAdapter(oCmd);
            da.Fill(dt);

            sCSVBuilder.Append("Invoice No, Invoice Date, Amount\n");
            sCSVBuilder.Append(invoiceNo + "," + invoiceDate + "," + amount.Replace("$", "") + "\n\n");

            for (int k = 0; k <= dg.Columns.Count - 1; k++) {
                if (ConfigurationManager.AppSettings["RX"] == "yes")
                {
                    if ((k != 2) && (k != 9))
                        sCSVBuilder.Append(dg.Columns[k].HeaderText + ",");
                }
                else
                {
                    if (k != 3)
                        sCSVBuilder.Append(dg.Columns[k].HeaderText + ",");
                }
            }
            sCSVBuilder.Append("\n");

            for (int i = 0; i <= dt.Rows.Count - 1; ++i) 
            {
                DataRow dr = dt.Rows[i];

                if (dr["ITINVT"].ToString().Trim() == "Z")
                {
                    dr["ORDTIT"] = dr["ORUSIT"];
                }

                double extPrice = 0;
                try
                {
                    extPrice = Convert.ToDouble(dr["ORDTSQ"]) * Convert.ToDouble(dr["OTCACT"]);
                }
                catch
                {
                }
                dr["EXTPRICE"] = String.Format("{0:f}", extPrice);

                double retailPrice = 0;
                try
                {
                    retailPrice = Convert.ToDouble(dr["ORDTSP"]) / Convert.ToDouble(dr["ORPKCT"]);
                }
                catch
                {
                }
                dr["RETAIL"] = String.Format("{0:f}", retailPrice);

                sCSVBuilder.Append(dr["ORDTIT"].ToString() + ",");
                sCSVBuilder.Append("\"" + dr["ITDESC"].ToString().Trim() + "\"" + ",");
                if (ConfigurationManager.AppSettings["RX"] == "yes")
                {
                    if (dr["ITMNDC"].ToString().Trim() == "")
                    {
                        sCSVBuilder.Append("\"\"" + ",");
                    }
                    else
                    {
                        sCSVBuilder.Append("\"" + dr["ITMNDC"].ToString().Trim() + " *\"" + ",");
                    }
                }
                else
                {
                    if (dr["ITMUPC"].ToString().Trim() == "")
                    {
                        sCSVBuilder.Append("\"\"" + ",");
                    }
                    else
                    {
                        sCSVBuilder.Append("\"" + dr["ITMUPC"].ToString().Trim() + " *\"" + ",");
                    }
                }
                sCSVBuilder.Append(dr["OTCACT"].ToString() + ",");
                sCSVBuilder.Append(dr["EXTPRICE"].ToString() + ",");
                sCSVBuilder.Append(dr["ITSIZE"].ToString() + ",");
                sCSVBuilder.Append(dr["ORDTQT"].ToString() + ",");
                sCSVBuilder.Append(dr["ORDTSQ"].ToString() + ",");
                if (ConfigurationManager.AppSettings["RX"] != "yes")
                {
                    sCSVBuilder.Append(dr["RETAIL"].ToString() + ",");
                }
                sCSVBuilder.Append("\n");
            }
            sCSV = sCSVBuilder.ToString();

            DataView dv = new DataView(dt);

            dg.DataSource = dv;
            dg.DataBind();
        }
        catch (Exception ex) {
        }
        finally {
            OdbcConnection.Close();
        }
    }

    private void export_Click(System.Object sender, System.EventArgs e) {
        ExportToCSV();
    }

    private void ExportToExcel() {
        //ToolScriptManager

        Response.Clear();
        Response.Charset = "";
        //Response.ContentType = "application/vnd.ms-excel"
        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        Response.AddHeader("Content-Disposition", "attachment; filename=Invoice_" + invoiceNo.ToString() + ".xls");

        System.IO.StringWriter sw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(sw);

        dg = new DataGrid();
        dg = item_list;

        dg.GridLines = GridLines.None;
        dg.HeaderStyle.Font.Bold = true;
        dg.Visible = true;
        dg.AllowPaging = false;
        dg.AllowSorting = false;

        LoadView();

        HtmlForm frm = new HtmlForm();
        dg.Parent.Controls.Add(frm);
        frm.Attributes["runat"] = "server";
        frm.Controls.Add(dg);

        frm.RenderControl(hw);

        Response.Write(sw);
        Response.End();
    }

    private void ExportToCSV()
    {
        Response.Clear();
        Response.Charset = "";
        Response.Buffer = true;

        Response.ContentType = "application/text";
        Response.AddHeader("content-disposition", "attachment;filename=Invoice_" + invoiceNo.ToString() + ".csv");

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