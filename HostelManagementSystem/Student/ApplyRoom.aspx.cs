using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Student
{
    public partial class ApplyRoom : System.Web.UI.Page
    {
        private readonly RoomBLL _roomBLL = new RoomBLL();
        private readonly AllocationBLL _allocationBLL = new AllocationBLL();

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
                LoadBlocksDropdown();
                LoadRooms();
            }
        }

        private void LoadBlocksDropdown()
        {
            DataTable dt = _roomBLL.GetAllBlocks();
            ddlFilterBlock.Items.Clear();
            ddlFilterBlock.Items.Add(new ListItem("All Blocks", "0"));
            
            foreach (DataRow row in dt.Rows)
            {
                ddlFilterBlock.Items.Add(new ListItem(row["BlockName"].ToString(), row["BlockID"].ToString()));
            }
        }

        private void LoadRooms()
        {
            int blockID = Convert.ToInt32(ddlFilterBlock.SelectedValue);
            string roomType = ddlFilterRoomType.SelectedValue;
            
            decimal maxFee = 0;
            if (!string.IsNullOrEmpty(txtFilterMaxFee.Text.Trim()))
            {
                decimal.TryParse(txtFilterMaxFee.Text.Trim(), out maxFee);
            }

            DataTable dt = _roomBLL.SearchRooms(blockID, roomType, maxFee);
            
            // Filter only rooms that are actually available (occupied < capacity)
            DataTable dtAvailable = dt.Clone();
            foreach (DataRow row in dt.Rows)
            {
                int capacity = Convert.ToInt32(row["Capacity"]);
                int occupied = Convert.ToInt32(row["OccupiedBeds"]);
                string status = row["Status"].ToString();
                
                if (occupied < capacity && status == "Available")
                {
                    dtAvailable.ImportRow(row);
                }
            }

            if (dtAvailable.Rows.Count > 0)
            {
                rptAvailableRooms.DataSource = dtAvailable;
                rptAvailableRooms.DataBind();
                pnlRoomList.Visible = true;
                pnlNoRooms.Visible = false;
            }
            else
            {
                pnlRoomList.Visible = false;
                pnlNoRooms.Visible = true;
            }
        }

        protected void btnFilterApply_Click(object sender, EventArgs e)
        {
            lblStatusMessage.Text = string.Empty;
            LoadRooms();
        }

        protected void rptAvailableRooms_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ApplyRoom")
            {
                int studentID = Convert.ToInt32(Session["StudentID"]);
                int roomID = Convert.ToInt32(e.CommandArgument);

                string errorMessage;
                bool success = _allocationBLL.ApplyForRoom(studentID, roomID, out errorMessage);

                if (success)
                {
                    lblStatusMessage.Text = "Your room application has been submitted successfully! Please wait for warden approval.";
                    lblStatusMessage.ForeColor = System.Drawing.Color.Green;
                    
                    // Show dynamic toast notification
                    string script = "showToast('Room application submitted! Pending admin review.', 'success');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ApplySuccessToast", script, true);
                    
                    // Refresh available rooms list
                    LoadRooms();
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
