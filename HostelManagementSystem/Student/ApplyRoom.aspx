<%@ Page Title="Apply Room" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="ApplyRoom.aspx.cs" Inherits="HostelManagementSystem.Student.ApplyRoom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .rooms-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }
        .room-card {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width: 1200px; margin: 2rem auto; padding: 0 1rem;">
        
        <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; margin-bottom: 2rem; gap: 1rem;">
            <div>
                <h1 class="form-title" style="text-align: left; font-size: 2.2rem; margin-bottom: 0.25rem;">Apply for <span>Accommodation</span></h1>
                <p style="color: var(--text-secondary);">Browse available rooms, filter by your preferences, and apply instantly.</p>
            </div>
            <div>
                <a href='<%= Page.ResolveUrl("~/Student/StudentDashboard") %>' class="btn-custom btn-secondary-custom"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
            </div>
        </div>

        <asp:Label ID="lblStatusMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; margin-bottom: 1.5rem; display: block; font-weight: bold; text-align: center;"></asp:Label>

        <!-- Filters Form -->
        <div class="glass-card" style="padding: 1.5rem; display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)) auto; gap: 1.5rem; align-items: end;">
            <div class="form-group" style="margin-bottom: 0;">
                <label class="form-label" for="<%= ddlFilterBlock.ClientID %>">Hostel Block</label>
                <asp:DropDownList ID="ddlFilterBlock" runat="server" CssClass="form-control-custom"></asp:DropDownList>
            </div>
            
            <div class="form-group" style="margin-bottom: 0;">
                <label class="form-label" for="<%= ddlFilterRoomType.ClientID %>">Room Sharing Type</label>
                <asp:DropDownList ID="ddlFilterRoomType" runat="server" CssClass="form-control-custom">
                    <asp:ListItem Value="">All Types</asp:ListItem>
                    <asp:ListItem Value="AC Single Deluxe">AC Single Deluxe</asp:ListItem>
                    <asp:ListItem Value="AC Double Sharing">AC Double Sharing</asp:ListItem>
                    <asp:ListItem Value="Non-AC Double Sharing">Non-AC Double Sharing</asp:ListItem>
                    <asp:ListItem Value="Non-AC Triple Sharing">Non-AC Triple Sharing</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group" style="margin-bottom: 0;">
                <label class="form-label" for="<%= txtFilterMaxFee.ClientID %>">Max Monthly Fee (Rs.)</label>
                <asp:TextBox ID="txtFilterMaxFee" runat="server" TextMode="Number" CssClass="form-control-custom" placeholder="e.g. 10000"></asp:TextBox>
            </div>

            <asp:Button ID="btnFilterApply" runat="server" Text="Filter Rooms" OnClick="btnFilterApply_Click" CssClass="btn-custom btn-primary-custom" style="padding: 0.75rem 2rem;" />
        </div>

        <!-- Available Rooms Repeater List (Requirement: Repeater Control) -->
        <asp:Panel ID="pnlRoomList" runat="server">
            <div class="rooms-grid">
                <asp:Repeater ID="rptAvailableRooms" runat="server" OnItemCommand="rptAvailableRooms_ItemCommand">
                    <ItemTemplate>
                        <div class="glass-card room-card">
                            <div>
                                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                                    <h3 style="font-size: 1.4rem;">Room <%# Eval("RoomNumber") %></h3>
                                    <span class="badge-custom badge-active"><%# Eval("RoomType") %></span>
                                </div>
                                
                                <div style="display: flex; flex-direction: column; gap: 0.5rem; margin-bottom: 1.5rem; font-size: 0.9rem; color: var(--text-secondary);">
                                    <div><i class="fas fa-building" style="width: 20px; color: var(--primary-color);"></i> Block: <strong><%# Eval("BlockName") %></strong></div>
                                    <div><i class="fas fa-layer-group" style="width: 20px; color: var(--primary-color);"></i> Floor: <strong><%# Eval("FloorNumber") %> Floor</strong></div>
                                    <div><i class="fas fa-users" style="width: 20px; color: var(--primary-color);"></i> Sharing Capacity: <strong><%# Eval("Capacity") %> Beds</strong></div>
                                    <div><i class="fas fa-bed" style="width: 20px; color: var(--primary-color);"></i> Vacancy: <strong><%# Convert.ToInt32(Eval("Capacity")) - Convert.ToInt32(Eval("OccupiedBeds")) %> Available</strong></div>
                                </div>
                            </div>
                            
                            <div style="display: flex; align-items: center; justify-content: space-between; border-top: 1px solid var(--glass-border); padding-top: 1rem; margin-top: 1rem;">
                                <div>
                                    <span style="font-size: 0.8rem; text-transform: uppercase; color: var(--text-secondary); display: block;">Monthly Fee</span>
                                    <strong style="font-size: 1.25rem; color: var(--primary-color);">Rs. <%# Convert.ToDecimal(Eval("MonthlyFee")).ToString("N2") %></strong>
                                </div>
                                <asp:LinkButton ID="lnkApply" runat="server" CommandName="ApplyRoom" CommandArgument='<%# Eval("RoomID") %>' CssClass="btn-custom btn-primary-custom" style="padding: 0.5rem 1.25rem; font-size: 0.85rem; color: white;">
                                    <i class="fas fa-check"></i> Apply
                                </asp:LinkButton>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </asp:Panel>

        <!-- If no available rooms found -->
        <asp:Panel ID="pnlNoRooms" runat="server" Visible="false" CssClass="glass-card text-center" style="padding: 4rem 2rem; margin-top: 2rem;">
            <div style="font-size: 4rem; color: var(--text-secondary); margin-bottom: 1.5rem;"><i class="fas fa-search"></i></div>
            <h3>No Rooms Found</h3>
            <p style="color: var(--text-secondary); margin-top: 0.5rem;">There are no rooms matching your search filters, or all rooms are currently full.</p>
        </asp:Panel>

    </div>
</asp:Content>
