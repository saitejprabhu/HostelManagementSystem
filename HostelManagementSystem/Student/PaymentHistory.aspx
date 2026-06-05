<%@ Page Title="Payment History" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="PaymentHistory.aspx.cs" Inherits="HostelManagementSystem.Student.PaymentHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width: 1000px; margin: 2rem auto; padding: 0 1rem;">
        
        <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; margin-bottom: 2rem; gap: 1rem;">
            <div>
                <h1 class="form-title" style="text-align: left; font-size: 2.2rem; margin-bottom: 0.25rem;">Payment <span>History</span></h1>
                <p style="color: var(--text-secondary);">Review your past transactions and invoice submissions.</p>
            </div>
            <div>
                <a href='<%= Page.ResolveUrl("~/Student/Payment") %>' class="btn-custom btn-primary-custom"><i class="fas fa-plus"></i> New Payment</a>
            </div>
        </div>

        <asp:Label ID="lblStatusMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; margin-bottom: 1.5rem; display: block; font-weight: bold; text-align: center;"></asp:Label>

        <!-- Payment History GridView -->
        <asp:Panel ID="pnlHistory" runat="server">
            <div class="gridview-container">
                <asp:GridView ID="gvPaymentHistory" runat="server" AutoGenerateColumns="False" CssClass="custom-gridview" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="PaymentID" HeaderText="Receipt ID" />
                        <asp:TemplateField HeaderText="Amount Paid">
                            <ItemTemplate>
                                <strong>Rs. <%# Convert.ToDecimal(Eval("Amount")).ToString("N2") %></strong>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Payment Date">
                            <ItemTemplate>
                                <%# Convert.ToDateTime(Eval("PaymentDate")).ToString("dd MMM yyyy hh:mm tt") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="PaymentMethod" HeaderText="Method" />
                        <asp:BoundField DataField="TransactionID" HeaderText="Transaction ID" />
                        <asp:TemplateField HeaderText="Verification Status">
                            <ItemTemplate>
                                <span class="badge-custom <%# GetStatusBadgeClass(Eval("Status").ToString()) %>">
                                    <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div style="padding: 3rem 1rem; text-align: center; color: var(--text-secondary);">
                            <div style="font-size: 3rem; margin-bottom: 1rem;"><i class="fas fa-folder-open"></i></div>
                            <h4>No Payment Records Found</h4>
                            <p>You have not made any fee transactions yet.</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </asp:Panel>

    </div>
</asp:Content>
