using System;
using System.Data;
using System.Data.SqlClient;

namespace HostelManagementSystem.DAL
{
    public class AllocationDAL
    {
        public bool ApplyForRoom(int studentID, int roomID)
        {
            string query = "INSERT INTO RoomAllocations (StudentID, RoomID, AllocationDate, Status) VALUES (@StudentID, @RoomID, GETDATE(), 'Pending')";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentID),
                new SqlParameter("@RoomID", roomID)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        public DataTable GetAllAllocations()
        {
            string query = @"SELECT ra.*, s.FullName, s.Email, r.RoomNumber, r.RoomType, b.BlockName 
                             FROM RoomAllocations ra
                             INNER JOIN Students s ON ra.StudentID = s.StudentID
                             INNER JOIN Rooms r ON ra.RoomID = r.RoomID
                             INNER JOIN HostelBlocks b ON r.BlockID = b.BlockID
                             ORDER BY ra.AllocationDate DESC";
            return DBHelper.ExecuteSelect(query);
        }

        public DataTable GetAllocationsByStudent(int studentID)
        {
            string query = @"SELECT ra.*, r.RoomNumber, r.RoomType, r.MonthlyFee, b.BlockName, b.BlockID
                             FROM RoomAllocations ra
                             INNER JOIN Rooms r ON ra.RoomID = r.RoomID
                             INNER JOIN HostelBlocks b ON r.BlockID = b.BlockID
                             WHERE ra.StudentID = @StudentID
                             ORDER BY ra.AllocationDate DESC";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentID)
            };
            return DBHelper.ExecuteSelect(query, parameters);
        }

        public DataTable GetActiveAllocationByStudent(int studentID)
        {
            string query = @"SELECT ra.*, r.RoomNumber, r.RoomType, r.MonthlyFee, b.BlockName, r.FloorNumber, r.Capacity
                             FROM RoomAllocations ra
                             INNER JOIN Rooms r ON ra.RoomID = r.RoomID
                             INNER JOIN HostelBlocks b ON r.BlockID = b.BlockID
                             WHERE ra.StudentID = @StudentID AND ra.Status = 'Active'";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentID)
            };
            return DBHelper.ExecuteSelect(query, parameters);
        }

        public DataTable GetPendingAllocations()
        {
            string query = @"SELECT ra.*, s.FullName, s.Email, r.RoomNumber, r.RoomType, b.BlockName 
                             FROM RoomAllocations ra
                             INNER JOIN Students s ON ra.StudentID = s.StudentID
                             INNER JOIN Rooms r ON ra.RoomID = r.RoomID
                             INNER JOIN HostelBlocks b ON r.BlockID = b.BlockID
                             WHERE ra.Status = 'Pending'
                             ORDER BY ra.AllocationDate DESC";
            return DBHelper.ExecuteSelect(query);
        }

        public bool ApproveAllocation(int allocationID, int roomID)
        {
            // Set status to Active, set CheckInDate to today, increment room occupancy
            using (SqlConnection conn = DBHelper.GetConnection())
            {
                SqlTransaction trans = conn.BeginTransaction();
                try
                {
                    // 1. Update Allocation
                    string updateAlloc = "UPDATE RoomAllocations SET Status = 'Active', CheckInDate = CAST(GETDATE() AS DATE) WHERE AllocationID = @AllocationID";
                    using (SqlCommand cmd = new SqlCommand(updateAlloc, conn, trans))
                    {
                        cmd.Parameters.AddWithValue("@AllocationID", allocationID);
                        cmd.ExecuteNonQuery();
                    }

                    // 2. Increment Room OccupiedBeds
                    string incRoom = @"UPDATE Rooms 
                                       SET OccupiedBeds = OccupiedBeds + 1,
                                           Status = CASE WHEN OccupiedBeds + 1 >= Capacity THEN 'Full' ELSE Status END 
                                       WHERE RoomID = @RoomID AND OccupiedBeds < Capacity";
                    using (SqlCommand cmd = new SqlCommand(incRoom, conn, trans))
                    {
                        cmd.Parameters.AddWithValue("@RoomID", roomID);
                        int affected = cmd.ExecuteNonQuery();
                        if (affected == 0)
                        {
                            throw new Exception("Room is already full or does not exist.");
                        }
                    }

                    // 3. Update Student Status
                    string updateStud = "UPDATE Students SET Status = 'Approved' WHERE StudentID = (SELECT StudentID FROM RoomAllocations WHERE AllocationID = @AllocationID)";
                    using (SqlCommand cmd = new SqlCommand(updateStud, conn, trans))
                    {
                        cmd.Parameters.AddWithValue("@AllocationID", allocationID);
                        cmd.ExecuteNonQuery();
                    }

                    trans.Commit();
                    return true;
                }
                catch (Exception)
                {
                    trans.Rollback();
                    return false;
                }
            }
        }

        public bool CheckOutAllocation(int allocationID, int roomID, int studentID)
        {
            // Set status to CheckedOut, decrement room occupancy
            using (SqlConnection conn = DBHelper.GetConnection())
            {
                SqlTransaction trans = conn.BeginTransaction();
                try
                {
                    // 1. Update Allocation
                    string updateAlloc = "UPDATE RoomAllocations SET Status = 'CheckedOut' WHERE AllocationID = @AllocationID";
                    using (SqlCommand cmd = new SqlCommand(updateAlloc, conn, trans))
                    {
                        cmd.Parameters.AddWithValue("@AllocationID", allocationID);
                        cmd.ExecuteNonQuery();
                    }

                    // 2. Decrement Room OccupiedBeds
                    string decRoom = @"UPDATE Rooms 
                                       SET OccupiedBeds = CASE WHEN OccupiedBeds > 0 THEN OccupiedBeds - 1 ELSE 0 END,
                                           Status = CASE WHEN OccupiedBeds - 1 < Capacity THEN 'Available' ELSE Status END 
                                       WHERE RoomID = @RoomID";
                    using (SqlCommand cmd = new SqlCommand(decRoom, conn, trans))
                    {
                        cmd.Parameters.AddWithValue("@RoomID", roomID);
                        cmd.ExecuteNonQuery();
                    }

                    // 3. Reset Student Status if no other active allocation
                    string resetStud = "UPDATE Students SET Status = 'Pending' WHERE StudentID = @StudentID";
                    using (SqlCommand cmd = new SqlCommand(resetStud, conn, trans))
                    {
                        cmd.Parameters.AddWithValue("@StudentID", studentID);
                        cmd.ExecuteNonQuery();
                    }

                    trans.Commit();
                    return true;
                }
                catch (Exception)
                {
                    trans.Rollback();
                    return false;
                }
            }
        }

        public bool RejectAllocation(int allocationID)
        {
            string query = "UPDATE RoomAllocations SET Status = 'Cancelled' WHERE AllocationID = @AllocationID";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@AllocationID", allocationID)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }
    }
}
