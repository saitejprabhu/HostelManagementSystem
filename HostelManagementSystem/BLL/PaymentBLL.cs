using System;
using System.Data;
using HostelManagementSystem.DAL;

namespace HostelManagementSystem.BLL
{
    public class PaymentBLL
    {
        private readonly PaymentDAL _paymentDAL = new PaymentDAL();

        public bool RecordPayment(int studentID, decimal amount, string paymentMethod, string transactionID, out string errorMessage)
        {
            errorMessage = string.Empty;

            if (amount <= 0)
            {
                errorMessage = "Payment amount must be greater than zero.";
                return false;
            }

            if (string.IsNullOrEmpty(paymentMethod) || string.IsNullOrEmpty(transactionID))
            {
                errorMessage = "Payment method and transaction ID are required.";
                return false;
            }

            // Check if Transaction ID already exists
            if (_paymentDAL.IsTransactionIDExists(transactionID))
            {
                errorMessage = "This transaction ID has already been submitted. Please check the ID and try again.";
                return false;
            }

            return _paymentDAL.RecordPayment(studentID, amount, paymentMethod, transactionID);
        }

        public DataTable GetAllPayments()
        {
            return _paymentDAL.GetAllPayments();
        }

        public DataTable GetPaymentsByStudent(int studentID)
        {
            return _paymentDAL.GetPaymentsByStudent(studentID);
        }

        public decimal GetTotalRevenue()
        {
            return _paymentDAL.GetTotalRevenue();
        }

        public bool UpdatePaymentStatus(int paymentID, string status)
        {
            return _paymentDAL.UpdatePaymentStatus(paymentID, status);
        }
    }
}
