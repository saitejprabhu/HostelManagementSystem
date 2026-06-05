using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace HostelManagementSystem.DAL
{
    public static class DBHelper
    {
        private static string GetConnectionString()
        {
            var connStr = ConfigurationManager.ConnectionStrings["HostelConn"];
            if (connStr == null)
            {
                // Fallback connection string
                return @"Server=(localdb)\MSSQLLocalDB;Database=HostelManagementDB;Integrated Security=True;TrustServerCertificate=True;";
            }
            return connStr.ConnectionString;
        }

        public static SqlConnection GetConnection()
        {
            SqlConnection conn = new SqlConnection(GetConnectionString());
            try
            {
                conn.Open();
                return conn;
            }
            catch (Exception ex)
            {
                // Log connection string and full exception to Trace for debugging
                try
                {
                    System.Diagnostics.Trace.WriteLine($"DBHelper.GetConnection failed. ConnectionString='{conn.ConnectionString}'");
                    System.Diagnostics.Trace.WriteLine(ex.ToString());
                }
                catch { }

                // Ensure connection is cleaned up
                try { conn.Dispose(); } catch { }

                // Throw a clearer exception with the original exception attached
                throw new InvalidOperationException("Failed to open database connection. Check connection string and SQL Server availability.", ex);
            }
        }

        public static DataTable ExecuteSelect(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        public static int ExecuteNonQuery(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }
                    return cmd.ExecuteNonQuery();
                }
            }
        }

        public static object ExecuteScalar(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }
                    return cmd.ExecuteScalar();
                }
            }
        }
    }
}
