<%@ Page Title="Room Details" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="RoomDetails.aspx.cs" Inherits="HostelManagementSystem.Student.RoomDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width: 800px; margin: 2rem auto; padding: 0 1rem;">
        <h1 class="form-title" style="text-align: left; font-size: 2.2rem; margin-bottom: 2rem;">My Room <span>Details</span></h1>

        <!-- If no room is allocated -->
        <asp:Panel ID="pnlNoRoom" runat="server" CssClass="glass-card text-center" style="padding: 3rem 2rem;">
            <div style="font-size: 4rem; color: var(--text-secondary); margin-bottom: 1.5rem;"><i class="fas fa-bed"></i></div>
            <h3>No Room Allocated Yet</h3>
            <p style="color: var(--text-secondary); margin-top: 0.5rem; margin-bottom: 2rem;">You do not currently have an active room allocation. Register your request in the room application module.</p>
            <a href='<%= Page.ResolveUrl("~/Student/ApplyRoom") %>' class="btn-custom btn-primary-custom"><i class="fas fa-arrow-right"></i> Apply for Room</a>
        </asp:Panel>

        <!-- If room is allocated -->
        <asp:Panel ID="pnlRoomDetails" runat="server" CssClass="glass-card" Visible="false">
            <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--glass-border); padding-bottom: 1.5rem; margin-bottom: 2rem;">
                <div>
                    <h2 style="font-size: 1.8rem;"><asp:Label ID="lblRoomNumber" runat="server"></asp:Label></h2>
                    <p style="color: var(--text-secondary);"><asp:Label ID="lblBlockName" runat="server"></asp:Label></p>
                </div>
                <div>
                    <span class="badge-custom badge-active" style="font-size: 0.9rem; padding: 0.4rem 1rem;">Allocated</span>
                </div>
            </div>

            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 2rem; margin-bottom: 2rem;">
                <div>
                    <h4 style="font-size: 0.85rem; text-transform: uppercase; color: var(--text-secondary);">Room Type</h4>
                    <p style="font-size: 1.1rem; font-weight: 600; margin-top: 0.25rem;"><asp:Label ID="lblRoomType" runat="server"></asp:Label></p>
                </div>
                
                <div>
                    <h4 style="font-size: 0.85rem; text-transform: uppercase; color: var(--text-secondary);">Monthly Fee</h4>
                    <p style="font-size: 1.1rem; font-weight: 600; margin-top: 0.25rem; color: var(--primary-color);">Rs. <asp:Label ID="lblMonthlyFee" runat="server"></asp:Label></p>
                </div>

                <div>
                    <h4 style="font-size: 0.85rem; text-transform: uppercase; color: var(--text-secondary);">Floor Number</h4>
                    <p style="font-size: 1.1rem; font-weight: 600; margin-top: 0.25rem;"><asp:Label ID="lblFloorNumber" runat="server"></asp:Label></p>
                </div>

                <div>
                    <h4 style="font-size: 0.85rem; text-transform: uppercase; color: var(--text-secondary);">Sharing Capacity</h4>
                    <p style="font-size: 1.1rem; font-weight: 600; margin-top: 0.25rem;"><asp:Label ID="lblSharingCapacity" runat="server"></asp:Label></p>
                </div>
            </div>

            <div style="background: rgba(79, 70, 229, 0.05); border: 1px solid var(--glass-border); border-radius: 12px; padding: 1.5rem; display: flex; gap: 1rem; align-items: flex-start;">
                <div style="font-size: 1.5rem; color: var(--primary-color);"><i class="fas fa-info-circle"></i></div>
                <div>
                    <h4 style="font-size: 0.95rem; font-weight: 600;">Check-In & Stay Details</h4>
                    <p style="font-size: 0.85rem; color: var(--text-secondary); margin-top: 0.25rem;">
                        Your allocation date: <strong><asp:Label ID="lblAllocationDate" runat="server"></asp:Label></strong>. 
                        Your registered check-in date: <strong><asp:Label ID="lblCheckInDate" runat="server"></asp:Label></strong>.
                    </p>
                    <p style="font-size: 0.85rem; color: var(--text-secondary); margin-top: 0.5rem;">To request a room change or checkout, please submit a written request to the Chief Warden's office.</p>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
