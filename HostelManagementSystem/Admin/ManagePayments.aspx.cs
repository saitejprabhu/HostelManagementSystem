using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Admin
{
    public partial class ManagePayments : System.Web.UI.Page
    {
        private readonly PaymentBLL _paymentBLL = new PaymentBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblStatusMessage.Text = string.Empty;
                LoadPayments();
            }
        }

        private void LoadPayments()
        {
            DataTable dt = _paymentBLL.GetAllPayments();
            gvManagePayments.DataSource = dt;
            gvManagePayments.DataBind();
        }

        protected void gvManagePayments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            int paymentID = Convert.ToInt32(gvManagePayments.DataKeys[index].Value);

            if (e.CommandName == "VerifyPayment")
            {
                bool success = _paymentBLL.UpdatePaymentStatus(paymentID, "Paid");
                if (success)
                {
                    LoadPayments();
                    string script = "showToast('Payment verified successfully!', 'success');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "VerifyPaymentToast", script, true);
                }
            }
            else if (e.CommandName == "RejectPayment")
            {
                bool success = _paymentBLL.UpdatePaymentStatus(paymentID, "Failed");
                if (success)
                {
                    LoadPayments();
                    string script = "showToast('Payment marked as Failed.', 'warning');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "RejectPaymentToast", script, true);
                }
            }
        }

        protected string GetStatusBadgeClass(string status)
        {
            if (status.Equals("Paid", StringComparison.OrdinalIgnoreCase))
                return "badge-approved";
            if (status.Equals("Failed", StringComparison.OrdinalIgnoreCase))
                return "badge-suspended";
            return "badge-pending";
        }
    }
}
