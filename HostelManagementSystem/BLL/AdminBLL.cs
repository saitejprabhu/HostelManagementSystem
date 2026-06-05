using System;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using HostelManagementSystem.DAL;

namespace HostelManagementSystem.BLL
{
    public class AdminBLL
    {
        private readonly AdminDAL _adminDAL = new AdminDAL();

        private string HashPassword(string password)
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

        public DataTable LoginAdmin(string username, string password, out string errorMessage)
        {
            errorMessage = string.Empty;
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                errorMessage = "Username and Password are required.";
                return null;
            }

            string hashedPassword = HashPassword(password);
            DataTable dt = _adminDAL.ValidateAdmin(username, hashedPassword);
            if (dt.Rows.Count == 0)
            {
                errorMessage = "Invalid admin username or password.";
                return null;
            }
            return dt;
        }

        public DataTable GetDashboardStats()
        {
            return _adminDAL.GetDashboardStats();
        }
    }
}
