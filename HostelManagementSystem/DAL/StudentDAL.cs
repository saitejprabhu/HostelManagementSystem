using System;
using System.Data;
using System.Data.SqlClient;

namespace HostelManagementSystem.DAL
{
    public class StudentDAL
    {
        public bool RegisterStudent(string fullName, string gender, DateTime dob, string email, string mobile, string address, string course, int year, string hashedPassword)
        {
            string query = @"INSERT INTO Students (FullName, Gender, DOB, Email, Mobile, Address, Course, Year, Password, Status) 
                             VALUES (@FullName, @Gender, @DOB, @Email, @Mobile, @Address, @Course, @Year, @Password, 'Pending')";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@FullName", fullName),
                new SqlParameter("@Gender", gender),
                new SqlParameter("@DOB", dob),
                new SqlParameter("@Email", email),
                new SqlParameter("@Mobile", mobile),
                new SqlParameter("@Address", address),
                new SqlParameter("@Course", course),
                new SqlParameter("@Year", year),
                new SqlParameter("@Password", hashedPassword)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        public DataTable GetStudentByEmail(string email)
        {
            string query = "SELECT * FROM Students WHERE Email = @Email";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Email", email)
            };
            return DBHelper.ExecuteSelect(query, parameters);
        }

        public DataTable GetStudentByID(int studentID)
        {
            string query = "SELECT * FROM Students WHERE StudentID = @StudentID";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentID)
            };
            return DBHelper.ExecuteSelect(query, parameters);
        }

        public bool UpdateStudentProfile(int studentID, string fullName, DateTime dob, string mobile, string address, string course, int year, string profilePicture)
        {
            string query = @"UPDATE Students 
                             SET FullName = @FullName, DOB = @DOB, Mobile = @Mobile, Address = @Address, 
                                 Course = @Course, Year = @Year, ProfilePicture = COALESCE(@ProfilePicture, ProfilePicture)
                             WHERE StudentID = @StudentID";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentID),
                new SqlParameter("@FullName", fullName),
                new SqlParameter("@DOB", dob),
                new SqlParameter("@Mobile", mobile),
                new SqlParameter("@Address", address),
                new SqlParameter("@Course", course),
                new SqlParameter("@Year", year),
                new SqlParameter("@ProfilePicture", string.IsNullOrEmpty(profilePicture) ? (object)DBNull.Value : profilePicture)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        public bool ChangeStudentPassword(int studentID, string hashedNewPassword)
        {
            string query = "UPDATE Students SET Password = @Password WHERE StudentID = @StudentID";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentID),
                new SqlParameter("@Password", hashedNewPassword)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        public DataTable GetAllStudents()
        {
            string query = "SELECT * FROM Students ORDER BY RegistrationDate DESC";
            return DBHelper.ExecuteSelect(query);
        }

        public bool UpdateStudentStatus(int studentID, string status)
        {
            string query = "UPDATE Students SET Status = @Status WHERE StudentID = @StudentID";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentID),
                new SqlParameter("@Status", status)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        public bool UpdateStudentDetailsByAdmin(int studentID, string fullName, string email, string mobile, string address, string course, int year, string status)
        {
            string query = @"UPDATE Students 
                             SET FullName = @FullName, Email = @Email, Mobile = @Mobile, Address = @Address, 
                                 Course = @Course, Year = @Year, Status = @Status
                             WHERE StudentID = @StudentID";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentID),
                new SqlParameter("@FullName", fullName),
                new SqlParameter("@Email", email),
                new SqlParameter("@Mobile", mobile),
                new SqlParameter("@Address", address),
                new SqlParameter("@Course", course),
                new SqlParameter("@Year", year),
                new SqlParameter("@Status", status)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        public bool DeleteStudent(int studentID)
        {
            string query = "DELETE FROM Students WHERE StudentID = @StudentID";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentID)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }
    }
}
