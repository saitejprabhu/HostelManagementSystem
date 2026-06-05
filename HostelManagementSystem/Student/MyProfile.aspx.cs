using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using HostelManagementSystem.BLL;

namespace HostelManagementSystem.Student
{
    public partial class MyProfile : System.Web.UI.Page
    {
        private readonly StudentBLL _studentBLL = new StudentBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["StudentID"] == null)
            {
                Response.Redirect("~/Pages/StudentLogin");
                return;
            }

            if (!IsPostBack)
            {
                lblProfileMessage.Text = string.Empty;
                LoadStudentProfile();
            }
        }

        private void LoadStudentProfile()
        {
            int studentID = Convert.ToInt32(Session["StudentID"]);
            DataTable dt = _studentBLL.GetStudentByID(studentID);
            if (dt.Rows.Count > 0)
            {
                DataRow student = dt.Rows[0];
                txtProfileName.Text = student["FullName"].ToString();
                txtProfileEmail.Text = student["Email"].ToString();
                txtProfileMobile.Text = student["Mobile"].ToString();
                txtProfileAddress.Text = student["Address"].ToString();
                txtProfileCourse.Text = student["Course"].ToString();
                txtProfileYear.Text = student["Year"].ToString();

                // Format DOB to yyyy-MM-dd for HTML5 Date Input
                if (student["DOB"] != DBNull.Value)
                {
                    DateTime dob = Convert.ToDateTime(student["DOB"]);
                    txtProfileDOB.Text = dob.ToString("yyyy-MM-dd");
                }

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
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int studentID = Convert.ToInt32(Session["StudentID"]);
                string fullName = txtProfileName.Text.Trim();
                DateTime dob = DateTime.Parse(txtProfileDOB.Text);
                string mobile = txtProfileMobile.Text.Trim();
                string address = txtProfileAddress.Text.Trim();
                string course = txtProfileCourse.Text.Trim();
                int year = Convert.ToInt32(txtProfileYear.Text);

                string profilePictureName = null;

                // Handle file upload
                if (fuProfilePicture.HasFile)
                {
                    string extension = Path.GetExtension(fuProfilePicture.FileName).ToLower();
                    string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
                    bool isAllowed = false;
                    foreach (string ext in allowedExtensions)
                    {
                        if (ext == extension)
                        {
                            isAllowed = true;
                            break;
                        }
                    }

                    if (isAllowed)
                    {
                        // Ensure directory exists
                        string folderPath = Server.MapPath("~/Documents/ProfilePictures/");
                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath);
                        }

                        // Generate unique file name
                        profilePictureName = "student_" + studentID + "_" + DateTime.Now.Ticks + extension;
                        string fullPath = Path.Combine(folderPath, profilePictureName);
                        fuProfilePicture.SaveAs(fullPath);
                    }
                    else
                    {
                        lblProfileMessage.Text = "Invalid image file format. Only JPG, PNG, and GIF are allowed.";
                        lblProfileMessage.ForeColor = System.Drawing.Color.Red;
                        return;
                    }
                }

                string errorMessage;
                bool isSuccess = _studentBLL.UpdateStudentProfile(
                    studentID, fullName, dob, mobile, address, course, year, profilePictureName, out errorMessage
                );

                if (isSuccess)
                {
                    // Reload profile details
                    LoadStudentProfile();
                    
                    // Show success toast
                    string script = "showToast('Profile details updated successfully!', 'success');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ProfileUpdateToast", script, true);
                }
                else
                {
                    lblProfileMessage.Text = errorMessage;
                    lblProfileMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int studentID = Convert.ToInt32(Session["StudentID"]);
                string currentPassword = txtCurrentPassword.Text;
                string newPassword = txtNewPassword.Text;

                string errorMessage;
                bool isSuccess = _studentBLL.ChangePassword(studentID, currentPassword, newPassword, out errorMessage);

                if (isSuccess)
                {
                    // Clear inputs
                    txtCurrentPassword.Text = string.Empty;
                    txtNewPassword.Text = string.Empty;
                    txtConfirmNewPassword.Text = string.Empty;

                    // Show success toast
                    string script = "showToast('Password changed successfully!', 'success');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "PasswordChangeToast", script, true);
                }
                else
                {
                    lblProfileMessage.Text = errorMessage;
                    lblProfileMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}
