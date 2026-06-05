using System;
using System.Web;
using System.Web.UI;

namespace HostelManagementSystem.MasterPages
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Set cache policy to prevent back-button viewing after logout
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoStore();
        }

        protected void btnStudentLogout_Click(object sender, EventArgs e)
        {
            // Clear student session
            Session.Clear();
            Session.Abandon();

            // Clear remember-me cookie if present
            if (Response.Cookies["StudentEmail"] != null)
            {
                Response.Cookies["StudentEmail"].Expires = DateTime.Now.AddDays(-1);
            }

            // Redirect to Login page
            Response.Redirect("~/Pages/StudentLogin");
        }
    }
}
