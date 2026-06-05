using System;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Pages
{
    public partial class StudentRegistration : System.Web.UI.Page
    {
        private readonly StudentBLL _studentBLL = new StudentBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblStatusMessage.Text = string.Empty;
            }
        }

        protected void btnRegisterSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string fullName = txtRegisterName.Text.Trim();
                string gender = ddlRegisterGender.SelectedValue;
                DateTime dob = DateTime.Parse(txtRegisterDOB.Text);
                string email = txtRegisterEmail.Text.Trim();
                string mobile = txtRegisterMobile.Text.Trim();
                string address = txtRegisterAddress.Text.Trim();
                string course = txtRegisterCourse.Text.Trim();
                int year = Convert.ToInt32(txtRegisterYear.Text);
                string password = txtRegisterPassword.Text;

                string errorMessage;
                bool isSuccess = _studentBLL.RegisterStudent(
                    fullName, gender, dob, email, mobile, address, course, year, password, out errorMessage
                );

                if (isSuccess)
                {
                    // Redirect to login with query string success flag
                    Response.Redirect("~/Pages/StudentLogin?reg=success");
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
