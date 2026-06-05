using System;
using System.Data;
using System.Web.UI;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Student
{
    public partial class ComplaintHistory : System.Web.UI.Page
    {
        private readonly ComplaintBLL _complaintBLL = new ComplaintBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["StudentID"] == null)
            {
                Response.Redirect("~/Pages/StudentLogin");
                return;
            }

            if (!IsPostBack)
            {
                lblStatusMessage.Text = string.Empty;

                if (Request.QueryString["ticket"] == "success")
                {
                    string script = "window.onload = function() { showToast('Grievance ticket logged successfully!', 'success'); };";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "TicketSuccessToast", script, true);
                }

                LoadComplaintsHistory();
            }
        }

        private void LoadComplaintsHistory()
        {
            int studentID = Convert.ToInt32(Session["StudentID"]);
            DataTable dt = _complaintBLL.GetComplaintsByStudent(studentID);
            
            gvComplaints.DataSource = dt;
            gvComplaints.DataBind();
        }

        protected string GetStatusBadgeClass(string status)
        {
            if (status.Equals("Resolved", StringComparison.OrdinalIgnoreCase))
                return "badge-approved";
            if (status.Equals("InProgress", StringComparison.OrdinalIgnoreCase))
                return "badge-pending";
            return "badge-cancelled";
        }
    }
}
