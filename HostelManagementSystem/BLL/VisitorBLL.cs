using System;
using System.Data;
using HostelManagementSystem.DAL;

namespace HostelManagementSystem.BLL
{
    public class VisitorBLL
    {
        private readonly VisitorDAL _visitorDAL = new VisitorDAL();

        public bool LogVisitorEntry(int studentID, string visitorName, string relationship, DateTime visitDate, TimeSpan checkInTime, out string errorMessage)
        {
            errorMessage = string.Empty;
            if (string.IsNullOrEmpty(visitorName) || string.IsNullOrEmpty(relationship))
            {
                errorMessage = "Visitor name and relationship are required fields.";
                return false;
            }
            if (studentID <= 0)
            {
                errorMessage = "Invalid student allocation.";
                return false;
            }
            return _visitorDAL.LogVisitorEntry(studentID, visitorName, relationship, visitDate, checkInTime);
        }

        public bool LogVisitorExit(int visitorID, TimeSpan checkOutTime, out string errorMessage)
        {
            errorMessage = string.Empty;
            if (visitorID <= 0)
            {
                errorMessage = "Invalid visitor ID.";
                return false;
            }
            return _visitorDAL.LogVisitorExit(visitorID, checkOutTime);
        }

        public DataTable GetActiveVisitors()
        {
            return _visitorDAL.GetActiveVisitors();
        }

        public DataTable GetAllVisitorLogs()
        {
            return _visitorDAL.GetAllVisitorLogs();
        }

        public DataTable GetVisitorLogsByStudent(int studentID)
        {
            return _visitorDAL.GetVisitorLogsByStudent(studentID);
        }
    }
}
