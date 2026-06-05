<%@ Page Title="Manage Students" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="ManageStudents.aspx.cs" Inherits="HostelManagementSystem.Admin.ManageStudents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="margin-bottom: 2rem; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
        <div>
            <h1 style="font-size: 2.2rem; font-weight: 700;">Student <span>Administration</span></h1>
            <p style="color: var(--text-secondary);">Manage registered student records, approve applications, or update details in real-time.</p>
        </div>
    </div>

    <!-- Status Message Label -->
    <asp:Label ID="lblStatusMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; display: block; font-weight: bold; margin-bottom: 1.5rem; text-align: center;"></asp:Label>

    <!-- Search & Filter Card -->
    <div class="glass-card" style="padding: 1.5rem; display: flex; gap: 1rem; align-items: end; flex-wrap: wrap; margin-bottom: 2rem;">
        <div class="form-group" style="margin-bottom: 0; flex-grow: 1;">
            <label class="form-label" for="<%= txtSearchName.ClientID %>">Search Student Name</label>
            <asp:TextBox ID="txtSearchName" runat="server" CssClass="form-control-custom" placeholder="Enter student name..."></asp:TextBox>
        </div>
        <div class="form-group" style="margin-bottom: 0; width: 200px;">
            <label class="form-label" for="<%= ddlFilterStatus.ClientID %>">Account Status</label>
            <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-control-custom">
                <asp:ListItem Value="">All Statuses</asp:ListItem>
                <asp:ListItem Value="Pending">Pending</asp:ListItem>
                <asp:ListItem Value="Approved">Approved</asp:ListItem>
                <asp:ListItem Value="Suspended">Suspended</asp:ListItem>
            </asp:DropDownList>
        </div>
        <asp:Button ID="btnSearchApply" runat="server" Text="Apply Filter" OnClick="btnSearchApply_Click" CssClass="btn-custom btn-primary-custom" style="padding: 0.75rem 1.5rem;" />
        <asp:Button ID="btnSearchReset" runat="server" Text="Reset" OnClick="btnSearchReset_Click" CssClass="btn-custom btn-secondary-custom" style="padding: 0.75rem 1.5rem;" />
    </div>

    <!-- Students GridView Container (Requirement: GridView) -->
    <div class="glass-card" style="margin-bottom: 0;">
        <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-list" style="color: var(--primary-color);"></i> Student Directory</h3>
        
        <div class="gridview-container" style="margin-bottom: 0;">
            <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" CssClass="custom-gridview" GridLines="None" 
                DataKeyNames="StudentID" 
                OnRowEditing="gvStudents_RowEditing" 
                OnRowCancelingEdit="gvStudents_RowCancelingEdit" 
                OnRowUpdating="gvStudents_RowUpdating" 
                OnRowDeleting="gvStudents_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="StudentID" HeaderText="ID" ReadOnly="True" />
                    
                    <asp:TemplateField HeaderText="Full Name">
                        <ItemTemplate>
                            <%# Eval("FullName") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditName" runat="server" Text='<%# Bind("FullName") %>' CssClass="form-control-custom" style="font-size:0.85rem; padding: 0.4rem;"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Email Address">
                        <ItemTemplate>
                            <%# Eval("Email") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditEmail" runat="server" Text='<%# Bind("Email") %>' CssClass="form-control-custom" style="font-size:0.85rem; padding: 0.4rem;"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Mobile">
                        <ItemTemplate>
                            <%# Eval("Mobile") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditMobile" runat="server" Text='<%# Bind("Mobile") %>' CssClass="form-control-custom" style="font-size:0.85rem; padding: 0.4rem;"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Course">
                        <ItemTemplate>
                            <%# Eval("Course") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditCourse" runat="server" Text='<%# Bind("Course") %>' CssClass="form-control-custom" style="font-size:0.85rem; padding: 0.4rem;"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Year">
                        <ItemTemplate>
                            <%# Eval("Year") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditYear" runat="server" Text='<%# Bind("Year") %>' TextMode="Number" CssClass="form-control-custom" style="font-size:0.85rem; padding: 0.4rem; width: 60px;"></asp:TextBox>
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
                                <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                <asp:ListItem Value="Approved">Approved</asp:ListItem>
                                <asp:ListItem Value="Suspended">Suspended</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn-custom btn-secondary-custom" style="padding: 0.25rem 0.6rem; font-size: 0.8rem; margin-right: 0.25rem;" CausesValidation="false"><i class="fas fa-edit"></i> Edit</asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn-custom btn-danger-custom" style="padding: 0.25rem 0.6rem; font-size: 0.8rem;" OnClientClick="return confirm('Are you sure you want to delete this student profile permanently?');" CausesValidation="false"><i class="fas fa-trash"></i> Delete</asp:LinkButton>
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
                        <h4>No Students Found</h4>
                        <p>No student profiles match your current search queries.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
