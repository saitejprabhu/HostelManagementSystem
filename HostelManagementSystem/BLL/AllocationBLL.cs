using System;
using System.Data;
using HostelManagementSystem.DAL;

namespace HostelManagementSystem.BLL
{
    public class AllocationBLL
    {
        private readonly AllocationDAL _allocationDAL = new AllocationDAL();
        private readonly RoomDAL _roomDAL = new RoomDAL();

        public bool ApplyForRoom(int studentID, int roomID, out string errorMessage)
        {
            errorMessage = string.Empty;

            // 1. Check if student already has a pending or active allocation
            DataTable dtHistory = _allocationDAL.GetAllocationsByStudent(studentID);
            foreach (DataRow row in dtHistory.Rows)
            {
                string status = row["Status"].ToString();
                if (status == "Pending" || status == "Active")
                {
                    errorMessage = "You already have an active or pending room allocation application.";
                    return false;
                }
            }

            // 2. Check if room is available
            DataTable dtRoom = _roomDAL.GetRoomByID(roomID);
            if (dtRoom.Rows.Count == 0)
            {
                errorMessage = "Selected room does not exist.";
                return false;
            }

            int capacity = Convert.ToInt32(dtRoom.Rows[0]["Capacity"]);
            int occupied = Convert.ToInt32(dtRoom.Rows[0]["OccupiedBeds"]);
            string roomStatus = dtRoom.Rows[0]["Status"].ToString();

            if (occupied >= capacity || roomStatus != "Available")
            {
                errorMessage = "Selected room is already full or unavailable.";
                return false;
            }

            return _allocationDAL.ApplyForRoom(studentID, roomID);
        }

        public DataTable GetAllAllocations()
        {
            return _allocationDAL.GetAllAllocations();
        }

        public DataTable GetAllocationsByStudent(int studentID)
        {
            return _allocationDAL.GetAllocationsByStudent(studentID);
        }

        public DataTable GetActiveAllocationByStudent(int studentID)
        {
            return _allocationDAL.GetActiveAllocationByStudent(studentID);
        }

        public DataTable GetPendingAllocations()
        {
            return _allocationDAL.GetPendingAllocations();
        }

        public bool ApproveAllocation(int allocationID, int roomID, out string errorMessage)
        {
            errorMessage = string.Empty;

            // Check room capacity before approving
            DataTable dtRoom = _roomDAL.GetRoomByID(roomID);
            if (dtRoom.Rows.Count == 0)
            {
                errorMessage = "Selected room does not exist.";
                return false;
            }

            int capacity = Convert.ToInt32(dtRoom.Rows[0]["Capacity"]);
            int occupied = Convert.ToInt32(dtRoom.Rows[0]["OccupiedBeds"]);

            if (occupied >= capacity)
            {
                errorMessage = "Cannot approve allocation. The room has reached its maximum sharing capacity.";
                return false;
            }

            return _allocationDAL.ApproveAllocation(allocationID, roomID);
        }

        public bool CheckOutAllocation(int allocationID, int roomID, int studentID)
        {
            return _allocationDAL.CheckOutAllocation(allocationID, roomID, studentID);
        }

        public bool RejectAllocation(int allocationID)
        {
            return _allocationDAL.RejectAllocation(allocationID);
        }
    }
}
