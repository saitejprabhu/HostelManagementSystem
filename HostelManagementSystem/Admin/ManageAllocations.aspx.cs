using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Admin
{
    public partial class ManageAllocations : System.Web.UI.Page
    {
        private readonly AllocationBLL _allocationBLL = new AllocationBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblStatusMessage.Text = string.Empty;
                LoadAllocations();
            }
        }

        private void LoadAllocations()
        {
            DataTable dtPending = _allocationBLL.GetPendingAllocations();
            gvPendingAllocations.DataSource = dtPending;
            gvPendingAllocations.DataBind();

            DataTable dtAll = _allocationBLL.GetAllAllocations();
            gvAllAllocations.DataSource = dtAll;
            gvAllAllocations.DataBind();
        }

        protected void gvPendingAllocations_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvPendingAllocations.Rows[index];

            int allocationID = Convert.ToInt32(gvPendingAllocations.DataKeys[index].Values["AllocationID"]);
            int roomID = Convert.ToInt32(gvPendingAllocations.DataKeys[index].Values["RoomID"]);

            if (e.CommandName == "ApproveAlloc")
            {
                string errorMessage;
                bool success = _allocationBLL.ApproveAllocation(allocationID, roomID, out errorMessage);

                if (success)
                {
                    LoadAllocations();
                    string script = "showToast('Room allocation request approved successfully!', 'success');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ApproveAllocToast", script, true);
                }
                else
                {
                    lblStatusMessage.Text = errorMessage;
                    lblStatusMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            else if (e.CommandName == "RejectAlloc")
            {
                bool success = _allocationBLL.RejectAllocation(allocationID);
                if (success)
                {
                    LoadAllocations();
                    string script = "showToast('Room allocation request cancelled.', 'warning');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "RejectAllocToast", script, true);
                }
            }
        }

        protected void gvAllAllocations_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CheckoutStudent")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int allocationID = Convert.ToInt32(gvAllAllocations.DataKeys[index].Values["AllocationID"]);
                int roomID = Convert.ToInt32(gvAllAllocations.DataKeys[index].Values["RoomID"]);
                int studentID = Convert.ToInt32(gvAllAllocations.DataKeys[index].Values["StudentID"]);

                bool success = _allocationBLL.CheckOutAllocation(allocationID, roomID, studentID);
                if (success)
                {
                    LoadAllocations();
                    string script = "showToast('Student checked out successfully.', 'info');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "CheckoutToast", script, true);
                }
                else
                {
                    lblStatusMessage.Text = "Failed to checkout student record.";
                    lblStatusMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected string GetStatusBadgeClass(string status)
        {
            if (status.Equals("Active", StringComparison.OrdinalIgnoreCase))
                return "badge-approved";
            if (status.Equals("Pending", StringComparison.OrdinalIgnoreCase))
                return "badge-pending";
            if (status.Equals("CheckedOut", StringComparison.OrdinalIgnoreCase))
                return "badge-checkedout";
            return "badge-cancelled";
        }
    }
}
