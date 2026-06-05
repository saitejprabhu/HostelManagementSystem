using System;
using System.Data;
using System.Data.SqlClient;

namespace HostelManagementSystem.DAL
{
    public class ComplaintDAL
    {
        public bool RaiseComplaint(int studentID, string subject, string description)
        {
            string query = @"INSERT INTO Complaints (StudentID, Subject, Description, ComplaintDate, Status) 
                             VALUES (@StudentID, @Subject, @Description, GETDATE(), 'Pending')";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentID),
                new SqlParameter("@Subject", subject),
                new SqlParameter("@Description", description)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        public DataTable GetComplaintsByStudent(int studentID)
        {
            string query = "SELECT * FROM Complaints WHERE StudentID = @StudentID ORDER BY ComplaintDate DESC";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentID)
            };
            return DBHelper.ExecuteSelect(query, parameters);
        }

        public DataTable GetAllComplaints()
        {
            string query = @"SELECT c.*, s.FullName, s.Email 
                             FROM Complaints c
                             INNER JOIN Students s ON c.StudentID = s.StudentID
                             ORDER BY c.ComplaintDate DESC";
            return DBHelper.ExecuteSelect(query);
        }

        public int GetPendingComplaintsCount()
        {
            string query = "SELECT COUNT(*) FROM Complaints WHERE Status = 'Pending'";
            object res = DBHelper.ExecuteScalar(query);
            return res != null ? Convert.ToInt32(res) : 0;
        }

        public bool RespondToComplaint(int complaintID, string response, string status)
        {
            string query = "UPDATE Complaints SET Response = @Response, Status = @Status WHERE ComplaintID = @ComplaintID";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@ComplaintID", complaintID),
                new SqlParameter("@Response", response),
                new SqlParameter("@Status", status)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }
    }
}
