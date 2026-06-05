using System;
using System.Data;
using System.Web.UI;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Student
{
    public partial class PaymentHistory : System.Web.UI.Page
    {
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

                if (Request.QueryString["pay"] == "success")
                {
                    string script = "window.onload = function() { showToast('Payment details recorded! Awaiting warden statement reconciliation.', 'success'); };";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "PaymentSuccessToast", script, true);
                }

                LoadPaymentHistory();
            }
        }

        private void LoadPaymentHistory()
        {
            int studentID = Convert.ToInt32(Session["StudentID"]);
            DataTable dt = _paymentBLL.GetPaymentsByStudent(studentID);
            
            gvPaymentHistory.DataSource = dt;
            gvPaymentHistory.DataBind();
        }

        protected string GetStatusBadgeClass(string status)
        {
            if (status.Equals("Paid", StringComparison.OrdinalIgnoreCase))
                return "badge-paid";
            if (status.Equals("Failed", StringComparison.OrdinalIgnoreCase))
                return "badge-failed";
            return "badge-pending";
        }
    }
}
