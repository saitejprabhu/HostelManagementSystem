<%@ Page Title="Student Dashboard" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="StudentDashboard.aspx.cs" Inherits="HostelManagementSystem.Student.StudentDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width: 1200px; margin: 2rem auto; padding: 0 1rem;">
        
        <!-- Welcome Header -->
        <div style="margin-bottom: 2.5rem; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
            <div>
                <h1 style="font-size: 2.2rem; font-weight: 700;">Welcome, <asp:Label ID="lblStudentName" runat="server" Text="Student"></asp:Label>!</h1>
                <p style="color: var(--text-secondary);">Here is a summary of your residential dashboard.</p>
            </div>
            <div>
                <span class="badge-custom <%= GetStatusBadgeClass() %>" style="font-size: 0.95rem; padding: 0.5rem 1rem;">
                    Account Status: <asp:Label ID="lblAccountStatus" runat="server" Text="Pending"></asp:Label>
                </span>
            </div>
        </div>

        <!-- Metric Grid -->
        <div class="dashboard-grid">
            <!-- Room Info Card -->
            <div class="metric-card">
                <div class="metric-info">
                    <h4>Room Assigned</h4>
                    <div class="metric-value" style="font-size: 1.5rem; margin-top: 0.25rem;">
                        <asp:Label ID="lblRoomNumber" runat="server" Text="Not Allocated"></asp:Label>
                    </div>
                    <p style="font-size: 0.8rem; color: var(--text-secondary); margin-top: 0.25rem;">
                        <asp:Label ID="lblBlockName" runat="server" Text="-"></asp:Label>
                    </p>
                </div>
                <div class="metric-icon"><i class="fas fa-bed"></i></div>
            </div>

            <!-- Last Payment Card -->
            <div class="metric-card">
                <div class="metric-info">
                    <h4>Last Payment</h4>
                    <div class="metric-value" style="font-size: 1.5rem; margin-top: 0.25rem;">
                        <asp:Label ID="lblLastPaymentAmount" runat="server" Text="No History"></asp:Label>
                    </div>
                    <p style="font-size: 0.8rem; color: var(--text-secondary); margin-top: 0.25rem;">
                        <asp:Label ID="lblLastPaymentDate" runat="server" Text="-"></asp:Label>
                    </p>
                </div>
                <div class="metric-icon"><i class="fas fa-receipt"></i></div>
            </div>

            <!-- Complaints Summary Card -->
            <div class="metric-card">
                <div class="metric-info">
                    <h4>Complaints Status</h4>
                    <div class="metric-value" style="font-size: 1.5rem; margin-top: 0.25rem;">
                        <asp:Label ID="lblTotalComplaints" runat="server" Text="0 Tickets"></asp:Label>
                    </div>
                    <p style="font-size: 0.8rem; color: var(--text-secondary); margin-top: 0.25rem;">
                        Pending: <asp:Label ID="lblPendingComplaints" runat="server" Text="0"></asp:Label>
                    </p>
                </div>
                <div class="metric-icon"><i class="fas fa-exclamation-circle"></i></div>
            </div>
        </div>

        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 2rem; align-items: start; margin-top: 2rem;">
            <!-- Main Board Notification card -->
            <div class="glass-card" style="margin-bottom: 0;">
                <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-bullhorn" style="color: var(--primary-color);"></i> Notice Board</h3>
                <div style="display: flex; flex-direction: column; gap: 1.25rem;">
                    <div style="border-left: 3px solid var(--accent-color); padding-left: 1rem;">
                        <h4 style="font-size: 0.95rem; font-weight: 600;">Monthly Fee Invoice Generated</h4>
                        <p style="font-size: 0.85rem; color: var(--text-secondary); margin-top: 0.25rem;">Please pay your room monthly fee by the 5th of each month in the Fee Payment module to avoid late charges.</p>
                    </div>
                    <div style="border-left: 3px solid var(--primary-color); padding-left: 1rem;">
                        <h4 style="font-size: 0.95rem; font-weight: 600;">Hostel Gate Timings Reminder</h4>
                        <p style="font-size: 0.85rem; color: var(--text-secondary); margin-top: 0.25rem;">Strict entry hours are observed. All gates lock at 9:00 PM. Wardens will verify registers daily.</p>
                    </div>
                </div>
            </div>

            <!-- Profile Overview Quick Card -->
            <div class="glass-card" style="margin-bottom: 0; text-align: center;">
                <div style="display: flex; flex-direction: column; align-items: center; gap: 1rem;">
                    <div class="profile-avatar-container" style="width: 100px; height: 100px; border-width: 3px;">
                        <asp:Image ID="imgAvatar" runat="server" CssClass="profile-avatar" ImageUrl="~/Images/default-avatar.png" AlternateText="Avatar" />
                    </div>
                    <div>
                        <h3 style="font-size: 1.2rem;"><%= Session["StudentName"] %></h3>
                        <p style="font-size: 0.85rem; color: var(--text-secondary);"><%= Session["StudentEmail"] %></p>
                    </div>
                    <a href='<%= Page.ResolveUrl("~/Student/MyProfile") %>' class="btn-custom btn-secondary-custom" style="width: 100%; font-size: 0.85rem; padding: 0.5rem 1rem;">Edit Profile</a>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
