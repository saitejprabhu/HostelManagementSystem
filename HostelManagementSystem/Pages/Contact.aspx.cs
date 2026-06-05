using System;
using System.Web.UI;

namespace HostelManagementSystem.Pages
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnContactSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Clear fields
                txtContactName.Text = string.Empty;
                txtContactEmail.Text = string.Empty;
                txtContactSubject.Text = string.Empty;
                txtContactMessage.Text = string.Empty;

                // Show toast notification using ClientScript
                string script = "window.onload = function() { showToast('Thank you! Your feedback message has been sent successfully.', 'success'); };";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ContactSuccessToast", script, true);
            }
        }
    }
}
