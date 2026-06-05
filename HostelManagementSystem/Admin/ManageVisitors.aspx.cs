using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Admin
{
    public partial class ManageVisitors : System.Web.UI.Page
    {
        private readonly VisitorBLL _visitorBLL = new VisitorBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblStatusMessage.Text = string.Empty;
                LoadVisitorLogs();
            }
        }

        private void LoadVisitorLogs()
        {
            DataTable dtActive = _visitorBLL.GetActiveVisitors();
            gvActiveVisitors.DataSource = dtActive;
            gvActiveVisitors.DataBind();

            DataTable dtAll = _visitorBLL.GetAllVisitorLogs();
            gvVisitorHistory.DataSource = dtAll;
            gvVisitorHistory.DataBind();
        }

        protected void gvActiveVisitors_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "LogExit")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int visitorID = Convert.ToInt32(gvActiveVisitors.DataKeys[index].Value);

                TimeSpan checkOutTime = DateTime.Now.TimeOfDay;

                string errorMessage;
                bool success = _visitorBLL.LogVisitorExit(visitorID, checkOutTime, out errorMessage);

                if (success)
                {
                    LoadVisitorLogs();
                    string script = "showToast('Guest checkout registered!', 'success');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "VisitorExitToast", script, true);
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
