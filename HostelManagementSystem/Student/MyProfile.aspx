<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="MyProfile.aspx.cs" Inherits="HostelManagementSystem.Student.MyProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width: 1000px; margin: 2rem auto; padding: 0 1rem;">
        <h1 class="form-title" style="text-align: left; font-size: 2.2rem; margin-bottom: 2rem;">Manage <span>Profile</span></h1>

        <!-- Status Message Labels -->
        <asp:Label ID="lblProfileMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; margin-bottom: 1rem; display: block; font-weight: bold; text-align: center;"></asp:Label>

        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 2rem; align-items: start;">
            
            <!-- Left Side: Profile Details Edit -->
            <div class="glass-card" style="margin-bottom: 0;">
                <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-edit" style="color: var(--primary-color);"></i> Personal Details</h3>
                
                <div style="display: flex; gap: 2rem; align-items: center; margin-bottom: 2rem; flex-wrap: wrap;">
                    <div class="profile-avatar-container">
                        <asp:Image ID="imgAvatar" runat="server" CssClass="profile-avatar" ImageUrl="~/Images/default-avatar.png" />
                    </div>
                    <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                        <label class="form-label" style="margin-bottom: 0;">Upload Profile Picture</label>
                        <asp:FileUpload ID="fuProfilePicture" runat="server" CssClass="form-control-custom" style="padding: 0.4rem;" />
                        <span style="font-size: 0.75rem; color: var(--text-secondary);">Supported formats: JPG, PNG, GIF. Max size 2MB.</span>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="<%= txtProfileName.ClientID %>">Full Name</label>
                    <asp:TextBox ID="txtProfileName" runat="server" CssClass="form-control-custom"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtProfileName" ErrorMessage="Name is required." CssClass="validator-error" Display="Dynamic" ValidationGroup="ProfileGroup"></asp:RequiredFieldValidator>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                    <div class="form-group">
                        <label class="form-label">Email Address (Read-only)</label>
                        <asp:TextBox ID="txtProfileEmail" runat="server" CssClass="form-control-custom" ReadOnly="true" style="opacity: 0.7; cursor: not-allowed;"></asp:TextBox>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="<%= txtProfileDOB.ClientID %>">Date of Birth</label>
                        <asp:TextBox ID="txtProfileDOB" runat="server" TextMode="Date" CssClass="form-control-custom"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDOB" runat="server" ControlToValidate="txtProfileDOB" ErrorMessage="DOB is required." CssClass="validator-error" Display="Dynamic" ValidationGroup="ProfileGroup"></asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="<%= txtProfileMobile.ClientID %>">Mobile Number</label>
                    <asp:TextBox ID="txtProfileMobile" runat="server" CssClass="form-control-custom"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtProfileMobile" ErrorMessage="Mobile is required." CssClass="validator-error" Display="Dynamic" ValidationGroup="ProfileGroup"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtProfileMobile" ValidationExpression="^[0-9]{10}$" ErrorMessage="Must be 10-digit number." CssClass="validator-error" Display="Dynamic" ValidationGroup="ProfileGroup"></asp:RegularExpressionValidator>
                </div>

                <div class="form-group">
                    <label class="form-label" for="<%= txtProfileAddress.ClientID %>">Permanent Address</label>
                    <asp:TextBox ID="txtProfileAddress" runat="server" CssClass="form-control-custom" style="max-width: 100%;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtProfileAddress" ErrorMessage="Address is required." CssClass="validator-error" Display="Dynamic" ValidationGroup="ProfileGroup"></asp:RequiredFieldValidator>
                </div>

                <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 1rem;">
                    <div class="form-group">
                        <label class="form-label" for="<%= txtProfileCourse.ClientID %>">Course</label>
                        <asp:TextBox ID="txtProfileCourse" runat="server" CssClass="form-control-custom"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCourse" runat="server" ControlToValidate="txtProfileCourse" ErrorMessage="Course is required." CssClass="validator-error" Display="Dynamic" ValidationGroup="ProfileGroup"></asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="<%= txtProfileYear.ClientID %>">Year of Study</label>
                        <asp:TextBox ID="txtProfileYear" runat="server" TextMode="Number" CssClass="form-control-custom"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvYear" runat="server" ControlToValidate="txtProfileYear" ErrorMessage="Year is required." CssClass="validator-error" Display="Dynamic" ValidationGroup="ProfileGroup"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="rvYear" runat="server" ControlToValidate="txtProfileYear" MinimumValue="1" MaximumValue="5" Type="Integer" ErrorMessage="1-5 range." CssClass="validator-error" Display="Dynamic" ValidationGroup="ProfileGroup"></asp:RangeValidator>
                    </div>
                </div>

                <asp:Button ID="btnUpdateProfile" runat="server" Text="Save Details" OnClick="btnUpdateProfile_Click" CssClass="btn-custom btn-primary-custom" ValidationGroup="ProfileGroup" style="width: 100%; margin-top: 1rem;" />
            </div>

            <!-- Right Side: Change Password Card -->
            <div class="glass-card" style="margin-bottom: 0;">
                <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-lock" style="color: var(--primary-color);"></i> Change Password</h3>
                
                <div class="form-group">
                    <label class="form-label" for="<%= txtCurrentPassword.ClientID %>">Current Password</label>
                    <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="form-control-custom"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCurrPwd" runat="server" ControlToValidate="txtCurrentPassword" ErrorMessage="Required." CssClass="validator-error" Display="Dynamic" ValidationGroup="PasswordGroup"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label class="form-label" for="<%= txtNewPassword.ClientID %>">New Password</label>
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control-custom"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNewPwd" runat="server" ControlToValidate="txtNewPassword" ErrorMessage="Required." CssClass="validator-error" Display="Dynamic" ValidationGroup="PasswordGroup"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label class="form-label" for="<%= txtConfirmNewPassword.ClientID %>">Confirm New Password</label>
                    <asp:TextBox ID="txtConfirmNewPassword" runat="server" TextMode="Password" CssClass="form-control-custom"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvConfPwd" runat="server" ControlToValidate="txtConfirmNewPassword" ErrorMessage="Required." CssClass="validator-error" Display="Dynamic" ValidationGroup="PasswordGroup"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvNewPwd" runat="server" ControlToValidate="txtConfirmNewPassword" ControlToCompare="txtNewPassword" ErrorMessage="Mismatched passwords." CssClass="validator-error" Display="Dynamic" ValidationGroup="PasswordGroup"></asp:CompareValidator>
                </div>

                <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" OnClick="btnChangePassword_Click" CssClass="btn-custom btn-secondary-custom" ValidationGroup="PasswordGroup" style="width: 100%; margin-top: 1rem;" />
            </div>

        </div>
    </div>
</asp:Content>
