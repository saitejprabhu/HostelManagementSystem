using System;
using System.Web.UI;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Student
{
    public partial class RaiseComplaint : System.Web.UI.Page
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
            }
        }

        protected void btnSubmitComplaint_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int studentID = Convert.ToInt32(Session["StudentID"]);
                string subject = txtComplaintSubject.Text.Trim();
                string description = txtComplaintDesc.Text.Trim();

                string errorMessage;
                bool success = _complaintBLL.RaiseComplaint(studentID, subject, description, out errorMessage);

                if (success)
                {
                    // Redirect to complaint logs page with success flag
                    Response.Redirect("~/Student/ComplaintHistory?ticket=success");
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
