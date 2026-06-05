using System;
using System.Data;
using System.Web;
using System.Web.UI;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Pages
{
    public partial class StudentLogin : System.Web.UI.Page
    {
        private readonly StudentBLL _studentBLL = new StudentBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblStatusMessage.Text = string.Empty;

                // Handle registration success toast
                if (Request.QueryString["reg"] == "success")
                {
                    string script = "window.onload = function() { showToast('Registration successful! Please login with your credentials.', 'success'); };";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "RegisterSuccessToast", script, true);
                }

                // Restore cookie if exists
                if (Request.Cookies["StudentEmail"] != null)
                {
                    txtLoginEmail.Text = Request.Cookies["StudentEmail"].Value;
                    chkRememberMe.Checked = true;
                }
            }
        }

        protected void btnLoginSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string email = txtLoginEmail.Text.Trim();
                string password = txtLoginPassword.Text;

                string errorMessage;
                DataTable dt = _studentBLL.LoginStudent(email, password, out errorMessage);

                if (dt != null && dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    
                    // Session Management
                    Session["StudentID"] = row["StudentID"];
                    Session["StudentName"] = row["FullName"];
                    Session["StudentEmail"] = row["Email"];

                    // Cookie Management (Remember Me)
                    if (chkRememberMe.Checked)
                    {
                        HttpCookie cookie = new HttpCookie("StudentEmail");
                        cookie.Value = email;
                        cookie.Expires = DateTime.Now.AddDays(30);
                        Response.Cookies.Add(cookie);
                    }
                    else
                    {
                        if (Request.Cookies["StudentEmail"] != null)
                        {
                            HttpCookie cookie = new HttpCookie("StudentEmail");
                            cookie.Expires = DateTime.Now.AddDays(-1);
                            Response.Cookies.Add(cookie);
                        }
                    }

                    // Redirect to student dashboard
                    Response.Redirect("~/Student/StudentDashboard");
                }
                else
                {
                    lblStatusMessage.Text = errorMessage;
                    lblStatusMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void btnForgotPassword_Click(object sender, EventArgs e)
        {
            // Simulate forgot password action
            string script = "window.onload = function() { showToast('Password recovery instructions have been sent to your registered email address.', 'info'); };";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "ForgotPwdToast", script, true);
        }
    }
}
