<%@ Page Title="Verify Payments" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="ManagePayments.aspx.cs" Inherits="HostelManagementSystem.Admin.ManagePayments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="margin-bottom: 2rem;">
        <h1 style="font-size: 2.2rem; font-weight: 700;">Fee Payment <span>Verification</span></h1>
        <p style="color: var(--text-secondary);">Verify transaction details and approve or reject student fee invoices.</p>
    </div>

    <!-- Status Message Label -->
    <asp:Label ID="lblStatusMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; display: block; font-weight: bold; margin-bottom: 1.5rem; text-align: center;"></asp:Label>

    <!-- Payment List (Requirement: GridView) -->
    <div class="glass-card" style="margin-bottom: 0;">
        <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-wallet" style="color: var(--primary-color);"></i> Invoice Submissions</h3>
        
        <div class="gridview-container" style="margin-bottom: 0;">
            <asp:GridView ID="gvManagePayments" runat="server" AutoGenerateColumns="False" CssClass="custom-gridview" GridLines="None"
                DataKeyNames="PaymentID"
                OnRowCommand="gvManagePayments_RowCommand">
                <Columns>
                    <asp:BoundField DataField="PaymentID" HeaderText="Receipt ID" />
                    <asp:BoundField DataField="FullName" HeaderText="Student" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:TemplateField HeaderText="Amount Paid">
                        <ItemTemplate>
                            <strong>Rs. <%# Convert.ToDecimal(Eval("Amount")).ToString("N2") %></strong>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Submission Date">
                        <ItemTemplate>
                            <%# Convert.ToDateTime(Eval("PaymentDate")).ToString("dd MMM yyyy hh:mm tt") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="PaymentMethod" HeaderText="Method" />
                    <asp:BoundField DataField="TransactionID" HeaderText="Transaction ID" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class="badge-custom <%# GetStatusBadgeClass(Eval("Status").ToString()) %>">
                                <%# Eval("Status") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnApprove" runat="server" CommandName="VerifyPayment" CommandArgument="<%# Container.DataItemIndex %>" CssClass="btn-custom btn-success-custom" style="padding: 0.3rem 0.8rem; font-size: 0.8rem; color: white; margin-right: 0.5rem;" Visible='<%# Eval("Status").ToString() == "Pending" %>'><i class="fas fa-check"></i> Verify</asp:LinkButton>
                            <asp:LinkButton ID="btnReject" runat="server" CommandName="RejectPayment" CommandArgument="<%# Container.DataItemIndex %>" CssClass="btn-custom btn-danger-custom" style="padding: 0.3rem 0.8rem; font-size: 0.8rem;" Visible='<%# Eval("Status").ToString() == "Pending" %>' OnClientClick="return confirm('Are you sure you want to mark this payment as Failed?');"><i class="fas fa-times"></i> Reject</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div style="padding: 3rem 1rem; text-align: center; color: var(--text-secondary);">
                        <div style="font-size: 3rem; margin-bottom: 1rem;"><i class="fas fa-folder-open"></i></div>
                        <h4>No Invoice Submissions</h4>
                        <p>There are no fee records submitted for verification.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
