using System;
using System.Data;
using System.Data.SqlClient;

namespace HostelManagementSystem.DAL
{
    public class PaymentDAL
    {
        public bool RecordPayment(int studentID, decimal amount, string paymentMethod, string transactionID)
        {
            string query = @"INSERT INTO Payments (StudentID, Amount, PaymentDate, PaymentMethod, TransactionID, Status) 
                             VALUES (@StudentID, @Amount, GETDATE(), @PaymentMethod, @TransactionID, 'Paid')";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentID),
                new SqlParameter("@Amount", amount),
                new SqlParameter("@PaymentMethod", paymentMethod),
                new SqlParameter("@TransactionID", transactionID)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        public DataTable GetAllPayments()
        {
            string query = @"SELECT p.*, s.FullName, s.Email 
                             FROM Payments p
                             INNER JOIN Students s ON p.StudentID = s.StudentID
                             ORDER BY p.PaymentDate DESC";
            return DBHelper.ExecuteSelect(query);
        }

        public DataTable GetPaymentsByStudent(int studentID)
        {
            string query = @"SELECT * FROM Payments 
                             WHERE StudentID = @StudentID 
                             ORDER BY PaymentDate DESC";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentID)
            };
            return DBHelper.ExecuteSelect(query, parameters);
        }

        public decimal GetTotalRevenue()
        {
            string query = "SELECT COALESCE(SUM(Amount), 0) FROM Payments WHERE Status = 'Paid'";
            object res = DBHelper.ExecuteScalar(query);
            return res != null ? Convert.ToDecimal(res) : 0;
        }

        public bool IsTransactionIDExists(string transactionID)
        {
            string query = "SELECT COUNT(*) FROM Payments WHERE TransactionID = @TransactionID";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@TransactionID", transactionID)
            };
            object count = DBHelper.ExecuteScalar(query, parameters);
            return count != null && Convert.ToInt32(count) > 0;
        }

        public bool UpdatePaymentStatus(int paymentID, string status)
        {
            string query = "UPDATE Payments SET Status = @Status WHERE PaymentID = @PaymentID";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@PaymentID", paymentID),
                new SqlParameter("@Status", status)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }
    }
}
