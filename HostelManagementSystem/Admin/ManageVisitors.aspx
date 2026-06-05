<%@ Page Title="Visitor Logs" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="ManageVisitors.aspx.cs" Inherits="HostelManagementSystem.Admin.ManageVisitors" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="margin-bottom: 2rem;">
        <h1 style="font-size: 2.2rem; font-weight: 700;">Visitor Logs <span>Management</span></h1>
        <p style="color: var(--text-secondary);">Oversee active hostel guest entries, log exits, and monitor historical records.</p>
    </div>

    <!-- Status Message Label -->
    <asp:Label ID="lblStatusMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; display: block; font-weight: bold; margin-bottom: 1.5rem; text-align: center;"></asp:Label>

    <!-- Active Visitors Grid (Requirement: GridView) -->
    <div class="glass-card" style="margin-bottom: 2rem;">
        <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-sign-in-alt" style="color: var(--warning-color);"></i> Currently Inside Hostel</h3>
        
        <div class="gridview-container" style="margin-bottom: 0;">
            <asp:GridView ID="gvActiveVisitors" runat="server" AutoGenerateColumns="False" CssClass="custom-gridview" GridLines="None"
                DataKeyNames="VisitorID"
                OnRowCommand="gvActiveVisitors_RowCommand">
                <Columns>
                    <asp:BoundField DataField="VisitorID" HeaderText="Log ID" />
                    <asp:BoundField DataField="VisitorName" HeaderText="Guest Name" />
                    <asp:BoundField DataField="Relationship" HeaderText="Relation" />
                    <asp:BoundField DataField="FullName" HeaderText="Visiting Student" />
                    <asp:BoundField DataField="RoomNumber" HeaderText="Room" />
                    <asp:TemplateField HeaderText="Visit Date">
                        <ItemTemplate>
                            <%# Convert.ToDateTime(Eval("VisitDate")).ToString("dd MMM yyyy") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Check-In">
                        <ItemTemplate>
                            <%# Eval("CheckInTime") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Log Exit">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnExit" runat="server" CommandName="LogExit" CommandArgument="<%# Container.DataItemIndex %>" CssClass="btn-custom btn-danger-custom" style="padding: 0.3rem 0.8rem; font-size: 0.8rem; color: white;"><i class="fas fa-sign-out-alt"></i> Checkout Guest</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div style="padding: 2rem 1rem; text-align: center; color: var(--text-secondary);">
                        <h4>No Active Guests</h4>
                        <p>There are no recorded visitors currently inside the hostel premises.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <!-- Complete History Grid (Requirement: GridView) -->
    <div class="glass-card" style="margin-bottom: 0;">
        <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-history" style="color: var(--primary-color);"></i> Complete Visitor Logs History</h3>
        
        <div class="gridview-container" style="margin-bottom: 0;">
            <asp:GridView ID="gvVisitorHistory" runat="server" AutoGenerateColumns="False" CssClass="custom-gridview" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="VisitorID" HeaderText="Log ID" />
                    <asp:BoundField DataField="VisitorName" HeaderText="Guest Name" />
                    <asp:BoundField DataField="Relationship" HeaderText="Relation" />
                    <asp:BoundField DataField="FullName" HeaderText="Visiting Student" />
                    <asp:BoundField DataField="RoomNumber" HeaderText="Room" />
                    <asp:TemplateField HeaderText="Visit Date">
                        <ItemTemplate>
                            <%# Convert.ToDateTime(Eval("VisitDate")).ToString("dd MMM yyyy") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Check-In">
                        <ItemTemplate>
                            <%# Eval("CheckInTime") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Check-Out">
                        <ItemTemplate>
                            <%# Eval("CheckOutTime") == DBNull.Value || string.IsNullOrEmpty(Eval("CheckOutTime").ToString()) ? "<span class='badge-custom badge-pending'>Still Inside</span>" : Eval("CheckOutTime") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div style="padding: 2rem 1rem; text-align: center; color: var(--text-secondary);">
                        <h4>No Historical Logs</h4>
                        <p>No visitor check-ins have been recorded in the system.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
