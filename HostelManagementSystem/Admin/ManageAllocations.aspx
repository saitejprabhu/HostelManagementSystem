<%@ Page Title="Manage Allocations" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="ManageAllocations.aspx.cs" Inherits="HostelManagementSystem.Admin.ManageAllocations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="margin-bottom: 2rem;">
        <h1 style="font-size: 2.2rem; font-weight: 700;">Room <span>Allocations Management</span></h1>
        <p style="color: var(--text-secondary);">Approve pending room requests, track check-ins, or process student check-out records.</p>
    </div>

    <!-- Status Message Label -->
    <asp:Label ID="lblStatusMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; display: block; font-weight: bold; margin-bottom: 1.5rem; text-align: center;"></asp:Label>

    <!-- Pending Applications (Requirement: GridView) -->
    <div class="glass-card" style="margin-bottom: 2rem;">
        <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-clock" style="color: var(--warning-color);"></i> Pending Room Requests</h3>
        
        <div class="gridview-container" style="margin-bottom: 0;">
            <asp:GridView ID="gvPendingAllocations" runat="server" AutoGenerateColumns="False" CssClass="custom-gridview" GridLines="None"
                DataKeyNames="AllocationID,RoomID,StudentID" 
                OnRowCommand="gvPendingAllocations_RowCommand">
                <Columns>
                    <asp:BoundField DataField="AllocationID" HeaderText="App ID" />
                    <asp:BoundField DataField="FullName" HeaderText="Student" />
                    <asp:BoundField DataField="Email" HeaderText="Email Address" />
                    <asp:TemplateField HeaderText="Requested Room">
                        <ItemTemplate>
                            <strong>Room <%# Eval("RoomNumber") %></strong> (<%# Eval("BlockName") %>)
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Application Date">
                        <ItemTemplate>
                            <%# Convert.ToDateTime(Eval("AllocationDate")).ToString("dd MMM yyyy hh:mm tt") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnApprove" runat="server" CommandName="ApproveAlloc" CommandArgument="<%# Container.DataItemIndex %>" CssClass="btn-custom btn-success-custom" style="padding: 0.3rem 0.8rem; font-size: 0.8rem; color: white; margin-right: 0.5rem;"><i class="fas fa-check"></i> Approve</asp:LinkButton>
                            <asp:LinkButton ID="btnReject" runat="server" CommandName="RejectAlloc" CommandArgument="<%# Container.DataItemIndex %>" CssClass="btn-custom btn-danger-custom" style="padding: 0.3rem 0.8rem; font-size: 0.8rem;" OnClientClick="return confirm('Are you sure you want to reject this request?');"><i class="fas fa-times"></i> Reject</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div style="padding: 2rem 1rem; text-align: center; color: var(--text-secondary);">
                        <h4>No Pending Applications</h4>
                        <p>There are no room requests waiting for approval at this time.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <!-- Allocation History (Requirement: GridView) -->
    <div class="glass-card" style="margin-bottom: 0;">
        <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-history" style="color: var(--primary-color);"></i> Active Allocations & History</h3>
        
        <div class="gridview-container" style="margin-bottom: 0;">
            <asp:GridView ID="gvAllAllocations" runat="server" AutoGenerateColumns="False" CssClass="custom-gridview" GridLines="None"
                DataKeyNames="AllocationID,RoomID,StudentID"
                OnRowCommand="gvAllAllocations_RowCommand">
                <Columns>
                    <asp:BoundField DataField="AllocationID" HeaderText="Alloc ID" />
                    <asp:BoundField DataField="FullName" HeaderText="Student" />
                    <asp:TemplateField HeaderText="Assigned Accommodation">
                        <ItemTemplate>
                            <strong>Room <%# Eval("RoomNumber") %></strong> (<%# Eval("BlockName") %>)
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Check-In Date">
                        <ItemTemplate>
                            <%# Eval("CheckInDate") == DBNull.Value || string.IsNullOrEmpty(Eval("CheckInDate").ToString()) ? "-" : Convert.ToDateTime(Eval("CheckInDate")).ToString("dd MMM yyyy") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Allocation Status">
                        <ItemTemplate>
                            <span class="badge-custom <%# GetStatusBadgeClass(Eval("Status").ToString()) %>">
                                <%# Eval("Status") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Operations">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnCheckout" runat="server" CommandName="CheckoutStudent" CommandArgument="<%# Container.DataItemIndex %>" CssClass="btn-custom btn-secondary-custom" style="padding: 0.3rem 0.8rem; font-size: 0.8rem;" Visible='<%# Eval("Status").ToString() == "Active" %>' OnClientClick="return confirm('Are you sure you want to check-out this student? This will free the allocated bed space.');"><i class="fas fa-sign-out-alt"></i> Check-Out</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div style="padding: 2rem 1rem; text-align: center; color: var(--text-secondary);">
                        <h4>No History Records</h4>
                        <p>No historical room allocations are registered in the database.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
