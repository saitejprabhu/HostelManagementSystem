-- 1. Database Creation
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'HostelManagementDB')
BEGIN
    CREATE DATABASE HostelManagementDB;
END
GO

USE HostelManagementDB;
GO

-- 2. Drop existing tables if they exist (in reverse order of dependencies)
IF OBJECT_ID('dbo.Visitors', 'U') IS NOT NULL DROP TABLE dbo.Visitors;
IF OBJECT_ID('dbo.Complaints', 'U') IS NOT NULL DROP TABLE dbo.Complaints;
IF OBJECT_ID('dbo.Payments', 'U') IS NOT NULL DROP TABLE dbo.Payments;
IF OBJECT_ID('dbo.RoomAllocations', 'U') IS NOT NULL DROP TABLE dbo.RoomAllocations;
IF OBJECT_ID('dbo.Rooms', 'U') IS NOT NULL DROP TABLE dbo.Rooms;
IF OBJECT_ID('dbo.HostelBlocks', 'U') IS NOT NULL DROP TABLE dbo.HostelBlocks;
IF OBJECT_ID('dbo.Students', 'U') IS NOT NULL DROP TABLE dbo.Students;
IF OBJECT_ID('dbo.Admins', 'U') IS NOT NULL DROP TABLE dbo.Admins;
GO

-- 3. Table: Admins
CREATE TABLE Admins (
    AdminID INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL, -- SHA-256 Hashed Password
    Role VARCHAR(50) NOT NULL
);

-- 4. Table: Students
CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    DOB DATE NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Mobile VARCHAR(15) NOT NULL,
    Address VARCHAR(250) NOT NULL,
    Course VARCHAR(100) NOT NULL,
    Year INT NOT NULL,
    Password VARCHAR(100) NOT NULL, -- SHA-256 Hashed Password
    ProfilePicture VARCHAR(250) NULL,
    RegistrationDate DATETIME DEFAULT GETDATE(),
    Status VARCHAR(20) DEFAULT 'Pending' -- Pending, Approved, Suspended
);

-- 5. Table: HostelBlocks
CREATE TABLE HostelBlocks (
    BlockID INT IDENTITY(1,1) PRIMARY KEY,
    BlockName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(250) NULL,
    TotalRooms INT DEFAULT 0
);

-- 6. Table: Rooms
CREATE TABLE Rooms (
    RoomID INT IDENTITY(1,1) PRIMARY KEY,
    RoomNumber VARCHAR(20) NOT NULL UNIQUE,
    RoomType VARCHAR(50) NOT NULL, -- AC, Non-AC
    Capacity INT NOT NULL,
    OccupiedBeds INT DEFAULT 0,
    FloorNumber INT NOT NULL,
    MonthlyFee DECIMAL(10,2) NOT NULL,
    Status VARCHAR(20) DEFAULT 'Available', -- Available, Full, Maintenance
    BlockID INT NOT NULL FOREIGN KEY REFERENCES HostelBlocks(BlockID) ON DELETE CASCADE
);

-- 7. Table: RoomAllocations
CREATE TABLE RoomAllocations (
    AllocationID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL FOREIGN KEY REFERENCES Students(StudentID) ON DELETE CASCADE,
    RoomID INT NOT NULL FOREIGN KEY REFERENCES Rooms(RoomID) ON DELETE CASCADE,
    AllocationDate DATETIME DEFAULT GETDATE(),
    CheckInDate DATE NULL,
    Status VARCHAR(20) DEFAULT 'Pending' -- Pending, Active, CheckedOut, Cancelled
);

-- 8. Table: Payments
CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL FOREIGN KEY REFERENCES Students(StudentID) ON DELETE CASCADE,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    PaymentMethod VARCHAR(50) NOT NULL, -- UPI, Debit Card, Credit Card, Net Banking, Cash
    TransactionID VARCHAR(100) NOT NULL UNIQUE,
    Status VARCHAR(20) DEFAULT 'Pending' -- Pending, Paid, Failed
);

-- 9. Table: Complaints
CREATE TABLE Complaints (
    ComplaintID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL FOREIGN KEY REFERENCES Students(StudentID) ON DELETE CASCADE,
    Subject VARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    ComplaintDate DATETIME DEFAULT GETDATE(),
    Status VARCHAR(20) DEFAULT 'Pending', -- Pending, InProgress, Resolved
    Response NVARCHAR(MAX) NULL
);

-- 10. Table: Visitors
CREATE TABLE Visitors (
    VisitorID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL FOREIGN KEY REFERENCES Students(StudentID) ON DELETE CASCADE,
    VisitorName VARCHAR(100) NOT NULL,
    Relationship VARCHAR(50) NOT NULL,
    VisitDate DATE NOT NULL,
    CheckInTime TIME NOT NULL,
    CheckOutTime TIME NULL
);
GO

-- 11. Seed Initial Data
-- Admin Seeding (Password: Password123 hashed using SHA-256)
INSERT INTO Admins (Username, Password, Role) 
VALUES ('admin', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'SuperAdmin');

-- Hostel Blocks Seeding
INSERT INTO HostelBlocks (BlockName, Description, TotalRooms) VALUES
('A-Block', 'Boys Premium Wing - AC & Deluxe Rooms', 5),
('B-Block', 'Girls Premium Wing - AC & Deluxe Rooms', 5),
('C-Block', 'Boys Regular Wing - Non-AC Shared Rooms', 10);

-- Rooms Seeding
-- A-Block Rooms
INSERT INTO Rooms (RoomNumber, RoomType, Capacity, OccupiedBeds, FloorNumber, MonthlyFee, Status, BlockID) VALUES
('A-101', 'AC Double Sharing', 2, 0, 1, 8000.00, 'Available', 1),
('A-102', 'AC Single Deluxe', 1, 0, 1, 12000.00, 'Available', 1),
('A-201', 'AC Double Sharing', 2, 0, 2, 8000.00, 'Available', 1);

-- B-Block Rooms
INSERT INTO Rooms (RoomNumber, RoomType, Capacity, OccupiedBeds, FloorNumber, MonthlyFee, Status, BlockID) VALUES
('B-101', 'AC Double Sharing', 2, 0, 1, 8000.00, 'Available', 2),
('B-102', 'AC Single Deluxe', 1, 0, 1, 12000.00, 'Available', 2),
('B-201', 'AC Double Sharing', 2, 0, 2, 8000.00, 'Available', 2);

-- C-Block Rooms
INSERT INTO Rooms (RoomNumber, RoomType, Capacity, OccupiedBeds, FloorNumber, MonthlyFee, Status, BlockID) VALUES
('C-101', 'Non-AC Triple Sharing', 3, 0, 1, 4500.00, 'Available', 3),
('C-102', 'Non-AC Double Sharing', 2, 0, 1, 5500.00, 'Available', 3),
('C-201', 'Non-AC Triple Sharing', 3, 0, 2, 4500.00, 'Available', 3);

-- Update Block Room Count
UPDATE HostelBlocks SET TotalRooms = 3 WHERE BlockID IN (1, 2, 3);
GO
