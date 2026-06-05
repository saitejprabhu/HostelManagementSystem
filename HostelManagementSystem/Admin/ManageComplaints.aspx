<%@ Page Title="Manage Complaints" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="ManageComplaints.aspx.cs" Inherits="HostelManagementSystem.Admin.ManageComplaints" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="margin-bottom: 2rem;">
        <h1 style="font-size: 2.2rem; font-weight: 700;">Complaint <span>Management System</span></h1>
        <p style="color: var(--text-secondary);">Respond to logged student grievances, track ongoing repairs, and close resolved tickets.</p>
    </div>

    <!-- Status Message Label -->
    <asp:Label ID="lblStatusMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; display: block; font-weight: bold; margin-bottom: 1.5rem; text-align: center;"></asp:Label>

    <!-- Complaints Grid (Requirement: GridView) -->
    <div class="glass-card" style="margin-bottom: 0;">
        <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-exclamation-triangle" style="color: var(--primary-color);"></i> Grievance Tickets</h3>
        
        <div class="gridview-container" style="margin-bottom: 0;">
            <asp:GridView ID="gvManageComplaints" runat="server" AutoGenerateColumns="False" CssClass="custom-gridview" GridLines="None"
                DataKeyNames="ComplaintID"
                OnRowEditing="gvManageComplaints_RowEditing"
                OnRowCancelingEdit="gvManageComplaints_RowCancelingEdit"
                OnRowUpdating="gvManageComplaints_RowUpdating">
                <Columns>
                    <asp:BoundField DataField="ComplaintID" HeaderText="Ticket ID" ReadOnly="True" />
                    <asp:BoundField DataField="FullName" HeaderText="Student" ReadOnly="True" />
                    <asp:BoundField DataField="Subject" HeaderText="Subject" ReadOnly="True" />
                    
                    <asp:TemplateField HeaderText="Description">
                        <ItemTemplate>
                            <span style="font-size:0.85rem; color: var(--text-secondary);"><%# Eval("Description") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Date Raised">
                        <ItemTemplate>
                            <%# Convert.ToDateTime(Eval("ComplaintDate")).ToString("dd MMM yyyy hh:mm tt") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class="badge-custom <%# GetStatusBadgeClass(Eval("Status").ToString()) %>">
                                <%# Eval("Status") %>
                            </span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlEditStatus" runat="server" SelectedValue='<%# Bind("Status") %>' CssClass="form-control-custom" style="font-size:0.85rem; padding: 0.4rem; width: 120px;">
                                <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                <asp:ListItem Value="InProgress">InProgress</asp:ListItem>
                                <asp:ListItem Value="Resolved">Resolved</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Warden's Response">
                        <ItemTemplate>
                            <span style="font-style: italic; color: var(--text-secondary);">
                                <%# Eval("Response") == DBNull.Value || string.IsNullOrEmpty(Eval("Response").ToString()) ? "No response." : Eval("Response") %>
                            </span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditResponse" runat="server" Text='<%# Bind("Response") %>' CssClass="form-control-custom" style="font-size:0.85rem; padding: 0.4rem;" placeholder="Type response..."></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn-custom btn-secondary-custom" style="padding: 0.25rem 0.6rem; font-size: 0.8rem;" CausesValidation="false"><i class="fas fa-reply"></i> Reply</asp:LinkButton>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn-custom btn-success-custom" style="padding: 0.25rem 0.6rem; font-size: 0.8rem; margin-right: 0.25rem; color: white;" ValidationGroup="EditGroup"><i class="fas fa-save"></i> Save</asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn-custom btn-secondary-custom" style="padding: 0.25rem 0.6rem; font-size: 0.8rem;" CausesValidation="false"><i class="fas fa-times"></i> Cancel</asp:LinkButton>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div style="padding: 3rem 1rem; text-align: center; color: var(--text-secondary);">
                        <div style="font-size: 3rem; margin-bottom: 1rem;"><i class="fas fa-folder-open"></i></div>
                        <h4>No Grievance Tickets Found</h4>
                        <p>No student complaints are currently logged in the database.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
