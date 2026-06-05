// Theme Management (Light / Dark Switcher)
document.addEventListener("DOMContentLoaded", function () {
    const currentTheme = localStorage.getItem("theme") || "light";
    document.documentElement.setAttribute("data-theme", currentTheme);
    updateThemeIcon(currentTheme);

    const themeToggleBtn = document.getElementById("theme-toggle");
    if (themeToggleBtn) {
        themeToggleBtn.addEventListener("click", function () {
            let theme = document.documentElement.getAttribute("data-theme");
            let newTheme = theme === "dark" ? "light" : "dark";
            document.documentElement.setAttribute("data-theme", newTheme);
            localStorage.setItem("theme", newTheme);
            updateThemeIcon(newTheme);
        });
    }

    // Attach loading events on form submit
    const forms = document.getElementsByTagName("form");
    if (forms.length > 0) {
        for (let i = 0; i < forms.length; i++) {
            forms[i].addEventListener("submit", function () {
                showLoading();
            });
        }
    }
});

function updateThemeIcon(theme) {
    const icon = document.querySelector("#theme-toggle i");
    if (icon) {
        if (theme === "dark") {
            icon.className = "fas fa-sun"; // Sun icon for light mode toggle
        } else {
            icon.className = "fas fa-moon"; // Moon icon for dark mode toggle
        }
    }
}

// Loading Spinner Functions
function showLoading() {
    const loader = document.getElementById("loading-overlay");
    if (loader) {
        loader.style.display = "flex";
    }
}

function hideLoading() {
    const loader = document.getElementById("loading-overlay");
    if (loader) {
        loader.style.display = "none";
    }
}

// Toast Notifications System
function showToast(message, type = "success") {
    let container = document.getElementById("toast-container");
    if (!container) {
        container = document.createElement("div");
        container.id = "toast-container";
        container.className = "toast-container";
        document.body.appendChild(container);
    }

    const toast = document.createElement("div");
    toast.className = `toast-message toast-${type}`;
    
    let iconClass = "fas fa-check-circle";
    if (type === "error") iconClass = "fas fa-times-circle";
    if (type === "warning") iconClass = "fas fa-exclamation-circle";

    toast.innerHTML = `
        <i class="${iconClass}" style="font-size: 1.25rem;"></i>
        <div>${message}</div>
    `;

    container.appendChild(toast);

    // Auto-remove after 4 seconds
    setTimeout(() => {
        toast.style.animation = "slideIn 0.3s reverse";
        setTimeout(() => {
            toast.remove();
        }, 300);
    }, 4000);
}

// Client-Side Canvas Chart Renderer (For Admin Dashboard)
function renderDashboardChart(canvasId, labels, data, colors) {
    const canvas = document.getElementById(canvasId);
    if (!canvas) return;

    const ctx = canvas.getContext("2d");
    const width = canvas.width;
    const height = canvas.height;
    
    // Clear canvas
    ctx.clearRect(0, 0, width, height);

    // Basic bar chart rendering
    const padding = 40;
    const chartHeight = height - 2 * padding;
    const chartWidth = width - 2 * padding;
    const maxVal = Math.max(...data, 1);
    
    const barWidth = (chartWidth / data.length) - 15;
    const gap = 15;

    // Draw Axes
    ctx.strokeStyle = "rgba(128,128,128,0.3)";
    ctx.lineWidth = 1;
    ctx.beginPath();
    ctx.moveTo(padding, padding);
    ctx.lineTo(padding, height - padding);
    ctx.lineTo(width - padding, height - padding);
    ctx.stroke();

    // Draw Bars
    for (let i = 0; i < data.length; i++) {
        const val = data[i];
        const barHeight = (val / maxVal) * chartHeight;
        const x = padding + i * (barWidth + gap) + gap / 2;
        const y = height - padding - barHeight;

        // Draw Bar
        ctx.fillStyle = colors[i] || "#4f46e5";
        ctx.beginPath();
        // Rounded top corners for bars
        ctx.roundRect ? ctx.roundRect(x, y, barWidth, barHeight, [4, 4, 0, 0]) : ctx.rect(x, y, barWidth, barHeight);
        ctx.fill();

        // Value text
        ctx.fillStyle = "var(--text-primary)";
        ctx.font = "10px sans-serif";
        ctx.textAlign = "center";
        ctx.fillText(val.toString(), x + barWidth / 2, y - 5);

        // Label text
        ctx.fillText(labels[i], x + barWidth / 2, height - padding + 15);
    }
}
