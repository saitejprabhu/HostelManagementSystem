using System;
using System.Web;
using System.Web.UI;

namespace HostelManagementSystem.MasterPages
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Set Cache-Control to prevent back-button after logout
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoStore();

            // Authorization: Ensure Admin Session exists
            if (Session["AdminID"] == null)
            {
                // Verify the page is not AdminLogin.aspx to avoid redirect loop
                string currentPage = Request.Url.AbsolutePath;
                if (!currentPage.EndsWith("AdminLogin", StringComparison.OrdinalIgnoreCase) && 
                    !currentPage.EndsWith("AdminLogin.aspx", StringComparison.OrdinalIgnoreCase))
                {
                    Response.Redirect("~/Admin/AdminLogin");
                }
            }
        }

        protected void btnAdminLogout_Click(object sender, EventArgs e)
        {
            // Clear Admin Session
            Session.Clear();
            Session.Abandon();

            // Redirect to Admin Login page
            Response.Redirect("~/Admin/AdminLogin");
        }
    }
}
