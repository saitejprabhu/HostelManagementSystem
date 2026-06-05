<%@ Page Title="Admin Login" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="HostelManagementSystem.Admin.AdminLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-container glass-card" style="border-top: 4px solid var(--accent-color);">
        <div style="text-align: center; margin-bottom: 2rem;">
            <span style="font-size: 3rem; color: var(--accent-color);"><i class="fas fa-user-shield"></i></span>
            <h1 class="form-title" style="margin-top: 1rem; margin-bottom: 0.25rem;">Warden <span>Portal</span></h1>
            <p style="color: var(--text-secondary); font-size: 0.9rem;">Sign in to access student allocations, rooms database, and complaints control board.</p>
        </div>
        
        <!-- Status Notification Label -->
        <asp:Label ID="lblStatusMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; margin-bottom: 1.5rem; display: block; text-align: center; font-weight: bold;"></asp:Label>

        <!-- Validation Summary -->
        <asp:ValidationSummary ID="AdminLoginValidationSummary" runat="server" CssClass="validation-summary-errors" HeaderText="Please correct the following errors:" />

        <!-- Form fields -->
        <div class="form-group">
            <label class="form-label" for="<%= txtAdminUsername.ClientID %>">Username</label>
            <asp:TextBox ID="txtAdminUsername" runat="server" CssClass="form-control-custom" placeholder="Warden username"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtAdminUsername" ErrorMessage="Username is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label class="form-label" for="<%= txtAdminPassword.ClientID %>">Password</label>
            <asp:TextBox ID="txtAdminPassword" runat="server" TextMode="Password" CssClass="form-control-custom" placeholder="Security key password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtAdminPassword" ErrorMessage="Password is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <asp:Button ID="btnAdminLoginSubmit" runat="server" Text="Sign In" OnClick="btnAdminLoginSubmit_Click" CssClass="btn-custom btn-primary-custom" style="background: var(--accent-color); color: #000; width: 100%; font-weight: 700; margin-top: 1rem;" />
    </div>
</asp:Content>
