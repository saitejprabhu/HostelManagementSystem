using System;
using System.Data;
using System.Web.UI;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Student
{
    public partial class Payment : System.Web.UI.Page
    {
        private readonly AllocationBLL _allocationBLL = new AllocationBLL();
        private readonly PaymentBLL _paymentBLL = new PaymentBLL();

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
                CheckAllocationAndInvoice();
            }
        }

        private void CheckAllocationAndInvoice()
        {
            int studentID = Convert.ToInt32(Session["StudentID"]);
            DataTable dtAlloc = _allocationBLL.GetActiveAllocationByStudent(studentID);

            if (dtAlloc.Rows.Count > 0)
            {
                DataRow alloc = dtAlloc.Rows[0];
                pnlNoAllocation.Visible = false;
                pnlPaymentForm.Visible = true;

                lblRoomDetails.Text = "Room " + alloc["RoomNumber"].ToString() + " (" + alloc["BlockName"].ToString() + ")";
                
                decimal monthlyFee = Convert.ToDecimal(alloc["MonthlyFee"]);
                lblAmountDue.Text = monthlyFee.ToString("N2");
                ViewState["AmountDue"] = monthlyFee;
            }
            else
            {
                pnlNoAllocation.Visible = true;
                pnlPaymentForm.Visible = false;
            }
        }

        protected void btnProcessPayment_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int studentID = Convert.ToInt32(Session["StudentID"]);
                decimal amount = Convert.ToDecimal(ViewState["AmountDue"]);
                string paymentMethod = ddlPaymentMethod.SelectedValue;
                string transactionID = txtTransactionID.Text.Trim();

                string errorMessage;
                bool success = _paymentBLL.RecordPayment(studentID, amount, paymentMethod, transactionID, out errorMessage);

                if (success)
                {
                    // Redirect to payment history page with success flag
                    Response.Redirect("~/Student/PaymentHistory?pay=success");
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
