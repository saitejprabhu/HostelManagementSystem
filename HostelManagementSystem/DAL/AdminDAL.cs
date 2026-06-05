using System;
using System.Data;
using System.Data.SqlClient;

namespace HostelManagementSystem.DAL
{
    public class AdminDAL
    {
        public DataTable ValidateAdmin(string username, string hashedPassword)
        {
            string query = "SELECT * FROM Admins WHERE Username = @Username AND Password = @Password";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Username", username),
                new SqlParameter("@Password", hashedPassword)
            };
            return DBHelper.ExecuteSelect(query, parameters);
        }

        public DataTable GetAdminByUsername(string username)
        {
            string query = "SELECT * FROM Admins WHERE Username = @Username";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Username", username)
            };
            return DBHelper.ExecuteSelect(query, parameters);
        }

        public DataTable GetDashboardStats()
        {
            // Fetch multiple statistics in a single dataset
            string query = @"
                SELECT 
                    (SELECT COUNT(*) FROM Students) AS TotalStudents,
                    (SELECT COUNT(*) FROM Rooms) AS TotalRooms,
                    (SELECT COALESCE(SUM(OccupiedBeds), 0) FROM Rooms) AS TotalOccupiedBeds,
                    (SELECT COALESCE(SUM(Capacity), 0) FROM Rooms) AS TotalCapacity,
                    (SELECT COALESCE(SUM(Amount), 0) FROM Payments WHERE Status = 'Paid') AS TotalRevenue,
                    (SELECT COUNT(*) FROM Complaints WHERE Status = 'Pending') AS PendingComplaints
            ";
            return DBHelper.ExecuteSelect(query);
        }
    }
}
