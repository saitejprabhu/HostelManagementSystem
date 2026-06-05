using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Admin
{
    public partial class ManageComplaints : System.Web.UI.Page
    {
        private readonly ComplaintBLL _complaintBLL = new ComplaintBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblStatusMessage.Text = string.Empty;
                LoadComplaints();
            }
        }

        private void LoadComplaints()
        {
            DataTable dt = _complaintBLL.GetAllComplaints();
            gvManageComplaints.DataSource = dt;
            gvManageComplaints.DataBind();
        }

        protected void gvManageComplaints_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvManageComplaints.EditIndex = e.NewEditIndex;
            LoadComplaints();
        }

        protected void gvManageComplaints_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvManageComplaints.EditIndex = -1;
            LoadComplaints();
        }

        protected void gvManageComplaints_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvManageComplaints.Rows[e.RowIndex];
            int complaintID = Convert.ToInt32(gvManageComplaints.DataKeys[e.RowIndex].Value);

            TextBox txtResponse = (TextBox)row.FindControl("txtEditResponse");
            DropDownList ddlStatus = (DropDownList)row.FindControl("ddlEditStatus");

            if (txtResponse != null && ddlStatus != null)
            {
                string responseText = txtResponse.Text.Trim();
                string status = ddlStatus.SelectedValue;

                string errorMessage;
                bool success = _complaintBLL.RespondToComplaint(complaintID, responseText, status, out errorMessage);

                if (success)
                {
                    gvManageComplaints.EditIndex = -1;
                    LoadComplaints();

                    string script = "showToast('Response logged and ticket status updated!', 'success');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ComplaintUpdateToast", script, true);
                }
                else
                {
                    lblStatusMessage.Text = errorMessage;
                    lblStatusMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
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
