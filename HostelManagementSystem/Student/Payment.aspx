<%@ Page Title="Fee Payment" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="HostelManagementSystem.Student.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width: 800px; margin: 2rem auto; padding: 0 1rem;">
        
        <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; margin-bottom: 2rem; gap: 1rem;">
            <div>
                <h1 class="form-title" style="text-align: left; font-size: 2.2rem; margin-bottom: 0.25rem;">Hostel Fee <span>Payment</span></h1>
                <p style="color: var(--text-secondary);">Clear your outstanding monthly room rent securely.</p>
            </div>
            <div>
                <a href='<%= Page.ResolveUrl("~/Student/PaymentHistory") %>' class="btn-custom btn-secondary-custom"><i class="fas fa-history"></i> Payment History</a>
            </div>
        </div>

        <asp:Label ID="lblStatusMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; margin-bottom: 1.5rem; display: block; font-weight: bold; text-align: center;"></asp:Label>

        <!-- Blocked if no active room allocation -->
        <asp:Panel ID="pnlNoAllocation" runat="server" CssClass="glass-card text-center" style="padding: 3rem 2rem;">
            <div style="font-size: 4rem; color: var(--text-secondary); margin-bottom: 1.5rem;"><i class="fas fa-exclamation-triangle"></i></div>
            <h3>Fee Payment Blocked</h3>
            <p style="color: var(--text-secondary); margin-top: 0.5rem; margin-bottom: 2rem;">You do not have an active room allocation. Payments can only be processed after you are assigned a room by the hostel warden.</p>
            <a href='<%= Page.ResolveUrl("~/Student/ApplyRoom") %>' class="btn-custom btn-primary-custom">Apply for Room</a>
        </asp:Panel>

        <!-- Payment Processing form -->
        <asp:Panel ID="pnlPaymentForm" runat="server" CssClass="glass-card" Visible="false">
            <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-cash-register" style="color: var(--primary-color);"></i> Invoice Details</h3>
            
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; border-bottom: 1px solid var(--glass-border); padding-bottom: 1.5rem; margin-bottom: 2rem;">
                <div>
                    <h4 style="font-size: 0.85rem; text-transform: uppercase; color: var(--text-secondary);">Allocated Room</h4>
                    <p style="font-size: 1.25rem; font-weight: 700; margin-top: 0.25rem; color: var(--text-primary);">
                        <asp:Label ID="lblRoomDetails" runat="server"></asp:Label>
                    </p>
                </div>
                
                <div>
                    <h4 style="font-size: 0.85rem; text-transform: uppercase; color: var(--text-secondary);">Amount Due</h4>
                    <p style="font-size: 1.25rem; font-weight: 700; margin-top: 0.25rem; color: var(--primary-color);">
                        Rs. <asp:Label ID="lblAmountDue" runat="server"></asp:Label>
                    </p>
                </div>
            </div>

            <!-- Validation Summary -->
            <asp:ValidationSummary ID="PaymentValidationSummary" runat="server" CssClass="validation-summary-errors" HeaderText="Please correct the following errors:" />

            <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-credit-card" style="color: var(--primary-color);"></i> Payment Method</h3>

            <div class="form-group">
                <label class="form-label" for="<%= ddlPaymentMethod.ClientID %>">Choose Method</label>
                <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="form-control-custom">
                    <asp:ListItem Value="UPI">UPI (Google Pay, PhonePe, Paytm)</asp:ListItem>
                    <asp:ListItem Value="Debit Card">Debit Card</asp:ListItem>
                    <asp:ListItem Value="Credit Card">Credit Card</asp:ListItem>
                    <asp:ListItem Value="Net Banking">Net Banking</asp:ListItem>
                    <asp:ListItem Value="Cash">Cash Deposit at Warden Office</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label class="form-label" for="<%= txtTransactionID.ClientID %>">Transaction ID / Reference Number</label>
                <asp:TextBox ID="txtTransactionID" runat="server" CssClass="form-control-custom" placeholder="e.g. TXN9876543210"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTxn" runat="server" ControlToValidate="txtTransactionID" ErrorMessage="Transaction Reference ID is required for verification." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div style="background: rgba(245, 158, 11, 0.05); border: 1px solid rgba(245, 158, 11, 0.3); border-radius: 12px; padding: 1.25rem; display: flex; gap: 1rem; align-items: flex-start; margin-bottom: 2rem;">
                <div style="font-size: 1.5rem; color: var(--warning-color);"><i class="fas fa-exclamation-circle"></i></div>
                <div>
                    <h4 style="font-size: 0.9rem; font-weight: 600; color: var(--warning-color);">Important Instructions</h4>
                    <p style="font-size: 0.8rem; color: var(--text-secondary); margin-top: 0.25rem;">
                        Make the payment to our official bank account or UPI address, then input the reference ID.
                        The Warden team will cross-verify this Transaction ID with bank statements before approving the receipt status.
                    </p>
                </div>
            </div>

            <asp:Button ID="btnProcessPayment" runat="server" Text="Submit Payment Record" OnClick="btnProcessPayment_Click" CssClass="btn-custom btn-primary-custom" style="width: 100%;" />
        </asp:Panel>

    </div>
</asp:Content>
