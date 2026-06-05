<%@ Page Title="About Us" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="HostelManagementSystem.Pages.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width: 900px; margin: 4rem auto; padding: 0 1rem;">
        <h1 class="form-title" style="text-align: left; font-size: 2.5rem; margin-bottom: 1rem;">About Our <span>Hostel</span></h1>
        <p style="color: var(--text-secondary); margin-bottom: 2rem; font-size: 1.1rem;">Empowering residents with a premium and supportive residential ecosystem.</p>

        <div class="glass-card">
            <h3>Our Mission</h3>
            <p style="color: var(--text-secondary); margin-top: 0.5rem; margin-bottom: 1.5rem;">
                Our mission is to offer premium, safe, hygienic, and affordable living environments for university students. We combine robust physical infrastructure with smart administrative tools, ensuring that students can focus entirely on their academic achievements while enjoying a warm, community-driven residence.
            </p>
            
            <h3>Hostel Code of Conduct</h3>
            <p style="color: var(--text-secondary); margin-top: 0.5rem; margin-bottom: 1rem;">
                To maintain harmony, safety, and decorum within the hostel campus, all residents are strictly required to adhere to the following rules:
            </p>
            <ul style="margin-left: 1.5rem; margin-bottom: 1.5rem; color: var(--text-secondary); display: flex; flex-direction: column; gap: 0.5rem;">
                <li><strong>Gate Timings:</strong> Residents must enter the hostel premises before 9:00 PM. Prior written approval from the Warden is required for late entries.</li>
                <li><strong>Anti-Ragging Policy:</strong> Ragging in any form is strictly prohibited and constitutes a criminal offense.</li>
                <li><strong>Visitor Policy:</strong> Outside visitors are only allowed in the designated lobby area between 4:00 PM and 7:00 PM, after proper logging in the visitor portal.</li>
                <li><strong>Quiet Hours:</strong> Quiet study hours are observed daily from 10:00 PM to 6:00 AM.</li>
                <li><strong>Resource Conservation:</strong> Turn off lights, fans, and ACs when leaving rooms. Wastage of food in the mess is highly discouraged.</li>
            </ul>
            
            <h3>Administration Team</h3>
            <p style="color: var(--text-secondary); margin-top: 0.5rem;">
                The hostel administration is led by the Chief Warden, supported by resident tutors and block supervisors, available 24/7 to address any accommodation or welfare requirements.
            </p>
        </div>
    </div>
</asp:Content>
