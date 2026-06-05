using System;
using System.Data;
using System.Web.UI.WebControls;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Admin
{
    public partial class Reports : System.Web.UI.Page
    {
        private readonly PaymentBLL _paymentBLL = new PaymentBLL();
        private readonly StudentBLL _studentBLL = new StudentBLL();
        private readonly RoomBLL _roomBLL = new RoomBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblStatusMessage.Text = string.Empty;
                txtStartDate.Text = DateTime.Now.AddMonths(-3).ToString("yyyy-MM-dd");
                txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                CompileReport();
            }
        }

        protected void ddlReportType_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblStatusMessage.Text = string.Empty;
            CompileReport();
        }

        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            lblStatusMessage.Text = string.Empty;
            CompileReport();
        }

        private void CompileReport()
        {
            string category = ddlReportType.SelectedValue;
            
            DateTime start = DateTime.MinValue;
            if (!string.IsNullOrEmpty(txtStartDate.Text))
            {
                DateTime.TryParse(txtStartDate.Text, out start);
            }

            DateTime end = DateTime.MaxValue;
            if (!string.IsNullOrEmpty(txtEndDate.Text))
            {
                DateTime.TryParse(txtEndDate.Text, out end);
            }

            if (category == "Payments")
            {
                lblReportTitle.Text = "Financial Fee Collection Ledger";
                
                DataTable dt = _paymentBLL.GetAllPayments();
                
                DataTable dtReport = new DataTable();
                dtReport.Columns.Add("Receipt ID");
                dtReport.Columns.Add("Student Name");
                dtReport.Columns.Add("Transaction Date");
                dtReport.Columns.Add("Method");
                dtReport.Columns.Add("Transaction ID");
                dtReport.Columns.Add("Amount");
                dtReport.Columns.Add("Status");

                decimal totalCollected = 0;
                int count = 0;

                foreach (DataRow row in dt.Rows)
                {
                    DateTime payDate = Convert.ToDateTime(row["PaymentDate"]);
                    if (payDate >= start && payDate <= end.AddDays(1))
                    {
                        decimal amount = Convert.ToDecimal(row["Amount"]);
                        string status = row["Status"].ToString();
                        
                        if (status.Equals("Paid", StringComparison.OrdinalIgnoreCase))
                        {
                            totalCollected += amount;
                        }

                        dtReport.Rows.Add(
                            row["PaymentID"],
                            row["FullName"],
                            payDate.ToString("dd MMM yyyy hh:mm tt"),
                            row["PaymentMethod"],
                            row["TransactionID"],
                            "Rs. " + amount.ToString("N2"),
                            status
                        );
                        count++;
                    }
                }

                gvReportOutput.DataSource = dtReport;
                gvReportOutput.DataBind();

                lblRecordCount.Text = count.ToString() + " Payments";
                lblSummaryValue.Text = "Rs. " + totalCollected.ToString("N2") + " (Paid)";
                pnlSummaryTotal.Visible = true;
            }
            else if (category == "Students")
            {
                lblReportTitle.Text = "Student Occupancy Directory";

                DataTable dt = _studentBLL.GetAllStudents();

                DataTable dtReport = new DataTable();
                dtReport.Columns.Add("Student ID");
                dtReport.Columns.Add("Student Name");
                dtReport.Columns.Add("Email");
                dtReport.Columns.Add("Mobile");
                dtReport.Columns.Add("Course");
                dtReport.Columns.Add("Year");
                dtReport.Columns.Add("Registration Date");
                dtReport.Columns.Add("Status");

                int count = 0;
                foreach (DataRow row in dt.Rows)
                {
                    DateTime regDate = Convert.ToDateTime(row["RegistrationDate"]);
                    if (regDate >= start && regDate <= end.AddDays(1))
                    {
                        dtReport.Rows.Add(
                            row["StudentID"],
                            row["FullName"],
                            row["Email"],
                            row["Mobile"],
                            row["Course"],
                            row["Year"],
                            regDate.ToString("dd MMM yyyy"),
                            row["Status"]
                        );
                        count++;
                    }
                }

                gvReportOutput.DataSource = dtReport;
                gvReportOutput.DataBind();

                lblRecordCount.Text = count.ToString() + " Students";
                lblSummaryValue.Text = "Active registrations";
                pnlSummaryTotal.Visible = true;
            }
            else if (category == "Rooms")
            {
                lblReportTitle.Text = "Room Allocation Status";

                DataTable dt = _roomBLL.GetAllRooms();

                DataTable dtReport = new DataTable();
                dtReport.Columns.Add("Room Number");
                dtReport.Columns.Add("Block");
                dtReport.Columns.Add("Room Type");
                dtReport.Columns.Add("Beds Capacity");
                dtReport.Columns.Add("Occupied Beds");
                dtReport.Columns.Add("Vacant Beds");
                dtReport.Columns.Add("Monthly Fee");
                dtReport.Columns.Add("Status");

                int totalBeds = 0;
                int occupiedBeds = 0;
                int count = 0;

                foreach (DataRow row in dt.Rows)
                {
                    int cap = Convert.ToInt32(row["Capacity"]);
                    int occ = Convert.ToInt32(row["OccupiedBeds"]);
                    
                    totalBeds += cap;
                    occupiedBeds += occ;

                    dtReport.Rows.Add(
                        row["RoomNumber"],
                        row["BlockName"],
                        row["RoomType"],
                        cap,
                        occ,
                        cap - occ,
                        "Rs. " + Convert.ToDecimal(row["MonthlyFee"]).ToString("N2"),
                        row["Status"]
                    );
                    count++;
                }

                gvReportOutput.DataSource = dtReport;
                gvReportOutput.DataBind();

                lblRecordCount.Text = count.ToString() + " Rooms";
                lblSummaryValue.Text = occupiedBeds + " / " + totalBeds + " Beds Occupied";
                pnlSummaryTotal.Visible = true;
            }
        }
    }
}
