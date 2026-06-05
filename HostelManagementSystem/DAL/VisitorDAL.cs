using System;
using System.Data;
using System.Data.SqlClient;

namespace HostelManagementSystem.DAL
{
    public class VisitorDAL
    {
        public bool LogVisitorEntry(int studentID, string visitorName, string relationship, DateTime visitDate, TimeSpan checkInTime)
        {
            string query = @"INSERT INTO Visitors (StudentID, VisitorName, Relationship, VisitDate, CheckInTime, CheckOutTime) 
                             VALUES (@StudentID, @VisitorName, @Relationship, @VisitDate, @CheckInTime, NULL)";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentID),
                new SqlParameter("@VisitorName", visitorName),
                new SqlParameter("@Relationship", relationship),
                new SqlParameter("@VisitDate", visitDate.Date),
                new SqlParameter("@CheckInTime", checkInTime)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        public bool LogVisitorExit(int visitorID, TimeSpan checkOutTime)
        {
            string query = "UPDATE Visitors SET CheckOutTime = @CheckOutTime WHERE VisitorID = @VisitorID";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@VisitorID", visitorID),
                new SqlParameter("@CheckOutTime", checkOutTime)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        public DataTable GetActiveVisitors()
        {
            string query = @"SELECT v.*, s.FullName, s.Email, r.RoomNumber
                             FROM Visitors v
                             INNER JOIN Students s ON v.StudentID = s.StudentID
                             LEFT JOIN RoomAllocations ra ON s.StudentID = ra.StudentID AND ra.Status = 'Active'
                             LEFT JOIN Rooms r ON ra.RoomID = r.RoomID
                             WHERE v.CheckOutTime IS NULL
                             ORDER BY v.VisitDate DESC, v.CheckInTime DESC";
            return DBHelper.ExecuteSelect(query);
        }

        public DataTable GetAllVisitorLogs()
        {
            string query = @"SELECT v.*, s.FullName, s.Email, r.RoomNumber
                             FROM Visitors v
                             INNER JOIN Students s ON v.StudentID = s.StudentID
                             LEFT JOIN RoomAllocations ra ON s.StudentID = ra.StudentID AND ra.Status = 'Active'
                             LEFT JOIN Rooms r ON ra.RoomID = r.RoomID
                             ORDER BY v.VisitDate DESC, v.CheckInTime DESC";
            return DBHelper.ExecuteSelect(query);
        }

        public DataTable GetVisitorLogsByStudent(int studentID)
        {
            string query = "SELECT * FROM Visitors WHERE StudentID = @StudentID ORDER BY VisitDate DESC, CheckInTime DESC";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentID)
            };
            return DBHelper.ExecuteSelect(query, parameters);
        }
    }
}
