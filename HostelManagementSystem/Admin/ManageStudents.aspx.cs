using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Admin
{
    public partial class ManageStudents : System.Web.UI.Page
    {
        private readonly StudentBLL _studentBLL = new StudentBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblStatusMessage.Text = string.Empty;
                LoadStudents();
            }
        }

        private void LoadStudents()
        {
            DataTable dt = _studentBLL.GetAllStudents();
            
            // Search and Status filters
            string searchName = txtSearchName.Text.Trim();
            string filterStatus = ddlFilterStatus.SelectedValue;

            if (!string.IsNullOrEmpty(searchName) || !string.IsNullOrEmpty(filterStatus))
            {
                DataTable dtFiltered = dt.Clone();
                foreach (DataRow row in dt.Rows)
                {
                    bool matchName = string.IsNullOrEmpty(searchName) || 
                                     row["FullName"].ToString().IndexOf(searchName, StringComparison.OrdinalIgnoreCase) >= 0;
                    bool matchStatus = string.IsNullOrEmpty(filterStatus) || 
                                       row["Status"].ToString().Equals(filterStatus, StringComparison.OrdinalIgnoreCase);

                    if (matchName && matchStatus)
                    {
                        dtFiltered.ImportRow(row);
                    }
                }
                gvStudents.DataSource = dtFiltered;
            }
            else
            {
                gvStudents.DataSource = dt;
            }

            gvStudents.DataBind();
        }

        protected void btnSearchApply_Click(object sender, EventArgs e)
        {
            lblStatusMessage.Text = string.Empty;
            LoadStudents();
        }

        protected void btnSearchReset_Click(object sender, EventArgs e)
        {
            txtSearchName.Text = string.Empty;
            ddlFilterStatus.SelectedIndex = 0;
            lblStatusMessage.Text = string.Empty;
            LoadStudents();
        }

        protected void gvStudents_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvStudents.EditIndex = e.NewEditIndex;
            LoadStudents();
        }

        protected void gvStudents_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvStudents.EditIndex = -1;
            LoadStudents();
        }

        protected void gvStudents_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvStudents.Rows[e.RowIndex];
            int studentID = Convert.ToInt32(gvStudents.DataKeys[e.RowIndex].Value);

            TextBox txtName = (TextBox)row.FindControl("txtEditName");
            TextBox txtEmail = (TextBox)row.FindControl("txtEditEmail");
            TextBox txtMobile = (TextBox)row.FindControl("txtEditMobile");
            TextBox txtCourse = (TextBox)row.FindControl("txtEditCourse");
            TextBox txtYear = (TextBox)row.FindControl("txtEditYear");
            DropDownList ddlStatus = (DropDownList)row.FindControl("ddlEditStatus");

            if (txtName != null && txtEmail != null && txtMobile != null && txtCourse != null && txtYear != null && ddlStatus != null)
            {
                string fullName = txtName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string mobile = txtMobile.Text.Trim();
                string course = txtCourse.Text.Trim();
                int year = Convert.ToInt32(txtYear.Text);
                string status = ddlStatus.SelectedValue;

                bool success = _studentBLL.UpdateStudentDetailsByAdmin(
                    studentID, fullName, email, mobile, "", course, year, status
                );

                if (success)
                {
                    gvStudents.EditIndex = -1;
                    LoadStudents();
                    
                    string script = "showToast('Student record updated successfully!', 'success');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "StudentUpdateToast", script, true);
                }
                else
                {
                    lblStatusMessage.Text = "Failed to update student details. Check for duplicate email address.";
                    lblStatusMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void gvStudents_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int studentID = Convert.ToInt32(gvStudents.DataKeys[e.RowIndex].Value);
            bool success = _studentBLL.DeleteStudent(studentID);

            if (success)
            {
                LoadStudents();
                string script = "showToast('Student record deleted permanently!', 'warning');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "StudentDeleteToast", script, true);
            }
            else
            {
                lblStatusMessage.Text = "Failed to delete student record. Please try again.";
                lblStatusMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected string GetStatusBadgeClass(string status)
        {
            if (status.Equals("Approved", StringComparison.OrdinalIgnoreCase))
                return "badge-approved";
            if (status.Equals("Suspended", StringComparison.OrdinalIgnoreCase))
                return "badge-suspended";
            return "badge-pending";
        }
    }
}
