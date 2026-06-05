<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="HostelManagementSystem.Pages.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width: 900px; margin: 4rem auto; padding: 0 1rem; display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
        
        <!-- Contact Information Card -->
        <div>
            <h1 class="form-title" style="text-align: left; font-size: 2.5rem; margin-bottom: 1rem;">Contact <span>Us</span></h1>
            <p style="color: var(--text-secondary); margin-bottom: 2rem;">Have any questions or concerns? Feel free to reach out to the hostel administration team.</p>
            
            <div class="glass-card" style="display: flex; flex-direction: column; gap: 1.5rem; margin-bottom: 0;">
                <div style="display: flex; gap: 1rem; align-items: center;">
                    <div style="font-size: 1.5rem; color: var(--primary-color); width: 40px;"><i class="fas fa-map-marker-alt"></i></div>
                    <div>
                        <h4 style="font-size: 0.95rem; text-transform: uppercase; color: var(--text-secondary);">Address</h4>
                        <p style="font-weight: 500;">Premium Campus Hostel, Sector 12, Tech University</p>
                    </div>
                </div>
                
                <div style="display: flex; gap: 1rem; align-items: center;">
                    <div style="font-size: 1.5rem; color: var(--primary-color); width: 40px;"><i class="fas fa-phone-alt"></i></div>
                    <div>
                        <h4 style="font-size: 0.95rem; text-transform: uppercase; color: var(--text-secondary);">Phone Helpline</h4>
                        <p style="font-weight: 500;">+91 98765 43210 (Warden Office)</p>
                    </div>
                </div>

                <div style="display: flex; gap: 1rem; align-items: center;">
                    <div style="font-size: 1.5rem; color: var(--primary-color); width: 40px;"><i class="fas fa-envelope"></i></div>
                    <div>
                        <h4 style="font-size: 0.95rem; text-transform: uppercase; color: var(--text-secondary);">Email</h4>
                        <p style="font-weight: 500;">hostel.warden@techuniv.edu</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Contact Form Card -->
        <div class="glass-card" style="margin-bottom: 0;">
            <h3 style="margin-bottom: 1.5rem;">Send a Message</h3>
            
            <!-- Validation Summary -->
            <asp:ValidationSummary ID="ContactValidationSummary" runat="server" CssClass="validation-summary-errors" HeaderText="Please correct the following errors:" DisplayMode="BulletList" />

            <div class="form-group">
                <label class="form-label" for="<%= txtContactName.ClientID %>">Full Name</label>
                <asp:TextBox ID="txtContactName" runat="server" CssClass="form-control-custom" placeholder="Enter your full name"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtContactName" ErrorMessage="Full Name is required." CssClass="validator-error" Display="Dynamic">*</asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label class="form-label" for="<%= txtContactEmail.ClientID %>">Email Address</label>
                <asp:TextBox ID="txtContactEmail" runat="server" CssClass="form-control-custom" placeholder="Enter your email address"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtContactEmail" ErrorMessage="Email Address is required." CssClass="validator-error" Display="Dynamic">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtContactEmail" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ErrorMessage="Invalid Email Address format." CssClass="validator-error" Display="Dynamic">*</asp:RegularExpressionValidator>
            </div>

            <div class="form-group">
                <label class="form-label" for="<%= txtContactSubject.ClientID %>">Subject</label>
                <asp:TextBox ID="txtContactSubject" runat="server" CssClass="form-control-custom" placeholder="Enter message subject"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="txtContactSubject" ErrorMessage="Subject is required." CssClass="validator-error" Display="Dynamic">*</asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label class="form-label" for="<%= txtContactMessage.ClientID %>">Message</label>
                <asp:TextBox ID="txtContactMessage" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control-custom" placeholder="Enter your message details" style="max-width: 100%;"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtContactMessage" ErrorMessage="Message is required." CssClass="validator-error" Display="Dynamic">*</asp:RequiredFieldValidator>
            </div>

            <asp:Button ID="btnContactSubmit" runat="server" Text="Send Message" OnClick="btnContactSubmit_Click" CssClass="btn-custom btn-primary-custom" style="width: 100%;" />
        </div>
    </div>
</asp:Content>
