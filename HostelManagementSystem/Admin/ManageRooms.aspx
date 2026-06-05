<%@ Page Title="Manage Rooms" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="ManageRooms.aspx.cs" Inherits="HostelManagementSystem.Admin.ManageRooms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="margin-bottom: 2rem;">
        <h1 style="font-size: 2.2rem; font-weight: 700;">Hostel & Room <span>Administration</span></h1>
        <p style="color: var(--text-secondary);">Add blocks, configure sharing configurations, change rates, and manage available beds.</p>
    </div>

    <!-- Status Message Label -->
    <asp:Label ID="lblStatusMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; display: block; font-weight: bold; margin-bottom: 1.5rem; text-align: center;"></asp:Label>

    <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 2rem; align-items: start;">
        
        <!-- Left Side: Add Block & Add Room forms -->
        <div style="display: flex; flex-direction: column; gap: 2rem;">
            
            <!-- Block Creation Form -->
            <div class="glass-card" style="margin-bottom: 0;">
                <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-cubes" style="color: var(--primary-color);"></i> Add Hostel Block</h3>
                
                <div class="form-group">
                    <label class="form-label" for="<%= txtBlockName.ClientID %>">Block Name</label>
                    <asp:TextBox ID="txtBlockName" runat="server" CssClass="form-control-custom" placeholder="e.g. D-Block"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvBlockName" runat="server" ControlToValidate="txtBlockName" ErrorMessage="Block Name is required." CssClass="validator-error" Display="Dynamic" ValidationGroup="BlockGroup"></asp:RequiredFieldValidator>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="<%= txtBlockDesc.ClientID %>">Description</label>
                    <asp:TextBox ID="txtBlockDesc" runat="server" CssClass="form-control-custom" placeholder="e.g. Standard sharing rooms" style="max-width: 100%;"></asp:TextBox>
                </div>

                <asp:Button ID="btnBlockSubmit" runat="server" Text="Create Block" OnClick="btnBlockSubmit_Click" CssClass="btn-custom btn-primary-custom" style="width: 100%; margin-top: 1rem;" ValidationGroup="BlockGroup" />
            </div>

            <!-- Room Creation Form -->
            <div class="glass-card" style="margin-bottom: 0;">
                <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-plus" style="color: var(--primary-color);"></i> Add Room</h3>
                
                <div class="form-group">
                    <label class="form-label" for="<%= ddlBlockSelect.ClientID %>">Hostel Block</label>
                    <asp:DropDownList ID="ddlBlockSelect" runat="server" CssClass="form-control-custom"></asp:DropDownList>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                    <div class="form-group">
                        <label class="form-label" for="<%= txtRoomNumber.ClientID %>">Room Number</label>
                        <asp:TextBox ID="txtRoomNumber" runat="server" CssClass="form-control-custom" placeholder="e.g. A-301"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvRoomNum" runat="server" ControlToValidate="txtRoomNumber" ErrorMessage="Required." CssClass="validator-error" Display="Dynamic" ValidationGroup="RoomGroup"></asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="<%= txtFloorNumber.ClientID %>">Floor Level</label>
                        <asp:TextBox ID="txtFloorNumber" runat="server" TextMode="Number" CssClass="form-control-custom" placeholder="e.g. 1"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFloor" runat="server" ControlToValidate="txtFloorNumber" ErrorMessage="Required." CssClass="validator-error" Display="Dynamic" ValidationGroup="RoomGroup"></asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="<%= ddlRoomTypeSelect.ClientID %>">Sharing Configuration</label>
                    <asp:DropDownList ID="ddlRoomTypeSelect" runat="server" CssClass="form-control-custom">
                        <asp:ListItem Value="AC Single Deluxe">AC Single Deluxe</asp:ListItem>
                        <asp:ListItem Value="AC Double Sharing">AC Double Sharing</asp:ListItem>
                        <asp:ListItem Value="Non-AC Double Sharing">Non-AC Double Sharing</asp:ListItem>
                        <asp:ListItem Value="Non-AC Triple Sharing">Non-AC Triple Sharing</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                    <div class="form-group">
                        <label class="form-label" for="<%= txtCapacity.ClientID %>">Bed Capacity</label>
                        <asp:TextBox ID="txtCapacity" runat="server" TextMode="Number" CssClass="form-control-custom" placeholder="e.g. 2"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCapacity" runat="server" ControlToValidate="txtCapacity" ErrorMessage="Required." CssClass="validator-error" Display="Dynamic" ValidationGroup="RoomGroup"></asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="<%= txtMonthlyFee.ClientID %>">Monthly Rate</label>
                        <asp:TextBox ID="txtMonthlyFee" runat="server" CssClass="form-control-custom" placeholder="e.g. 6000"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFee" runat="server" ControlToValidate="txtMonthlyFee" ErrorMessage="Required." CssClass="validator-error" Display="Dynamic" ValidationGroup="RoomGroup"></asp:RequiredFieldValidator>
                    </div>
                </div>

                <asp:Button ID="btnRoomSubmit" runat="server" Text="Create Room" OnClick="btnRoomSubmit_Click" CssClass="btn-custom btn-primary-custom" style="width: 100%; margin-top: 1rem;" ValidationGroup="RoomGroup" />
            </div>

        </div>

        <!-- Right Side: Rooms GridView List (Requirement: GridView) -->
        <div class="glass-card" style="margin-bottom: 0;">
            <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-bed" style="color: var(--primary-color);"></i> Configured Rooms List</h3>
            
            <div class="gridview-container" style="margin-bottom: 0;">
                <asp:GridView ID="gvRooms" runat="server" AutoGenerateColumns="False" CssClass="custom-gridview" GridLines="None"
                    DataKeyNames="RoomID,BlockID" 
                    OnRowEditing="gvRooms_RowEditing" 
                    OnRowCancelingEdit="gvRooms_RowCancelingEdit" 
                    OnRowUpdating="gvRooms_RowUpdating" 
                    OnRowDeleting="gvRooms_RowDeleting">
                    <Columns>
                        <asp:BoundField DataField="RoomID" HeaderText="ID" ReadOnly="True" />
                        
                        <asp:TemplateField HeaderText="Room Number">
                            <ItemTemplate>
                                <strong><%# Eval("RoomNumber") %></strong>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditRoomNumber" runat="server" Text='<%# Bind("RoomNumber") %>' CssClass="form-control-custom" style="font-size:0.85rem; padding: 0.4rem; width: 80px;"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Block">
                            <ItemTemplate>
                                <%# Eval("BlockName") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Type">
                            <ItemTemplate>
                                <%# Eval("RoomType") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlEditRoomType" runat="server" SelectedValue='<%# Bind("RoomType") %>' CssClass="form-control-custom" style="font-size:0.85rem; padding: 0.4rem; width: 140px;">
                                    <asp:ListItem Value="AC Single Deluxe">AC Single Deluxe</asp:ListItem>
                                    <asp:ListItem Value="AC Double Sharing">AC Double Sharing</asp:ListItem>
                                    <asp:ListItem Value="Non-AC Double Sharing">Non-AC Double Sharing</asp:ListItem>
                                    <asp:ListItem Value="Non-AC Triple Sharing">Non-AC Triple Sharing</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Occupancy">
                            <ItemTemplate>
                                <%# Eval("OccupiedBeds") %> / <%# Eval("Capacity") %> Beds
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditCapacity" runat="server" Text='<%# Bind("Capacity") %>' TextMode="Number" CssClass="form-control-custom" style="font-size:0.85rem; padding: 0.4rem; width: 60px;"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Monthly Rate">
                            <ItemTemplate>
                                Rs. <%# Convert.ToDecimal(Eval("MonthlyFee")).ToString("N2") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditMonthlyFee" runat="server" Text='<%# Bind("MonthlyFee") %>' CssClass="form-control-custom" style="font-size:0.85rem; padding: 0.4rem; width: 80px;"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class="badge-custom <%# GetStatusBadgeClass(Eval("Status").ToString()) %>">
                                    <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlEditStatus" runat="server" SelectedValue='<%# Bind("Status") %>' CssClass="form-control-custom" style="font-size:0.85rem; padding: 0.4rem; width: 110px;">
                                    <asp:ListItem Value="Available">Available</asp:ListItem>
                                    <asp:ListItem Value="Full">Full</asp:ListItem>
                                    <asp:ListItem Value="Maintenance">Maintenance</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn-custom btn-secondary-custom" style="padding: 0.25rem 0.6rem; font-size: 0.8rem; margin-right: 0.25rem;" CausesValidation="false"><i class="fas fa-edit"></i> Edit</asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn-custom btn-danger-custom" style="padding: 0.25rem 0.6rem; font-size: 0.8rem;" OnClientClick="return confirm('Are you sure you want to delete this room configuration permanently?');" CausesValidation="false"><i class="fas fa-trash"></i> Delete</asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn-custom btn-success-custom" style="padding: 0.25rem 0.6rem; font-size: 0.8rem; margin-right: 0.25rem; color: white;" ValidationGroup="EditGroup"><i class="fas fa-save"></i> Save</asp:LinkButton>
                                <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn-custom btn-secondary-custom" style="padding: 0.25rem 0.6rem; font-size: 0.8rem;" CausesValidation="false"><i class="fas fa-times"></i> Cancel</asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div style="padding: 3rem 1rem; text-align: center; color: var(--text-secondary);">
                            <div style="font-size: 3rem; margin-bottom: 1rem;"><i class="fas fa-bed"></i></div>
                            <h4>No Rooms Configured</h4>
                            <p>Add blocks and configure rooms using the left-hand form panel.</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>

    </div>
</asp:Content>
