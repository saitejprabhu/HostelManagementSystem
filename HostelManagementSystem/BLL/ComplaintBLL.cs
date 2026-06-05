using System;
using System.Data;
using HostelManagementSystem.DAL;

namespace HostelManagementSystem.BLL
{
    public class ComplaintBLL
    {
        private readonly ComplaintDAL _complaintDAL = new ComplaintDAL();

        public bool RaiseComplaint(int studentID, string subject, string description, out string errorMessage)
        {
            errorMessage = string.Empty;
            if (string.IsNullOrEmpty(subject) || string.IsNullOrEmpty(description))
            {
                errorMessage = "Complaint subject and description cannot be empty.";
                return false;
            }
            return _complaintDAL.RaiseComplaint(studentID, subject, description);
        }

        public DataTable GetComplaintsByStudent(int studentID)
        {
            return _complaintDAL.GetComplaintsByStudent(studentID);
        }

        public DataTable GetAllComplaints()
        {
            return _complaintDAL.GetAllComplaints();
        }

        public int GetPendingComplaintsCount()
        {
            return _complaintDAL.GetPendingComplaintsCount();
        }

        public bool RespondToComplaint(int complaintID, string response, string status, out string errorMessage)
        {
            errorMessage = string.Empty;
            if (string.IsNullOrEmpty(response))
            {
                errorMessage = "Response content cannot be empty.";
                return false;
            }
            if (string.IsNullOrEmpty(status))
            {
                errorMessage = "Status must be specified.";
                return false;
            }
            return _complaintDAL.RespondToComplaint(complaintID, response, status);
        }
    }
}
