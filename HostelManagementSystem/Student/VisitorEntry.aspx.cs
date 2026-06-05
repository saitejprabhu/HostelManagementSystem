using System;
using System.Data;
using System.Web.UI;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Student
{
    public partial class VisitorEntry : System.Web.UI.Page
    {
        private readonly VisitorBLL _visitorBLL = new VisitorBLL();

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
                txtVisitDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtCheckInTime.Text = DateTime.Now.ToString("HH:mm");
                LoadVisitorHistory();
            }
        }

        private void LoadVisitorHistory()
        {
            int studentID = Convert.ToInt32(Session["StudentID"]);
            DataTable dt = _visitorBLL.GetVisitorLogsByStudent(studentID);
            
            gvVisitorLogs.DataSource = dt;
            gvVisitorLogs.DataBind();
        }

        protected void btnSubmitVisitor_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int studentID = Convert.ToInt32(Session["StudentID"]);
                string visitorName = txtVisitorName.Text.Trim();
                string relationship = txtRelationship.Text.Trim();
                DateTime visitDate = DateTime.Parse(txtVisitDate.Text);
                TimeSpan checkInTime = TimeSpan.Parse(txtCheckInTime.Text);

                string errorMessage;
                bool success = _visitorBLL.LogVisitorEntry(
                    studentID, visitorName, relationship, visitDate, checkInTime, out errorMessage
                );

                if (success)
                {
                    txtVisitorName.Text = string.Empty;
                    txtRelationship.Text = string.Empty;
                    txtVisitDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    txtCheckInTime.Text = DateTime.Now.ToString("HH:mm");

                    lblStatusMessage.Text = "Visitor logged successfully!";
                    lblStatusMessage.ForeColor = System.Drawing.Color.Green;

                    // Show dynamic toast
                    string script = "showToast('Visitor logged successfully!', 'success');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "VisitorSuccessToast", script, true);

                    LoadVisitorHistory();
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
