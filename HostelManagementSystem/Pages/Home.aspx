<%@ Page Title="Home" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="HostelManagementSystem.Pages.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Hero Banner Section -->
    <section class="hero-section">
        <div class="hero-content">
            <h1 class="hero-title">Experience Premium <span>Hostel Living</span></h1>
            <p class="hero-subtitle">Step into a secure, state-of-the-art living experience designed to make your academic journey comfortable, collaborative, and successful.</p>
            <div class="hero-buttons">
                <a href='<%= Page.ResolveUrl("~/Pages/StudentRegistration") %>' class="btn-custom btn-primary-custom"><i class="fas fa-user-plus"></i> Apply Now</a>
                <a href='<%= Page.ResolveUrl("~/Pages/StudentLogin") %>' class="btn-custom btn-secondary-custom"><i class="fas fa-sign-in-alt"></i> Login Portal</a>
            </div>
        </div>
    </section>

    <!-- Statistics Section -->
    <section class="stats-section">
        <div class="stats-grid">
            <div class="glass-card" style="padding: 1.5rem; margin-bottom: 0;">
                <div class="stat-number">150+</div>
                <div class="stat-label">Happy Residents</div>
            </div>
            <div class="glass-card" style="padding: 1.5rem; margin-bottom: 0;">
                <div class="stat-number">50+</div>
                <div class="stat-label">Premium Rooms</div>
            </div>
            <div class="glass-card" style="padding: 1.5rem; margin-bottom: 0;">
                <div class="stat-number">3</div>
                <div class="stat-label">Hostel Blocks</div>
            </div>
            <div class="glass-card" style="padding: 1.5rem; margin-bottom: 0;">
                <div class="stat-number">98%</div>
                <div class="stat-label">Occupancy Rate</div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section">
        <div class="section-header">
            <h2 class="section-title">World-Class Facilities</h2>
            <p class="section-subtitle">We provide top-notch services to ensure you feel right at home.</p>
        </div>
        
        <div class="features-grid">
            <div class="glass-card feature-card">
                <div class="feature-icon"><i class="fas fa-shield-alt"></i></div>
                <h3>24x7 Security</h3>
                <p style="color: var(--text-secondary); margin-top: 0.5rem;">Round-the-clock security guards, CCTV surveillance, and biometric entries.</p>
            </div>
            <div class="glass-card feature-card">
                <div class="feature-icon"><i class="fas fa-wifi"></i></div>
                <h3>High-Speed Wi-Fi</h3>
                <p style="color: var(--text-secondary); margin-top: 0.5rem;">Seamless Wi-Fi connectivity throughout the campus for academic tasks.</p>
            </div>
            <div class="glass-card feature-card">
                <div class="feature-icon"><i class="fas fa-utensils"></i></div>
                <h3>Premium Mess</h3>
                <p style="color: var(--text-secondary); margin-top: 0.5rem;">Hygienic dining hall serving nutritious and diverse meals daily.</p>
            </div>
            <div class="glass-card feature-card">
                <div class="feature-icon"><i class="fas fa-hands-wash"></i></div>
                <h3>Safe & Clean</h3>
                <p style="color: var(--text-secondary); margin-top: 0.5rem;">Daily housekeeping and regular sanitation of common areas.</p>
            </div>
        </div>
    </section>

    <!-- Testimonials Slider (Static Layout) -->
    <section class="features-section" style="padding-top: 0;">
        <div class="section-header">
            <h2 class="section-title">What Our Residents Say</h2>
            <p class="section-subtitle">Hear firsthand from students living in our hostel.</p>
        </div>
        
        <div class="features-grid">
            <div class="glass-card" style="padding: 1.5rem;">
                <p style="font-style: italic; color: var(--text-secondary);">"The premium hostel has the best study atmosphere. The AC rooms are clean, and the Wi-Fi speed is excellent. I've had a great experience!"</p>
                <div style="margin-top: 1rem; font-weight: 600; color: var(--primary-color);">- Saitej, Computer Science Student</div>
            </div>
            <div class="glass-card" style="padding: 1.5rem;">
                <p style="font-style: italic; color: var(--text-secondary);">"Security is outstanding. Being a girls' block resident, I feel completely safe here. The warden is very helpful and responsive."</p>
                <div style="margin-top: 1rem; font-weight: 600; color: var(--primary-color);">- Anjali, Electrical Engg. Student</div>
            </div>
        </div>
    </section>
</asp:Content>
