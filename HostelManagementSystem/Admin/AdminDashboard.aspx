<%@ Page Title="Warden Dashboard" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="HostelManagementSystem.Admin.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="margin-bottom: 2rem;">
        <h1 style="font-size: 2.2rem; font-weight: 700;">Warden <span>Dashboard</span></h1>
        <p style="color: var(--text-secondary);">Overview of real-time hostel statistics, payments, and accommodation status.</p>
    </div>

    <!-- Statistics Metric Cards -->
    <div class="dashboard-grid">
        <div class="metric-card">
            <div class="metric-info">
                <h4>Total Students</h4>
                <div class="metric-value"><asp:Label ID="lblTotalStudents" runat="server" Text="0"></asp:Label></div>
            </div>
            <div class="metric-icon" style="color: var(--primary-color);"><i class="fas fa-users"></i></div>
        </div>

        <div class="metric-card">
            <div class="metric-info">
                <h4>Beds Occupancy</h4>
                <div class="metric-value"><asp:Label ID="lblOccupiedBeds" runat="server" Text="0"></asp:Label> / <asp:Label ID="lblTotalBeds" runat="server" Text="0"></asp:Label></div>
            </div>
            <div class="metric-icon" style="color: var(--accent-color);"><i class="fas fa-bed"></i></div>
        </div>

        <div class="metric-card">
            <div class="metric-info">
                <h4>Total Revenue</h4>
                <div class="metric-value" style="font-size: 1.4rem; font-weight: 700; color: var(--success-color);">
                    Rs. <asp:Label ID="lblTotalRevenue" runat="server" Text="0.00"></asp:Label>
                </div>
            </div>
            <div class="metric-icon" style="color: var(--success-color);"><i class="fas fa-wallet"></i></div>
        </div>

        <div class="metric-card" style="border-top: 2px solid var(--warning-color);">
            <div class="metric-info">
                <h4>Pending Complaints</h4>
                <div class="metric-value"><asp:Label ID="lblPendingComplaints" runat="server" Text="0"></asp:Label></div>
            </div>
            <div class="metric-icon" style="color: var(--warning-color);"><i class="fas fa-exclamation-triangle"></i></div>
        </div>
    </div>

    <!-- Layout Grid: Interactive Chart & Recent Activity list -->
    <div style="display: grid; grid-template-columns: 3fr 2fr; gap: 2rem; align-items: start;">
        
        <!-- Left Column: Dynamic Visualizations (Requirement: Dashboard Charts) -->
        <div class="glass-card" style="margin-bottom: 0;">
            <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-chart-bar" style="color: var(--primary-color);"></i> Room Occupancy Statistics</h3>
            <div style="text-align: center; margin-bottom: 1.5rem;">
                <canvas id="occupancyChart" width="450" height="250" style="max-width: 100%; border: 1px solid var(--glass-border); border-radius: 8px; background: rgba(0,0,0,0.02);"></canvas>
            </div>
            <p style="font-size: 0.8rem; color: var(--text-secondary); text-align: center;">
                Real-time sharing vacancy chart (Occupied Beds vs Total Available Beds).
            </p>
        </div>

        <!-- Right Column: System Notice & Reminders -->
        <div class="glass-card" style="margin-bottom: 0;">
            <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-tasks" style="color: var(--primary-color);"></i> Administrative Tasks</h3>
            
            <div style="display: flex; flex-direction: column; gap: 1.25rem;">
                <div style="display: flex; gap: 1rem; align-items: center; border-bottom: 1px solid var(--glass-border); padding-bottom: 0.75rem;">
                    <div style="font-size: 1.5rem; color: var(--warning-color);"><i class="fas fa-user-clock"></i></div>
                    <div>
                        <h4 style="font-size: 0.9rem; font-weight: 600;"><a href='<%= Page.ResolveUrl("~/Admin/ManageAllocations") %>' style="color: var(--text-primary); text-decoration: none;">Pending Room Requests</a></h4>
                        <p style="font-size: 0.75rem; color: var(--text-secondary);">Process and assign rooms for incoming student registrations.</p>
                    </div>
                </div>

                <div style="display: flex; gap: 1rem; align-items: center; border-bottom: 1px solid var(--glass-border); padding-bottom: 0.75rem;">
                    <div style="font-size: 1.5rem; color: var(--primary-color);"><i class="fas fa-file-invoice-dollar"></i></div>
                    <div>
                        <h4 style="font-size: 0.9rem; font-weight: 600;"><a href='<%= Page.ResolveUrl("~/Admin/ManagePayments") %>' style="color: var(--text-primary); text-decoration: none;">Verify Student Fees</a></h4>
                        <p style="font-size: 0.75rem; color: var(--text-secondary);">Cross-verify transaction ID reference records with bank logs.</p>
                    </div>
                </div>

                <div style="display: flex; gap: 1rem; align-items: center; padding-bottom: 0.25rem;">
                    <div style="font-size: 1.5rem; color: var(--accent-color);"><i class="fas fa-headset"></i></div>
                    <div>
                        <h4 style="font-size: 0.9rem; font-weight: 600;"><a href='<%= Page.ResolveUrl("~/Admin/ManageComplaints") %>' style="color: var(--text-primary); text-decoration: none;">Resolve Active Complaints</a></h4>
                        <p style="font-size: 0.75rem; color: var(--text-secondary);">Submit warden replies to pending tickets and update progress.</p>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Script to render the dynamic Canvas statistics chart -->
    <script type="text/javascript">
        window.addEventListener("DOMContentLoaded", function () {
            // Fetch stats from viewstate/labels and trigger site.js render function
            var occupied = parseInt('<%= ViewState["OccupiedCount"] %>') || 0;
            var capacity = parseInt('<%= ViewState["CapacityCount"] %>') || 1;
            var vacant = Math.max(capacity - occupied, 0);

            // Render chart (Labels, Values, Hex Colors)
            renderDashboardChart("occupancyChart", 
                ["Occupied Beds", "Vacant Beds"], 
                [occupied, vacant], 
                ["#4f46e5", "#06b6d4"]
            );
        });
    </script>
</asp:Content>
