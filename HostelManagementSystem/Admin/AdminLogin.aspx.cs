using System;
using System.Data;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Admin
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        private readonly AdminBLL _adminBLL = new AdminBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblStatusMessage.Text = string.Empty;
            }
        }

        protected void btnAdminLoginSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string username = txtAdminUsername.Text.Trim();
                string password = txtAdminPassword.Text;

                string errorMessage;
                DataTable dt = _adminBLL.LoginAdmin(username, password, out errorMessage);

                if (dt != null && dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    
                    // Session Management
                    Session["AdminID"] = row["AdminID"];
                    Session["AdminUsername"] = row["Username"];
                    Session["AdminRole"] = row["Role"];

                    // Redirect to Warden Dashboard
                    Response.Redirect("~/Admin/AdminDashboard");
                }
                else
                {
                    lblStatusMessage.Text = errorMessage;
                    lblStatusMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}
