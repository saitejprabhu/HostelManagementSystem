<%@ Page Title="Grievance Tickets" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="ComplaintHistory.aspx.cs" Inherits="HostelManagementSystem.Student.ComplaintHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width: 1000px; margin: 2rem auto; padding: 0 1rem;">
        
        <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; margin-bottom: 2rem; gap: 1rem;">
            <div>
                <h1 class="form-title" style="text-align: left; font-size: 2.2rem; margin-bottom: 0.25rem;">Grievance <span>Tickets Log</span></h1>
                <p style="color: var(--text-secondary);">Track status updates and read responses from the hostel admin.</p>
            </div>
            <div>
                <a href='<%= Page.ResolveUrl("~/Student/RaiseComplaint") %>' class="btn-custom btn-primary-custom"><i class="fas fa-plus"></i> Submit Ticket</a>
            </div>
        </div>

        <asp:Label ID="lblStatusMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; margin-bottom: 1.5rem; display: block; font-weight: bold; text-align: center;"></asp:Label>

        <!-- Complaints GridView -->
        <asp:Panel ID="pnlHistory" runat="server">
            <div class="gridview-container">
                <asp:GridView ID="gvComplaints" runat="server" AutoGenerateColumns="False" CssClass="custom-gridview" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="ComplaintID" HeaderText="Ticket ID" />
                        <asp:BoundField DataField="Subject" HeaderText="Subject" />
                        <asp:TemplateField HeaderText="Date Submitted">
                            <ItemTemplate>
                                <%# Convert.ToDateTime(Eval("ComplaintDate")).ToString("dd MMM yyyy hh:mm tt") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ticket Status">
                            <ItemTemplate>
                                <span class="badge-custom <%# GetStatusBadgeClass(Eval("Status").ToString()) %>">
                                    <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Warden's Response">
                            <ItemTemplate>
                                <span style="font-style: italic; color: var(--text-secondary);">
                                    <%# Eval("Response") == DBNull.Value || string.IsNullOrEmpty(Eval("Response").ToString()) ? "No response yet." : Eval("Response") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div style="padding: 3rem 1rem; text-align: center; color: var(--text-secondary);">
                            <div style="font-size: 3rem; margin-bottom: 1rem;"><i class="fas fa-folder-open"></i></div>
                            <h4>No Grievance Tickets Found</h4>
                            <p>You have not logged any complaints yet.</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </asp:Panel>

    </div>
</asp:Content>
