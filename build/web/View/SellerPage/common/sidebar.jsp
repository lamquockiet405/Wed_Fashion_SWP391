<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.Shop" %>
<%@ page import="Model.Users" %>
<%@ page import="DAO.DAO_Seller.shop.ShopProcess" %>

<nav class="sidebar" id="sidebar">
    <% 
        Users user = (Users) request.getSession().getAttribute("acc");
        if (user == null || !user.getUserRole().equalsIgnoreCase("seller")) {
            response.sendRedirect(request.getContextPath() + "/LogOutController");
            return;
        }
        Shop shop = ShopProcess.INSTANCE.getShopByUserId(user.getUserID());
    %>
    
    <div class="sidebar-header">
        <%if (shop != null) {%>
        <a href="manager_view_information_shop" class="shop-logo">
            <img src="<%=shop.getLogo()%>" alt="<%=shop.getName()%>" class="shop-image"/>
            <span class="shop-name"><%=shop.getName()%></span>
        </a>
        <%} else {%>
        <div class="shop-placeholder">
            <i class="fas fa-store"></i>
            <span>My Shop</span>
        </div>
        <%}%>
    </div>
    
    <div class="sidebar-menu">
        <div class="menu-section">
            <h3 class="menu-title">
                <i class="fas fa-cog"></i>
                Management
            </h3>
            
            <div class="menu-item" id="product">
                <button class="menu-toggle" data-bs-toggle="collapse" data-bs-target="#product-collapse">
                    <i class="fas fa-box"></i>
                    <span>Products</span>
                    <i class="fas fa-chevron-down toggle-icon"></i>
                </button>
                <div class="collapse" id="product-collapse">
                    <div class="submenu">
                        <a href="${pageContext.request.contextPath}/view_product" class="submenu-item">
                            <i class="fas fa-list"></i>
                            View Products
                        </a>
                        <a href="${pageContext.request.contextPath}/add_new_product" class="submenu-item">
                            <i class="fas fa-plus"></i>
                            Add Product
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="menu-item" id="order">
                <button class="menu-toggle" data-bs-toggle="collapse" data-bs-target="#order-collapse">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Orders</span>
                    <i class="fas fa-chevron-down toggle-icon"></i>
                </button>
                <div class="collapse" id="order-collapse">
                    <div class="submenu">
                        <a href="manager_view_list_order" class="submenu-item">
                            <i class="fas fa-list"></i>
                            View Orders
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="menu-item" id="shop">
                <button class="menu-toggle" data-bs-toggle="collapse" data-bs-target="#shop-collapse">
                    <i class="fas fa-store"></i>
                    <span>Shop</span>
                    <i class="fas fa-chevron-down toggle-icon"></i>
                </button>
                <div class="collapse" id="shop-collapse">
                    <div class="submenu">
                        <a href="manager_view_information_shop" class="submenu-item">
                            <i class="fas fa-info-circle"></i>
                            Shop Info
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Back to Store Button -->
            <div class="menu-item back-to-store-item">
                <a href="${pageContext.request.contextPath}/LogOutController" class="back-to-store-btn">
                    <i class="fas fa-shopping-bag"></i>
                    <span>Logout</span>
                </a>
            </div>
        </div>
    </div>
</nav>

<style>
    /* Sidebar Styles */
    .sidebar {
        width: 280px;
        background: linear-gradient(180deg, #ffffff 0%, #f8f9fa 100%);
        box-shadow: 2px 0 8px rgba(0,0,0,0.08);
        padding: 0;
        position: fixed;
        left: 0;
        top: 0;
        height: 100vh;
        overflow-y: auto;
        z-index: 999;
        border-right: 1px solid #e9ecef;
    }

    .sidebar-header {
        padding: 30px 25px;
        border-bottom: 1px solid #e9ecef;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
    }

    .shop-logo {
        display: flex;
        align-items: center;
        gap: 15px;
        text-decoration: none;
        color: white;
        transition: all 0.3s ease;
    }

    .shop-logo:hover {
        color: #f8f9fa;
        text-decoration: none;
        transform: translateY(-2px);
    }

    .shop-image {
        width: 65px;
        height: 65px;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid rgba(255, 255, 255, 0.3);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        transition: all 0.3s ease;
    }

    .shop-logo:hover .shop-image {
        border-color: rgba(255, 255, 255, 0.6);
        transform: scale(1.05);
    }

    .shop-name {
        font-size: 18px;
        font-weight: 600;
        color: inherit;
        text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
    }

    .shop-placeholder {
        display: flex;
        align-items: center;
        gap: 15px;
        color: white;
    }

    .shop-placeholder i {
        font-size: 28px;
        color: rgba(255, 255, 255, 0.9);
    }

    .shop-placeholder span {
        font-size: 18px;
        font-weight: 600;
    }

    .sidebar-menu {
        padding: 25px 0;
    }

    .menu-section {
        padding: 0 20px;
    }

    .menu-title {
        font-size: 13px;
        font-weight: 700;
        color: #6c757d;
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 0 10px;
    }

    .menu-title i {
        color: #3498db;
        font-size: 14px;
    }

    .menu-item {
        margin-bottom: 8px;
    }

    .menu-toggle {
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 14px 18px;
        background: none;
        border: none;
        border-radius: 12px;
        color: #495057;
        font-weight: 500;
        text-align: left;
        cursor: pointer;
        transition: all 0.3s ease;
        font-size: 15px;
    }

    .menu-toggle:hover {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        color: #3498db;
        transform: translateX(5px);
        box-shadow: 0 2px 8px rgba(52, 152, 219, 0.15);
    }

    .menu-toggle.active {
        background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
        color: #1976d2;
        font-weight: 600;
        box-shadow: 0 4px 12px rgba(25, 118, 210, 0.2);
    }

    .menu-toggle .toggle-icon {
        font-size: 12px;
        transition: transform 0.3s ease;
        color: #6c757d;
    }

    .menu-toggle[aria-expanded="true"] .toggle-icon {
        transform: rotate(180deg);
        color: #3498db;
    }

    .submenu {
        margin-left: 25px;
        margin-top: 8px;
        padding-left: 10px;
        border-left: 2px solid #e9ecef;
    }

    .submenu-item {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px 18px;
        color: #6c757d;
        text-decoration: none;
        border-radius: 10px;
        margin-bottom: 6px;
        transition: all 0.3s ease;
        font-size: 14px;
        font-weight: 500;
        position: relative;
    }

    .submenu-item:hover {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        color: #3498db;
        text-decoration: none;
        transform: translateX(8px);
        box-shadow: 0 2px 8px rgba(52, 152, 219, 0.1);
    }

    .submenu-item.active {
        background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
        color: #1976d2;
        font-weight: 600;
        border-left: 3px solid #1976d2;
        box-shadow: 0 4px 12px rgba(25, 118, 210, 0.15);
    }

    .submenu-item i {
        width: 18px;
        text-align: center;
        font-size: 14px;
    }

    /* Back to Store Button */
    .back-to-store-item {
        margin-top: 30px;
        padding-top: 20px;
        border-top: 1px solid #e9ecef;
    }

    .back-to-store-btn {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 14px 18px;
        color: #495057;
        text-decoration: none;
        border-radius: 12px;
        transition: all 0.3s ease;
        font-size: 15px;
        font-weight: 500;
        background: none;
        border: none;
        width: 100%;
        text-align: left;
    }

    .back-to-store-btn:hover {
        background: linear-gradient(135deg, #f8f9fa, #e9ecef);
        color: #3498db;
        text-decoration: none;
        transform: translateX(5px);
        box-shadow: 0 2px 8px rgba(52, 152, 219, 0.15);
    }

    .back-to-store-btn i {
        width: 18px;
        text-align: center;
        font-size: 16px;
    }

    /* Custom scrollbar for sidebar */
    .sidebar::-webkit-scrollbar {
        width: 6px;
    }

    .sidebar::-webkit-scrollbar-track {
        background: #f1f1f1;
    }

    .sidebar::-webkit-scrollbar-thumb {
        background: #c1c1c1;
        border-radius: 3px;
    }

    .sidebar::-webkit-scrollbar-thumb:hover {
        background: #a8a8a8;
    }

    /* Mobile Responsive */
    @media (max-width: 768px) {
        .sidebar {
            transform: translateX(-100%);
            transition: transform 0.3s ease;
        }

        .sidebar.active {
            transform: translateX(0);
        }
    }
</style>

<script>
    let currentURL = window.location.href;
    
    function updateActiveSidebar() {
        const sectionsLocation = ["product", "order", "shop"];
        
        // Remove all active classes
        document.querySelectorAll(".menu-toggle").forEach(button => {
            button.classList.remove("active");
        });
        
        // Add active class to current section
        for (let section of sectionsLocation) {
            if (currentURL.includes(section)) {
                let sectionButton = document.querySelector("#" + section + " .menu-toggle");
                if (sectionButton) {
                    sectionButton.classList.add("active");
                }
            }
        }
    }

    function updateActiveSidebarItem() {
        const menuLinks = document.querySelectorAll(".submenu-item");
        
        // Remove all active classes
        menuLinks.forEach(link => link.classList.remove("active"));
        
        // Add active class to current page
        menuLinks.forEach(link => {
            if (currentURL.includes(link.getAttribute("href"))) {
                link.classList.add("active");

                // Open the parent collapse
                let collapseDiv = link.closest(".collapse");
                if (collapseDiv) {
                    collapseDiv.classList.add("show");
                    
                    let dropdownButton = collapseDiv.previousElementSibling;
                    if (dropdownButton) {
                        dropdownButton.setAttribute("aria-expanded", "true");
                    }
                }
            }
        });
    }

    // Initialize when page loads
    document.addEventListener("DOMContentLoaded", function () {
        updateActiveSidebar();
        updateActiveSidebarItem();
    });
</script>
