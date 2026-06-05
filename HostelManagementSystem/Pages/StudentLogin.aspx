<%@ Page Title="Student Login" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="StudentLogin.aspx.cs" Inherits="HostelManagementSystem.Pages.StudentLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-container glass-card">
        <h1 class="form-title">Student <span>Login</span></h1>
        
        <!-- Status Notification Label -->
        <asp:Label ID="lblStatusMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; margin-bottom: 1.5rem; display: block; text-align: center; font-weight: bold;"></asp:Label>

        <!-- Validation Summary -->
        <asp:ValidationSummary ID="LoginValidationSummary" runat="server" CssClass="validation-summary-errors" HeaderText="Please correct the following errors:" />

        <!-- Form fields -->
        <div class="form-group">
            <label class="form-label" for="<%= txtLoginEmail.ClientID %>">Email Address</label>
            <asp:TextBox ID="txtLoginEmail" runat="server" CssClass="form-control-custom" placeholder="Enter your email"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtLoginEmail" ErrorMessage="Email is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtLoginEmail" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ErrorMessage="Invalid Email format." CssClass="validator-error" Display="Dynamic"></asp:RegularExpressionValidator>
        </div>

        <div class="form-group">
            <label class="form-label" for="<%= txtLoginPassword.ClientID %>">Password</label>
            <asp:TextBox ID="txtLoginPassword" runat="server" TextMode="Password" CssClass="form-control-custom" placeholder="Enter your password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtLoginPassword" ErrorMessage="Password is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
            <label style="display: flex; align-items: center; gap: 0.5rem; font-size: 0.9rem; cursor: pointer;">
                <asp:CheckBox ID="chkRememberMe" runat="server" /> Remember Me
            </label>
            <asp:LinkButton ID="btnForgotPassword" runat="server" OnClick="btnForgotPassword_Click" CausesValidation="false" style="color: var(--primary-color); font-size: 0.9rem; font-weight: 500; text-decoration: none;">Forgot Password?</asp:LinkButton>
        </div>

        <asp:Button ID="btnLoginSubmit" runat="server" Text="Login" OnClick="btnLoginSubmit_Click" CssClass="btn-custom btn-primary-custom" style="width: 100%;" />

        <div style="text-align: center; margin-top: 1.5rem; font-size: 0.9rem;">
            Don't have an account? <a href='<%= Page.ResolveUrl("~/Pages/StudentRegistration") %>' style="color: var(--primary-color); font-weight: 600; text-decoration: none;">Register Here</a>
        </div>
    </div>
</asp:Content>
