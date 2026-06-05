using System;
using System.Data;
using HostelManagementSystem.DAL;

namespace HostelManagementSystem.BLL
{
    public class RoomBLL
    {
        private readonly RoomDAL _roomDAL = new RoomDAL();

        // === Block Business Methods ===
        public DataTable GetAllBlocks()
        {
            return _roomDAL.GetAllBlocks();
        }

        public bool AddBlock(string blockName, string description, out string errorMessage)
        {
            errorMessage = string.Empty;
            if (string.IsNullOrEmpty(blockName))
            {
                errorMessage = "Block name cannot be empty.";
                return false;
            }
            return _roomDAL.AddBlock(blockName, description);
        }

        public bool UpdateBlock(int blockID, string blockName, string description, out string errorMessage)
        {
            errorMessage = string.Empty;
            if (string.IsNullOrEmpty(blockName))
            {
                errorMessage = "Block name cannot be empty.";
                return false;
            }
            return _roomDAL.UpdateBlock(blockID, blockName, description);
        }

        public bool DeleteBlock(int blockID)
        {
            return _roomDAL.DeleteBlock(blockID);
        }

        // === Room Business Methods ===
        public DataTable GetAllRooms()
        {
            return _roomDAL.GetAllRooms();
        }

        public DataTable GetRoomByID(int roomID)
        {
            return _roomDAL.GetRoomByID(roomID);
        }

        public DataTable GetRoomsByBlock(int blockID)
        {
            return _roomDAL.GetRoomsByBlock(blockID);
        }

        public bool AddRoom(string roomNumber, string roomType, int capacity, int floorNumber, decimal monthlyFee, int blockID, out string errorMessage)
        {
            errorMessage = string.Empty;
            if (string.IsNullOrEmpty(roomNumber) || string.IsNullOrEmpty(roomType))
            {
                errorMessage = "Room number and room type are required fields.";
                return false;
            }
            if (capacity <= 0 || floorNumber < 0 || monthlyFee < 0)
            {
                errorMessage = "Capacity, floor, and monthly fee must be non-negative positive values.";
                return false;
            }
            return _roomDAL.AddRoom(roomNumber, roomType, capacity, floorNumber, monthlyFee, blockID);
        }

        public bool UpdateRoom(int roomID, string roomNumber, string roomType, int capacity, int floorNumber, decimal monthlyFee, string status, out string errorMessage)
        {
            errorMessage = string.Empty;
            if (string.IsNullOrEmpty(roomNumber) || string.IsNullOrEmpty(roomType))
            {
                errorMessage = "Room number and room type are required fields.";
                return false;
            }
            if (capacity <= 0 || floorNumber < 0 || monthlyFee < 0)
            {
                errorMessage = "Capacity, floor, and monthly fee must be non-negative positive values.";
                return false;
            }
            return _roomDAL.UpdateRoom(roomID, roomNumber, roomType, capacity, floorNumber, monthlyFee, status);
        }

        public bool DeleteRoom(int roomID, int blockID)
        {
            return _roomDAL.DeleteRoom(roomID, blockID);
        }

        public DataTable GetAvailableRooms()
        {
            return _roomDAL.GetAvailableRooms();
        }

        public DataTable SearchRooms(int blockID, string roomType, decimal maxFee)
        {
            return _roomDAL.SearchRooms(blockID, roomType, maxFee);
        }
    }
}
