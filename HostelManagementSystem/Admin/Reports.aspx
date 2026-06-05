<%@ Page Title="System Reports" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="HostelManagementSystem.Admin.Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Printable invoice and report styles */
        @media print {
            body * {
                visibility: hidden;
            }
            .printable-area, .printable-area * {
                visibility: visible;
            }
            .printable-area {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                background: white !important;
                color: black !important;
                box-shadow: none !important;
                border: none !important;
            }
            .no-print {
                display: none !important;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="no-print" style="margin-bottom: 2rem; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
        <div>
            <h1 style="font-size: 2.2rem; font-weight: 700;">Hostel <span>Reports & Exports</span></h1>
            <p style="color: var(--text-secondary);">Generate financial ledger sheets, students statistics directories, and export to PDF/Print.</p>
        </div>
        <div>
            <button type="button" onclick="window.print();" class="btn-custom btn-primary-custom"><i class="fas fa-file-pdf"></i> Export to PDF / Print</button>
        </div>
    </div>

    <!-- Status Message Label -->
    <asp:Label ID="lblStatusMessage" runat="server" CssClass="validator-error" style="font-size: 0.95rem; display: block; font-weight: bold; margin-bottom: 1.5rem; text-align: center;"></asp:Label>

    <!-- Filters Sheet -->
    <div class="glass-card no-print" style="padding: 1.5rem; display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)) auto; gap: 1.5rem; align-items: end; margin-bottom: 2rem;">
        <div class="form-group" style="margin-bottom: 0;">
            <label class="form-label" for="<%= ddlReportType.ClientID %>">Report Category</label>
            <asp:DropDownList ID="ddlReportType" runat="server" CssClass="form-control-custom" AutoPostBack="True" OnSelectedIndexChanged="ddlReportType_SelectedIndexChanged">
                <asp:ListItem Value="Payments">Financial Fee Collection Ledger</asp:ListItem>
                <asp:ListItem Value="Students">Student Occupancy Directory</asp:ListItem>
                <asp:ListItem Value="Rooms">Room Allocation Status</asp:ListItem>
            </asp:DropDownList>
        </div>
        
        <div class="form-group" style="margin-bottom: 0;">
            <label class="form-label" for="<%= txtStartDate.ClientID %>">Start Date</label>
            <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date" CssClass="form-control-custom"></asp:TextBox>
        </div>

        <div class="form-group" style="margin-bottom: 0;">
            <label class="form-label" for="<%= txtEndDate.ClientID %>">End Date</label>
            <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date" CssClass="form-control-custom"></asp:TextBox>
        </div>

        <asp:Button ID="btnGenerateReport" runat="server" Text="Compile Report" OnClick="btnGenerateReport_Click" CssClass="btn-custom btn-secondary-custom" style="padding: 0.75rem 2rem;" />
    </div>

    <!-- Report Output Container -->
    <div class="glass-card printable-area" style="margin-bottom: 0;">
        <!-- Print Header -->
        <div style="border-bottom: 2px solid #000; padding-bottom: 1.5rem; margin-bottom: 2rem; display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h2 style="font-size: 1.8rem; font-weight: 700; color: #000;"><i class="fas fa-hotel"></i> Hostel Management System</h2>
                <p style="color: #666; font-size: 0.85rem; margin-top: 0.25rem;">Sector 12, Tech University Campus Hostel</p>
            </div>
            <div style="text-align: right;">
                <h4 style="text-transform: uppercase; color: #666; font-size: 0.85rem; letter-spacing: 0.05em;">Report Compile</h4>
                <p style="font-weight: 600; color: #000;"><asp:Label ID="lblReportTitle" runat="server" Text="Financial Ledger"></asp:Label></p>
                <p style="font-size: 0.75rem; color: #666; margin-top: 0.25rem;">Date: <%= DateTime.Now.ToString("dd MMM yyyy") %></p>
            </div>
        </div>

        <!-- Compiled Grid Results (Requirement: GridView) -->
        <div class="gridview-container" style="border: none; box-shadow: none;">
            <asp:GridView ID="gvReportOutput" runat="server" AutoGenerateColumns="True" CssClass="custom-gridview" GridLines="Horizontal" HeaderStyle-BackColor="#f3f4f6" HeaderStyle-ForeColor="#000" RowStyle-ForeColor="#000" style="color:#000 !important;">
                <EmptyDataTemplate>
                    <div style="padding: 3rem 1rem; text-align: center; color: #666;">
                        <div style="font-size: 3rem; margin-bottom: 1rem;"><i class="fas fa-file-alt"></i></div>
                        <h4>No Data Available</h4>
                        <p>No records match the selected report categories and date criteria.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>

        <!-- Summary Totals Block -->
        <asp:Panel ID="pnlSummaryTotal" runat="server" style="border-top: 1px solid #000; padding-top: 1.5rem; margin-top: 2rem; display: flex; justify-content: flex-end;">
            <div style="text-align: right; width: 300px;">
                <div style="display: flex; justify-content: space-between; font-size: 0.95rem; margin-bottom: 0.5rem; color: #666;">
                    <span>Total Record Count:</span>
                    <strong style="color: #000;"><asp:Label ID="lblRecordCount" runat="server" Text="0"></asp:Label></strong>
                </div>
                <div style="display: flex; justify-content: space-between; font-size: 1.15rem; border-top: 1px dashed #ccc; padding-top: 0.5rem; color: #000;">
                    <span>Summary Value:</span>
                    <strong><asp:Label ID="lblSummaryValue" runat="server" Text="-"></asp:Label></strong>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
