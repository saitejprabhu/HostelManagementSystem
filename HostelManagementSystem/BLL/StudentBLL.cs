using System;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using HostelManagementSystem.DAL;

namespace HostelManagementSystem.BLL
{
    public class StudentBLL
    {
        private readonly StudentDAL _studentDAL = new StudentDAL();

        public static string HashPassword(string password)
        {
            if (string.IsNullOrEmpty(password)) return string.Empty;
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        public bool RegisterStudent(string fullName, string gender, DateTime dob, string email, string mobile, string address, string course, int year, string password, out string errorMessage)
        {
            errorMessage = string.Empty;

            // Basic Validation
            if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                errorMessage = "Name, Email, and Password are required fields.";
                return false;
            }

            // Check Duplicate Email
            DataTable dt = _studentDAL.GetStudentByEmail(email);
            if (dt.Rows.Count > 0)
            {
                errorMessage = "A student with this email address is already registered.";
                return false;
            }

            // Hash password and register
            string hashedPassword = HashPassword(password);
            bool result = _studentDAL.RegisterStudent(fullName, gender, dob, email, mobile, address, course, year, hashedPassword);
            if (!result)
            {
                errorMessage = "Database registration failed. Please try again.";
            }
            return result;
        }

        public DataTable LoginStudent(string email, string password, out string errorMessage)
        {
            errorMessage = string.Empty;
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                errorMessage = "Email and Password are required.";
                return null;
            }

            DataTable dt = _studentDAL.GetStudentByEmail(email);
            if (dt.Rows.Count == 0)
            {
                errorMessage = "Invalid email or password.";
                return null;
            }

            DataRow row = dt.Rows[0];
            string storedHash = row["Password"].ToString();
            string status = row["Status"].ToString();

            if (status.Equals("Suspended", StringComparison.OrdinalIgnoreCase))
            {
                errorMessage = "Your account has been suspended. Please contact the warden.";
                return null;
            }

            if (storedHash == HashPassword(password))
            {
                return dt;
            }
            else
            {
                errorMessage = "Invalid email or password.";
                return null;
            }
        }

        public DataTable GetStudentByID(int studentID)
        {
            return _studentDAL.GetStudentByID(studentID);
        }

        public bool UpdateStudentProfile(int studentID, string fullName, DateTime dob, string mobile, string address, string course, int year, string profilePicture, out string errorMessage)
        {
            errorMessage = string.Empty;
            if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(mobile))
            {
                errorMessage = "Name and Mobile number are required.";
                return false;
            }
            return _studentDAL.UpdateStudentProfile(studentID, fullName, dob, mobile, address, course, year, profilePicture);
        }

        public bool ChangePassword(int studentID, string currentPassword, string newPassword, out string errorMessage)
        {
            errorMessage = string.Empty;
            if (string.IsNullOrEmpty(currentPassword) || string.IsNullOrEmpty(newPassword))
            {
                errorMessage = "Both current and new passwords are required.";
                return false;
            }

            DataTable dt = _studentDAL.GetStudentByID(studentID);
            if (dt.Rows.Count == 0)
            {
                errorMessage = "Student account not found.";
                return false;
            }

            string storedHash = dt.Rows[0]["Password"].ToString();
            if (storedHash != HashPassword(currentPassword))
            {
                errorMessage = "Current password does not match.";
                return false;
            }

            return _studentDAL.ChangeStudentPassword(studentID, HashPassword(newPassword));
        }

        public DataTable GetAllStudents()
        {
            return _studentDAL.GetAllStudents();
        }

        public bool UpdateStudentDetailsByAdmin(int studentID, string fullName, string email, string mobile, string address, string course, int year, string status)
        {
            return _studentDAL.UpdateStudentDetailsByAdmin(studentID, fullName, email, mobile, address, course, year, status);
        }

        public bool UpdateStudentStatus(int studentID, string status)
        {
            return _studentDAL.UpdateStudentStatus(studentID, status);
        }

        public bool DeleteStudent(int studentID)
        {
            return _studentDAL.DeleteStudent(studentID);
        }
    }
}
