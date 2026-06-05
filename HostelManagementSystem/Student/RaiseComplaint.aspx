<%@ Page Title="Raise Complaint" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="RaiseComplaint.aspx.cs" Inherits="HostelManagementSystem.Student.RaiseComplaint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width: 800px; margin: 2rem auto; padding: 0 1rem;">
        
        <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; margin-bottom: 2rem; gap: 1rem;">
            <div>
                <h1 class="form-title" style="text-align: left; font-size: 2.2rem; margin-bottom: 0.25rem;">Raise a <span>Grievance</span></h1>
                <p style="color: var(--text-secondary);">Submit tickets for issues regarding mess, cleaning, internet, or room assets.</p>
            </div>
            <div>
                <a href='<%= Page.ResolveUrl("~/Student/ComplaintHistory") %>' class="btn-custom btn-secondary-custom"><i class="fas fa-list"></i> Ticket History</a>
            </div>
        </div>

        <asp:Label ID="lblStatusMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; margin-bottom: 1.5rem; display: block; font-weight: bold; text-align: center;"></asp:Label>

        <!-- Complaint Submission Card -->
        <div class="glass-card" style="margin-bottom: 0;">
            <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-ticket-alt" style="color: var(--primary-color);"></i> New Ticket details</h3>

            <!-- Validation Summary -->
            <asp:ValidationSummary ID="ComplaintValidationSummary" runat="server" CssClass="validation-summary-errors" HeaderText="Please correct the following errors:" />

            <div class="form-group">
                <label class="form-label" for="<%= txtComplaintSubject.ClientID %>">Grievance Subject</label>
                <asp:TextBox ID="txtComplaintSubject" runat="server" CssClass="form-control-custom" placeholder="e.g. WiFi issue in A-Block floor 2"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="txtComplaintSubject" ErrorMessage="Grievance Subject is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label class="form-label" for="<%= txtComplaintDesc.ClientID %>">Detailed Description</label>
                <asp:TextBox ID="txtComplaintDesc" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control-custom" placeholder="Describe the issue in detail so that the maintenance team can resolve it efficiently." style="max-width: 100%;"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDesc" runat="server" ControlToValidate="txtComplaintDesc" ErrorMessage="Complaint Description is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div style="background: rgba(79, 70, 229, 0.05); border: 1px solid var(--glass-border); border-radius: 12px; padding: 1.25rem; display: flex; gap: 1rem; align-items: flex-start; margin-bottom: 2rem;">
                <div style="font-size: 1.5rem; color: var(--primary-color);"><i class="fas fa-clock"></i></div>
                <div>
                    <h4 style="font-size: 0.9rem; font-weight: 600;">Resolution Timeline</h4>
                    <p style="font-size: 0.8rem; color: var(--text-secondary); margin-top: 0.25rem;">
                        Standard issues are addressed within 24-48 working hours.
                        You will receive an update in the Warden replies and can monitor the ticket status in your Ticket History.
                    </p>
                </div>
            </div>

            <asp:Button ID="btnSubmitComplaint" runat="server" Text="Submit Grievance Ticket" OnClick="btnSubmitComplaint_Click" CssClass="btn-custom btn-primary-custom" style="width: 100%;" />
        </div>

    </div>
</asp:Content>
