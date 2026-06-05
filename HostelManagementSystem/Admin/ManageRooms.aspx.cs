using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Admin
{
    public partial class ManageRooms : System.Web.UI.Page
    {
        private readonly RoomBLL _roomBLL = new RoomBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblStatusMessage.Text = string.Empty;
                LoadBlocksDropdown();
                LoadRooms();
            }
        }

        private void LoadBlocksDropdown()
        {
            DataTable dt = _roomBLL.GetAllBlocks();
            ddlBlockSelect.Items.Clear();
            foreach (DataRow row in dt.Rows)
            {
                ddlBlockSelect.Items.Add(new ListItem(row["BlockName"].ToString(), row["BlockID"].ToString()));
            }
        }

        private void LoadRooms()
        {
            DataTable dt = _roomBLL.GetAllRooms();
            gvRooms.DataSource = dt;
            gvRooms.DataBind();
        }

        protected void btnBlockSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string blockName = txtBlockName.Text.Trim();
                string description = txtBlockDesc.Text.Trim();

                string errorMessage;
                bool success = _roomBLL.AddBlock(blockName, description, out errorMessage);

                if (success)
                {
                    txtBlockName.Text = string.Empty;
                    txtBlockDesc.Text = string.Empty;
                    LoadBlocksDropdown();
                    
                    string script = "showToast('Hostel Block added successfully!', 'success');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "BlockAddToast", script, true);
                }
                else
                {
                    lblStatusMessage.Text = errorMessage;
                    lblStatusMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void btnRoomSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (ddlBlockSelect.Items.Count == 0)
                {
                    lblStatusMessage.Text = "Please create a Hostel Block first before adding rooms.";
                    lblStatusMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                int blockID = Convert.ToInt32(ddlBlockSelect.SelectedValue);
                string roomNumber = txtRoomNumber.Text.Trim();
                int floorNumber = Convert.ToInt32(txtFloorNumber.Text);
                string roomType = ddlRoomTypeSelect.SelectedValue;
                int capacity = Convert.ToInt32(txtCapacity.Text);
                decimal monthlyFee = Convert.ToDecimal(txtMonthlyFee.Text);

                string errorMessage;
                bool success = _roomBLL.AddRoom(roomNumber, roomType, capacity, floorNumber, monthlyFee, blockID, out errorMessage);

                if (success)
                {
                    txtRoomNumber.Text = string.Empty;
                    txtFloorNumber.Text = string.Empty;
                    txtCapacity.Text = string.Empty;
                    txtMonthlyFee.Text = string.Empty;
                    
                    LoadRooms();

                    string script = "showToast('Room added successfully!', 'success');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "RoomAddToast", script, true);
                }
                else
                {
                    lblStatusMessage.Text = errorMessage;
                    lblStatusMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void gvRooms_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvRooms.EditIndex = e.NewEditIndex;
            LoadRooms();
        }

        protected void gvRooms_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvRooms.EditIndex = -1;
            LoadRooms();
        }

        protected void gvRooms_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvRooms.Rows[e.RowIndex];
            int roomID = Convert.ToInt32(gvRooms.DataKeys[e.RowIndex].Values["RoomID"]);

            TextBox txtRoomNum = (TextBox)row.FindControl("txtEditRoomNumber");
            DropDownList ddlType = (DropDownList)row.FindControl("ddlEditRoomType");
            TextBox txtCap = (TextBox)row.FindControl("txtEditCapacity");
            TextBox txtFee = (TextBox)row.FindControl("txtEditMonthlyFee");
            DropDownList ddlStatus = (DropDownList)row.FindControl("ddlEditStatus");

            if (txtRoomNum != null && ddlType != null && txtCap != null && txtFee != null && ddlStatus != null)
            {
                string roomNumber = txtRoomNum.Text.Trim();
                string roomType = ddlType.SelectedValue;
                int capacity = Convert.ToInt32(txtCap.Text);
                decimal monthlyFee = Convert.ToDecimal(txtFee.Text);
                string status = ddlStatus.SelectedValue;

                string errorMessage;
                bool success = _roomBLL.UpdateRoom(roomID, roomNumber, roomType, capacity, 0, monthlyFee, status, out errorMessage);

                if (success)
                {
                    gvRooms.EditIndex = -1;
                    LoadRooms();

                    string script = "showToast('Room details updated successfully!', 'success');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "RoomUpdateToast", script, true);
                }
                else
                {
                    lblStatusMessage.Text = errorMessage;
                    lblStatusMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void gvRooms_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int roomID = Convert.ToInt32(gvRooms.DataKeys[e.RowIndex].Values["RoomID"]);
            int blockID = Convert.ToInt32(gvRooms.DataKeys[e.RowIndex].Values["BlockID"]);

            bool success = _roomBLL.DeleteRoom(roomID, blockID);

            if (success)
            {
                LoadRooms();
                string script = "showToast('Room deleted successfully!', 'warning');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "RoomDeleteToast", script, true);
            }
            else
            {
                lblStatusMessage.Text = "Failed to delete room. Ensure no active student is allocated to this room.";
                lblStatusMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected string GetStatusBadgeClass(string status)
        {
            if (status.Equals("Available", StringComparison.OrdinalIgnoreCase))
                return "badge-approved";
            if (status.Equals("Full", StringComparison.OrdinalIgnoreCase))
                return "badge-pending";
            return "badge-cancelled";
        }
    }
}
