using System;
using System.Data;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Student
{
    public partial class RoomDetails : System.Web.UI.Page
    {
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
                LoadActiveRoomDetails();
            }
        }

        private void LoadActiveRoomDetails()
        {
            int studentID = Convert.ToInt32(Session["StudentID"]);
            DataTable dt = _allocationBLL.GetActiveAllocationByStudent(studentID);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                pnlNoRoom.Visible = false;
                pnlRoomDetails.Visible = true;

                lblRoomNumber.Text = "Room " + row["RoomNumber"].ToString();
                lblBlockName.Text = row["BlockName"].ToString();
                lblRoomType.Text = row["RoomType"].ToString();
                lblMonthlyFee.Text = Convert.ToDecimal(row["MonthlyFee"]).ToString("N2");
                lblFloorNumber.Text = row["FloorNumber"].ToString() + " Floor";
                lblSharingCapacity.Text = row["Capacity"].ToString() + " Sharing";

                lblAllocationDate.Text = Convert.ToDateTime(row["AllocationDate"]).ToString("dd MMMM yyyy");
                if (row["CheckInDate"] != DBNull.Value)
                {
                    lblCheckInDate.Text = Convert.ToDateTime(row["CheckInDate"]).ToString("dd MMMM yyyy");
                }
                else
                {
                    lblCheckInDate.Text = "Not Checked In yet";
                }
            }
            else
            {
                pnlNoRoom.Visible = true;
                pnlRoomDetails.Visible = false;
            }
        }
    }
}
