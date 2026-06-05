using System;
using System.Data;
using System.Data.SqlClient;

namespace HostelManagementSystem.DAL
{
    public class RoomDAL
    {
        // === Block Methods ===
        public DataTable GetAllBlocks()
        {
            string query = "SELECT * FROM HostelBlocks ORDER BY BlockName ASC";
            return DBHelper.ExecuteSelect(query);
        }

        public bool AddBlock(string blockName, string description)
        {
            string query = "INSERT INTO HostelBlocks (BlockName, Description, TotalRooms) VALUES (@BlockName, @Description, 0)";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@BlockName", blockName),
                new SqlParameter("@Description", string.IsNullOrEmpty(description) ? (object)DBNull.Value : description)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        public bool UpdateBlock(int blockID, string blockName, string description)
        {
            string query = "UPDATE HostelBlocks SET BlockName = @BlockName, Description = @Description WHERE BlockID = @BlockID";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@BlockID", blockID),
                new SqlParameter("@BlockName", blockName),
                new SqlParameter("@Description", string.IsNullOrEmpty(description) ? (object)DBNull.Value : description)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        public bool DeleteBlock(int blockID)
        {
            string query = "DELETE FROM HostelBlocks WHERE BlockID = @BlockID";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@BlockID", blockID)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        // === Room Methods ===
        public DataTable GetAllRooms()
        {
            string query = @"SELECT r.*, b.BlockName 
                             FROM Rooms r 
                             INNER JOIN HostelBlocks b ON r.BlockID = b.BlockID 
                             ORDER BY b.BlockName, r.RoomNumber";
            return DBHelper.ExecuteSelect(query);
        }

        public DataTable GetRoomByID(int roomID)
        {
            string query = @"SELECT r.*, b.BlockName 
                             FROM Rooms r 
                             INNER JOIN HostelBlocks b ON r.BlockID = b.BlockID 
                             WHERE r.RoomID = @RoomID";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@RoomID", roomID)
            };
            return DBHelper.ExecuteSelect(query, parameters);
        }

        public DataTable GetRoomsByBlock(int blockID)
        {
            string query = "SELECT * FROM Rooms WHERE BlockID = @BlockID ORDER BY RoomNumber";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@BlockID", blockID)
            };
            return DBHelper.ExecuteSelect(query, parameters);
        }

        public bool AddRoom(string roomNumber, string roomType, int capacity, int floorNumber, decimal monthlyFee, int blockID)
        {
            string query = @"INSERT INTO Rooms (RoomNumber, RoomType, Capacity, OccupiedBeds, FloorNumber, MonthlyFee, Status, BlockID) 
                             VALUES (@RoomNumber, @RoomType, @Capacity, 0, @FloorNumber, @MonthlyFee, 'Available', @BlockID);
                             UPDATE HostelBlocks SET TotalRooms = TotalRooms + 1 WHERE BlockID = @BlockID;";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@RoomNumber", roomNumber),
                new SqlParameter("@RoomType", roomType),
                new SqlParameter("@Capacity", capacity),
                new SqlParameter("@FloorNumber", floorNumber),
                new SqlParameter("@MonthlyFee", monthlyFee),
                new SqlParameter("@BlockID", blockID)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        public bool UpdateRoom(int roomID, string roomNumber, string roomType, int capacity, int floorNumber, decimal monthlyFee, string status)
        {
            string query = @"UPDATE Rooms 
                             SET RoomNumber = @RoomNumber, RoomType = @RoomType, Capacity = @Capacity, 
                                 FloorNumber = @FloorNumber, MonthlyFee = @MonthlyFee, Status = @Status 
                             WHERE RoomID = @RoomID";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@RoomID", roomID),
                new SqlParameter("@RoomNumber", roomNumber),
                new SqlParameter("@RoomType", roomType),
                new SqlParameter("@Capacity", capacity),
                new SqlParameter("@FloorNumber", floorNumber),
                new SqlParameter("@MonthlyFee", monthlyFee),
                new SqlParameter("@Status", status)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        public bool DeleteRoom(int roomID, int blockID)
        {
            string query = @"DELETE FROM Rooms WHERE RoomID = @RoomID;
                             UPDATE HostelBlocks SET TotalRooms = CASE WHEN TotalRooms > 0 THEN TotalRooms - 1 ELSE 0 END WHERE BlockID = @BlockID;";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@RoomID", roomID),
                new SqlParameter("@BlockID", blockID)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        public DataTable GetAvailableRooms()
        {
            string query = @"SELECT r.*, b.BlockName 
                             FROM Rooms r 
                             INNER JOIN HostelBlocks b ON r.BlockID = b.BlockID 
                             WHERE r.Status = 'Available' AND r.OccupiedBeds < r.Capacity 
                             ORDER BY b.BlockName, r.RoomNumber";
            return DBHelper.ExecuteSelect(query);
        }

        public DataTable SearchRooms(int blockID, string roomType, decimal maxFee)
        {
            string query = @"SELECT r.*, b.BlockName 
                             FROM Rooms r 
                             INNER JOIN HostelBlocks b ON r.BlockID = b.BlockID 
                             WHERE (@BlockID = 0 OR r.BlockID = @BlockID)
                               AND (@RoomType = '' OR r.RoomType = @RoomType)
                               AND (@MaxFee = 0.00 OR r.MonthlyFee <= @MaxFee)
                             ORDER BY b.BlockName, r.RoomNumber";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@BlockID", blockID),
                new SqlParameter("@RoomType", roomType),
                new SqlParameter("@MaxFee", maxFee)
            };
            return DBHelper.ExecuteSelect(query, parameters);
        }

        public bool IncrementOccupancy(int roomID)
        {
            string query = @"UPDATE Rooms 
                             SET OccupiedBeds = OccupiedBeds + 1,
                                 Status = CASE WHEN OccupiedBeds + 1 >= Capacity THEN 'Full' ELSE Status END 
                             WHERE RoomID = @RoomID AND OccupiedBeds < Capacity";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@RoomID", roomID)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }

        public bool DecrementOccupancy(int roomID)
        {
            string query = @"UPDATE Rooms 
                             SET OccupiedBeds = CASE WHEN OccupiedBeds > 0 THEN OccupiedBeds - 1 ELSE 0 END,
                                 Status = CASE WHEN OccupiedBeds - 1 < Capacity THEN 'Available' ELSE Status END 
                             WHERE RoomID = @RoomID";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@RoomID", roomID)
            };
            return DBHelper.ExecuteNonQuery(query, parameters) > 0;
        }
    }
}
