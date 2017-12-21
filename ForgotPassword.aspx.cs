using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Turningpoint.Shared;
using Turningpoint.Data;

namespace TurningpointSystems
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string name = Request.QueryString["name"];
                if (name != null && name != String.Empty)
                {
                    txt_username.Text = name;
                    setquestion(name);
                }
            }

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

            cust_service.Text = ConfigurationManager.AppSettings["CustomerServiceMessage"];
        }

        private void setquestion(string name)
        {
            TurningpointDataComponent databasecomp = new TurningpointDataComponent();
            ForgotPasswordResponse response = databasecomp.GetUserQuestion(name.ToUpper());

            if (response.Question != null && response.Question != String.Empty)
                txt_question.Text = response.Question.ToString().Trim();
            else
            {
                name = name.ToUpper();
                txt_question.Text = String.Format(
                    "No question was found for username {0}. Please contact your administrator", name);
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            TurningpointDataComponent dataComponent = new TurningpointDataComponent();
            ForgotPasswordResponse response = dataComponent.VerifyUserAnswer(txt_username.Text.ToUpper(), txt_answer.Text.ToUpper());

            if (response.Status == false)
                lbl_password.Text = "Your answer was incorrect. Please contact your administrator for assistance.";
            else
                lbl_password.Text = "Your password is: " + response.Password.ToString();
        }

        protected void btnGetQuestion_Click(object sender, EventArgs e)
        {
            setquestion(txt_username.Text);
        }

        protected void btnGoToLogin_Click(object sender, EventArgs e)
        {
            string url = "Login.aspx" + ((txt_username.Text != String.Empty) ? "?name=" + txt_username.Text : String.Empty);
            Response.Redirect(url);
        }
    }
}
