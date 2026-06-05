<%@ Page Title="Student Registration" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="StudentRegistration.aspx.cs" Inherits="HostelManagementSystem.Pages.StudentRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-container glass-card">
        <h1 class="form-title">Student <span>Registration</span></h1>
        
        <!-- Status Notification Label -->
        <asp:Label ID="lblStatusMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; margin-bottom: 1.5rem; display: block; text-align: center; font-weight: bold;"></asp:Label>

        <!-- Validation Summary -->
        <asp:ValidationSummary ID="RegisterValidationSummary" runat="server" CssClass="validation-summary-errors" HeaderText="Please correct the following errors:" />

        <!-- Form fields -->
        <div class="form-group">
            <label class="form-label" for="<%= txtRegisterName.ClientID %>">Full Name</label>
            <asp:TextBox ID="txtRegisterName" runat="server" CssClass="form-control-custom" placeholder="Enter your full name"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtRegisterName" ErrorMessage="Full Name is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
            <div class="form-group">
                <label class="form-label" for="<%= ddlRegisterGender.ClientID %>">Gender</label>
                <asp:DropDownList ID="ddlRegisterGender" runat="server" CssClass="form-control-custom">
                    <asp:ListItem Value="Male">Male</asp:ListItem>
                    <asp:ListItem Value="Female">Female</asp:ListItem>
                    <asp:ListItem Value="Other">Other</asp:ListItem>
                </asp:DropDownList>
            </div>
            
            <div class="form-group">
                <label class="form-label" for="<%= txtRegisterDOB.ClientID %>">Date of Birth</label>
                <asp:TextBox ID="txtRegisterDOB" runat="server" TextMode="Date" CssClass="form-control-custom"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDOB" runat="server" ControlToValidate="txtRegisterDOB" ErrorMessage="Date of Birth is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="form-group">
            <label class="form-label" for="<%= txtRegisterEmail.ClientID %>">Email Address</label>
            <asp:TextBox ID="txtRegisterEmail" runat="server" CssClass="form-control-custom" placeholder="username@domain.com"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtRegisterEmail" ErrorMessage="Email is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtRegisterEmail" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ErrorMessage="Invalid Email Address format." CssClass="validator-error" Display="Dynamic"></asp:RegularExpressionValidator>
        </div>

        <div class="form-group">
            <label class="form-label" for="<%= txtRegisterMobile.ClientID %>">Mobile Number</label>
            <asp:TextBox ID="txtRegisterMobile" runat="server" CssClass="form-control-custom" placeholder="10-digit mobile number"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtRegisterMobile" ErrorMessage="Mobile number is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtRegisterMobile" ValidationExpression="^[0-9]{10}$" ErrorMessage="Mobile number must be exactly 10 digits." CssClass="validator-error" Display="Dynamic"></asp:RegularExpressionValidator>
        </div>

        <div class="form-group">
            <label class="form-label" for="<%= txtRegisterAddress.ClientID %>">Permanent Address</label>
            <asp:TextBox ID="txtRegisterAddress" runat="server" CssClass="form-control-custom" placeholder="Street, City, State, ZIP" style="max-width: 100%;"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtRegisterAddress" ErrorMessage="Address is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 1rem;">
            <div class="form-group">
                <label class="form-label" for="<%= txtRegisterCourse.ClientID %>">Course Name</label>
                <asp:TextBox ID="txtRegisterCourse" runat="server" CssClass="form-control-custom" placeholder="e.g., B.Tech CSE"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCourse" runat="server" ControlToValidate="txtRegisterCourse" ErrorMessage="Course name is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <label class="form-label" for="<%= txtRegisterYear.ClientID %>">Year of Study</label>
                <asp:TextBox ID="txtRegisterYear" runat="server" TextMode="Number" CssClass="form-control-custom" placeholder="e.g., 1"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvYear" runat="server" ControlToValidate="txtRegisterYear" ErrorMessage="Year is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RangeValidator ID="rvYear" runat="server" ControlToValidate="txtRegisterYear" MinimumValue="1" MaximumValue="5" Type="Integer" ErrorMessage="Year must be between 1 and 5." CssClass="validator-error" Display="Dynamic"></asp:RangeValidator>
            </div>
        </div>

        <div class="form-group">
            <label class="form-label" for="<%= txtRegisterPassword.ClientID %>">Password</label>
            <asp:TextBox ID="txtRegisterPassword" runat="server" TextMode="Password" CssClass="form-control-custom" placeholder="Create a secure password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtRegisterPassword" ErrorMessage="Password is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label class="form-label" for="<%= txtRegisterConfirmPassword.ClientID %>">Confirm Password</label>
            <asp:TextBox ID="txtRegisterConfirmPassword" runat="server" TextMode="Password" CssClass="form-control-custom" placeholder="Re-enter password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtRegisterConfirmPassword" ErrorMessage="Please confirm your password." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtRegisterConfirmPassword" ControlToCompare="txtRegisterPassword" ErrorMessage="Passwords do not match." CssClass="validator-error" Display="Dynamic"></asp:CompareValidator>
        </div>

        <asp:Button ID="btnRegisterSubmit" runat="server" Text="Register" OnClick="btnRegisterSubmit_Click" CssClass="btn-custom btn-primary-custom" style="width: 100%; margin-top: 1rem;" />

        <div style="text-align: center; margin-top: 1.5rem; font-size: 0.9rem;">
            Already registered? <a href='<%= Page.ResolveUrl("~/Pages/StudentLogin") %>' style="color: var(--primary-color); font-weight: 600; text-decoration: none;">Login Here</a>
        </div>
    </div>
</asp:Content>
