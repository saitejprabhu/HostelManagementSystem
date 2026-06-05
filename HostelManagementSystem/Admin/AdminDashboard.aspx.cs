using System;
using System.Data;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        private readonly AdminBLL _adminBLL = new AdminBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Master page checks authorization automatically
            if (!IsPostBack)
            {
                LoadDashboardStats();
            }
        }

        private void LoadDashboardStats()
        {
            DataTable dt = _adminBLL.GetDashboardStats();
            if (dt.Rows.Count > 0)
            {
                DataRow stats = dt.Rows[0];
                lblTotalStudents.Text = stats["TotalStudents"].ToString();
                
                int occupied = Convert.ToInt32(stats["TotalOccupiedBeds"]);
                int capacity = Convert.ToInt32(stats["TotalCapacity"]);
                lblOccupiedBeds.Text = occupied.ToString();
                lblTotalBeds.Text = capacity.ToString();

                decimal revenue = Convert.ToDecimal(stats["TotalRevenue"]);
                lblTotalRevenue.Text = revenue.ToString("N2");

                lblPendingComplaints.Text = stats["PendingComplaints"].ToString();

                // Save count details inside ViewState to populate canvas client charts
                ViewState["OccupiedCount"] = occupied;
                ViewState["CapacityCount"] = capacity;
            }
        }
    }
}
