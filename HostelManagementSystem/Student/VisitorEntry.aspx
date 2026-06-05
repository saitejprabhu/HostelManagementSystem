<%@ Page Title="Visitor Registry" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="VisitorEntry.aspx.cs" Inherits="HostelManagementSystem.Student.VisitorEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width: 1000px; margin: 2rem auto; padding: 0 1rem;">
        
        <div style="margin-bottom: 2rem;">
            <h1 class="form-title" style="text-align: left; font-size: 2.2rem; margin-bottom: 0.25rem;">Visitor <span>Registry</span></h1>
            <p style="color: var(--text-secondary);">Log guest visits and maintain institutional security compliance records.</p>
        </div>

        <asp:Label ID="lblStatusMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; margin-bottom: 1.5rem; display: block; font-weight: bold; text-align: center;"></asp:Label>

        <div style="display: grid; grid-template-columns: 1.2fr 2fr; gap: 2rem; align-items: start;">
            
            <!-- Visitor Log Form Card -->
            <div class="glass-card" style="margin-bottom: 0;">
                <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-user-plus" style="color: var(--primary-color);"></i> Log Guest Entry</h3>
                
                <!-- Validation Summary -->
                <asp:ValidationSummary ID="VisitorValidationSummary" runat="server" CssClass="validation-summary-errors" HeaderText="Please correct the following errors:" />

                <div class="form-group">
                    <label class="form-label" for="<%= txtVisitorName.ClientID %>">Visitor Full Name</label>
                    <asp:TextBox ID="txtVisitorName" runat="server" CssClass="form-control-custom" placeholder="e.g. John Doe"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtVisitorName" ErrorMessage="Visitor Name is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label class="form-label" for="<%= txtRelationship.ClientID %>">Relationship</label>
                    <asp:TextBox ID="txtRelationship" runat="server" CssClass="form-control-custom" placeholder="e.g. Father, Friend, Uncle"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvRelation" runat="server" ControlToValidate="txtRelationship" ErrorMessage="Relationship is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label class="form-label" for="<%= txtVisitDate.ClientID %>">Visit Date</label>
                    <asp:TextBox ID="txtVisitDate" runat="server" TextMode="Date" CssClass="form-control-custom"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="txtVisitDate" ErrorMessage="Visit Date is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label class="form-label" for="<%= txtCheckInTime.ClientID %>">Check-In Time</label>
                    <asp:TextBox ID="txtCheckInTime" runat="server" TextMode="Time" CssClass="form-control-custom"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTime" runat="server" ControlToValidate="txtCheckInTime" ErrorMessage="Check-In Time is required." CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <asp:Button ID="btnSubmitVisitor" runat="server" Text="Log Visitor" OnClick="btnSubmitVisitor_Click" CssClass="btn-custom btn-primary-custom" style="width: 100%; margin-top: 1rem;" />
            </div>

            <!-- Visitor Logs History Card -->
            <div class="glass-card" style="margin-bottom: 0;">
                <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-history" style="color: var(--primary-color);"></i> Guest History</h3>
                
                <div class="gridview-container">
                    <asp:GridView ID="gvVisitorLogs" runat="server" AutoGenerateColumns="False" CssClass="custom-gridview" GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="VisitorName" HeaderText="Guest Name" />
                            <asp:BoundField DataField="Relationship" HeaderText="Relation" />
                            <asp:TemplateField HeaderText="Visit Date">
                                <ItemTemplate>
                                    <%# Convert.ToDateTime(Eval("VisitDate")).ToString("dd MMM yyyy") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Check-In">
                                <ItemTemplate>
                                    <%# Eval("CheckInTime") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Check-Out">
                                <ItemTemplate>
                                    <%# Eval("CheckOutTime") == DBNull.Value || string.IsNullOrEmpty(Eval("CheckOutTime").ToString()) ? "<span style='font-style:italic;color:var(--warning-color);'>Still In</span>" : Eval("CheckOutTime") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div style="padding: 2rem 1rem; text-align: center; color: var(--text-secondary);">
                                <h4>No Registered Guests</h4>
                                <p>You have not logged any visitor entries yet.</p>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
