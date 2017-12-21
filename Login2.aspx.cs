using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.WebControls;
using Turningpoint.Shared;
using System.IO;

namespace TurningpointSystems
{
    public partial class Login2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String sColor = "white";
            try 
            {
                sColor = ConfigurationManager.AppSettings["PageBackColor"].ToString();
            }
            catch 
            {
                sColor = "white";
            }
            body.Style.Add("background-color", sColor);
            Session["PageBackColor"] = sColor;

            string sLogin1 = ConfigurationManager.AppSettings["Site1_Login_Button"].ToString();
            if (sLogin1.Length > 0)
            {
                btnSubmitLogin1.Text = sLogin1;
                btnSubmitLogin1.Visible = true;
            }

            string sLogin2 = ConfigurationManager.AppSettings["Site2_Login_Button"].ToString();
            if (sLogin2.Length > 0)
            {
                btnSubmitLogin2.Text = sLogin2;
                btnSubmitLogin2.Visible = true;
            }

            string sLWD = ConfigurationManager.AppSettings["LWD"].ToString();
            if (sLWD == "yes")
            {
                company_logo.Visible = false;
            }

            if (!File.Exists(Server.MapPath("images/login/banner_bottom.jp")))
            {
                banner_bottom.Visible = false;
            }

            if (!File.Exists(Server.MapPath("images/login/banner_top.jp")))
            {
                banner_top.Visible = false;
            }

            try
            {
                string sHidePwd = ConfigurationManager.AppSettings["HidePasswordLink"].ToString();
                if (sHidePwd == "yes")
                {
                    forgot_password.Visible = false;
                }
            }
            catch (Exception ex)
            {
            }

            try
            {
                string sHideNotaCust = ConfigurationManager.AppSettings["HideNewCustomerLink"].ToString();
                if (sHideNotaCust == "yes")
                {
                    not_a_cust.Visible = false;
                }
            }
            catch (Exception ex)
            {
            }

            if (!Page.IsPostBack)
            {
                if (Request.Cookies["Userid"] != null) // code to place the value in cookie in to username textbox
                {
                    //remember.Checked = true;
                    HttpCookie usercook = new HttpCookie("Userid");
                    usercook = Request.Cookies["Userid"];
                    login_name.Value = usercook.Value;

                }
                // if a username was found on the query string then populate
                // the login_name with that.
                string name = Request.QueryString["name"];
                if (name != null && name != String.Empty)
                {
                    login_name.Value = name;
                }
            }
            else
            {
                string controlName = Request.Params.Get("__EVENTTARGET");
                if (controlName == "forgot_password")
                {
                    string userName = login_name.Value;
                    // Validate that userName exists. If not, write some 
                    // error output to an error label that doesn't exist yet
                    // and don't redirect.
                    //
                    string url = "ForgotPassword.aspx?name=" + userName;
                    Response.Redirect(url);
                }
            }

            login_name.Focus();
        }

        protected void btnSubmit2_click(object sender, EventArgs e)
        {
            Session["LibList"] = ConfigurationManager.AppSettings["Site2_Libraries"].ToString();

            /*
            if (remember.Checked == true) // code to store the text in textbox in to cookie when remember me is checked
            {
                if (Request.Browser.Cookies == true)
                {
                    HttpCookie loginCook = new HttpCookie("Userid");
                    loginCook.Value = login_name.Value;
                    loginCook.Expires = DateTime.MaxValue;
                    Response.Cookies.Add(loginCook);
                }
                else
                {
                    Response.Write("Please Enable the Cookies in your Browser");
                }
            }
            */
            // (dfr) login_password.Value.ToUpper() needs to change - won't work for non-TP customer
            //
            Turningpoint.Data.TurningpointDataComponent databaseComponent = new Turningpoint.Data.TurningpointDataComponent();
            try
            {
                databaseComponent.SetLibList(Session["LibList"].ToString());
            }
            catch (Exception ex)
            {
            }

            UserDetail userDetails = databaseComponent.AuthenticateUser(login_name.Value.ToUpper(), login_password.Value.ToUpper());
            // UserDetail userDetails = new UserDetail() { AR = "Y", Invoices = "Y", Items = "Y", Orders = "Y", QOH = "Y", Retails = "Y" };

            if (userDetails != null)
            {
                Session["UserDetails"] = userDetails;

                if ((userDetails.ChainMgr == "Y") || (userDetails.Salesman != "0") || (userDetails.ChainMgr == "A"))
                {
                    Response.Redirect("CustomerSelect.aspx"); //navigation to chain customer select page
                }
                else if (userDetails.ChainMgr == "W")
                {
                    Response.Redirect("OrderListRedirect.aspx"); //navigation to welcome page
                }
                else if ((userDetails.ChainMgr == "P") || (userDetails.Type == "B"))
                {
                    if (ConfigurationManager.AppSettings["LWD"].ToString() == "yes")
                    {
                        Response.Redirect("CSOSPurchaseOrders.aspx"); //navigation to welcome page
                    }
                    else
                    {
                        Response.Redirect("Vendors.aspx"); 
                    }
                }
                else
                {
                    if (ConfigurationManager.AppSettings["ShowMessages"] == "yes")
                    {
                        int nMessageCount = databaseComponent.GetMessageCount(userDetails.TPSCustomerNumber);

                        if (nMessageCount > 0)
                        {
                            Response.Redirect("Messages.aspx"); //navigation to welcome page
                        }
                        else
                        {
                            Response.Redirect("Welcome.aspx"); //navigation to welcome page
                        }
                    }
                    else
                    {
                        Response.Redirect("Welcome.aspx"); //navigation to welcome page
                    }
                }
            }
            else
            {
                Response.Redirect("Welcome.aspx");      // and because no UserDetails in session, gets Login again (i think that must be what's happening here)
            }
        }

        protected void btnSubmit1_click(object sender, EventArgs e)
        {
            Session["LibList"] = ConfigurationManager.AppSettings["Site1_Libraries"].ToString();

            /*
            if (remember.Checked == true) // code to store the text in textbox in to cookie when remember me is checked
            {
                if (Request.Browser.Cookies == true)
                {
                    HttpCookie loginCook = new HttpCookie("Userid");
                    loginCook.Value = login_name.Value;
                    loginCook.Expires = DateTime.MaxValue;
                    Response.Cookies.Add(loginCook);
                }
                else
                {
                    Response.Write("Please Enable the Cookies in your Browser");
                }
            }
            */
            // (dfr) login_password.Value.ToUpper() needs to change - won't work for non-TP customer
            //
            Turningpoint.Data.TurningpointDataComponent databaseComponent = new Turningpoint.Data.TurningpointDataComponent();
            try
            {
                databaseComponent.SetLibList(Session["LibList"].ToString());
            }
            catch (Exception ex)
            {
            }
            
            UserDetail userDetails = databaseComponent.AuthenticateUser(login_name.Value.ToUpper(), login_password.Value.ToUpper());
            // UserDetail userDetails = new UserDetail() { AR = "Y", Invoices = "Y", Items = "Y", Orders = "Y", QOH = "Y", Retails = "Y" };

            if (userDetails != null)
            {
                Session["UserDetails"] = userDetails;

                if ((userDetails.ChainMgr == "Y") || (userDetails.Salesman != "0") || (userDetails.ChainMgr == "A"))
                {
                    Response.Redirect("CustomerSelect.aspx"); //navigation to chain customer select page
                }
                else
                {
                    Response.Redirect("Welcome.aspx"); //navigation to welcome page
                }
            }
            else
            {
                Response.Redirect("Welcome.aspx");      // and because no UserDetails in session, gets Login again (i think that must be what's happening here)
            }
        }
    }
}
