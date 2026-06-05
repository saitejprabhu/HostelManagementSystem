using System;
using System.Data;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Student
{
    public partial class StudentDashboard : System.Web.UI.Page
    {
        private readonly StudentBLL _studentBLL = new StudentBLL();
        private readonly AllocationBLL _allocationBLL = new AllocationBLL();
        private readonly PaymentBLL _paymentBLL = new PaymentBLL();
        private readonly ComplaintBLL _complaintBLL = new ComplaintBLL();

        protected string AccountStatus = "Pending";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Session security check
            if (Session["StudentID"] == null)
            {
                Response.Redirect("~/Pages/StudentLogin");
                return;
            }

            if (!IsPostBack)
            {
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            int studentID = Convert.ToInt32(Session["StudentID"]);

            // 1. Get Student profile & status
            DataTable dtStudent = _studentBLL.GetStudentByID(studentID);
            if (dtStudent.Rows.Count > 0)
            {
                DataRow student = dtStudent.Rows[0];
                lblStudentName.Text = student["FullName"].ToString();
                AccountStatus = student["Status"].ToString();
                lblAccountStatus.Text = AccountStatus;

                // Load Avatar image
                string profilePic = student["ProfilePicture"].ToString();
                if (!string.IsNullOrEmpty(profilePic))
                {
                    imgAvatar.ImageUrl = Page.ResolveUrl("~/Documents/ProfilePictures/" + profilePic);
                }
                else
                {
                    imgAvatar.ImageUrl = Page.ResolveUrl("~/Images/default-avatar.png");
                }
            }

            // 2. Get Active Allocation Details
            DataTable dtAlloc = _allocationBLL.GetActiveAllocationByStudent(studentID);
            if (dtAlloc.Rows.Count > 0)
            {
                DataRow alloc = dtAlloc.Rows[0];
                lblRoomNumber.Text = "Room " + alloc["RoomNumber"].ToString();
                lblBlockName.Text = alloc["BlockName"].ToString() + " (" + alloc["RoomType"].ToString() + ")";
            }
            else
            {
                lblRoomNumber.Text = "No Active Room";
                lblBlockName.Text = "Click 'Apply Room' to request accommodation.";
            }

            // 3. Get Payment History
            DataTable dtPayments = _paymentBLL.GetPaymentsByStudent(studentID);
            if (dtPayments.Rows.Count > 0)
            {
                DataRow lastPayment = dtPayments.Rows[0];
                lblLastPaymentAmount.Text = "Rs. " + Convert.ToDecimal(lastPayment["Amount"]).ToString("N2");
                lblLastPaymentDate.Text = "Paid on: " + Convert.ToDateTime(lastPayment["PaymentDate"]).ToString("dd MMM yyyy");
            }
            else
            {
                lblLastPaymentAmount.Text = "No Payments";
                lblLastPaymentDate.Text = "No previous transactions found.";
            }

            // 4. Get Complaints Summary
            DataTable dtComplaints = _complaintBLL.GetComplaintsByStudent(studentID);
            int total = dtComplaints.Rows.Count;
            int pending = 0;
            foreach (DataRow row in dtComplaints.Rows)
            {
                if (row["Status"].ToString().Equals("Pending", StringComparison.OrdinalIgnoreCase))
                {
                    pending++;
                }
            }
            lblTotalComplaints.Text = total.ToString() + " Ticket(s)";
            lblPendingComplaints.Text = pending.ToString();
        }

        protected string GetStatusBadgeClass()
        {
            if (AccountStatus.Equals("Approved", StringComparison.OrdinalIgnoreCase))
                return "badge-approved";
            if (AccountStatus.Equals("Suspended", StringComparison.OrdinalIgnoreCase))
                return "badge-suspended";
            return "badge-pending";
        }
    }
}
