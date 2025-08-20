<%-- 
    Document   : AdminHome
    Created on : Mar 3, 2025, 9:06:18 PM
    Author     : lenovo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background-color: #f4f6f9;
                color: #333;
                line-height: 1.6;
            }

            /* Header */
            .header {
                background: #fff;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                padding: 15px 30px;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .logo {
                display: flex;
                align-items: center;
                gap: 15px;
                font-size: 24px;
                font-weight: bold;
                color: #2c3e50;
            }

            .logo img {
                width: 40px;
                height: 40px;
                border-radius: 8px;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .user-name {
                font-weight: 500;
                color: #2c3e50;
            }

            .logout-btn {
                background: #e74c3c;
                color: white;
                padding: 8px 16px;
                border: none;
                border-radius: 6px;
                text-decoration: none;
                font-size: 14px;
                transition: background 0.3s;
            }

            .logout-btn:hover {
                background: #c0392b;
            }

            /* Main Container */
            .main-container {
                display: flex;
                margin-top: 80px;
                min-height: calc(100vh - 80px);
            }

            /* Sidebar */
            .sidebar {
                width: 250px;
                background: #fff;
                box-shadow: 2px 0 4px rgba(0,0,0,0.1);
                padding: 20px 0;
                position: fixed;
                left: 0;
                top: 80px;
                height: calc(100vh - 80px);
                overflow-y: auto;
            }

            .sidebar-section {
                margin-bottom: 30px;
            }

            .sidebar-title {
                padding: 0 25px 10px;
                font-size: 12px;
                font-weight: bold;
                color: #7f8c8d;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .sidebar-menu {
                list-style: none;
            }

            .sidebar-menu li {
                margin: 5px 0;
            }

            .sidebar-menu a {
                display: flex;
                align-items: center;
                padding: 12px 25px;
                color: #2c3e50;
                text-decoration: none;
                transition: all 0.3s;
                border-left: 3px solid transparent;
            }

            .sidebar-menu a:hover {
                background: #ecf0f1;
                border-left-color: #3498db;
                color: #3498db;
            }

            .sidebar-menu a.active {
                background: #e0f2f7;
                color: #3498db;
                border-left-color: #3498db;
                font-weight: 600;
            }

            .sidebar-menu i {
                width: 20px;
                margin-right: 12px;
                text-align: center;
                font-size: 16px;
            }

            /* Main Content */
            .main-content {
                flex: 1;
                margin-left: 250px;
                padding: 30px;
            }

            .page-title {
                font-size: 28px;
                font-weight: bold;
                color: #2c3e50;
                margin-bottom: 30px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .page-title i {
                color: #3498db;
            }

            /* Stats Grid */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 25px;
                margin-bottom: 40px;
            }

            .stat-card {
                background: white;
                border-radius: 12px;
                padding: 25px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                border-left: 4px solid #3498db;
                transition: transform 0.3s, box-shadow 0.3s;
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            }

            .stat-card.users {
                border-left-color: #e74c3c;
            }

            .stat-card.orders {
                border-left-color: #f39c12;
            }

            .stat-card.products {
                border-left-color: #27ae60;
            }

            .stat-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 15px;
            }

            .stat-icon {
                width: 50px;
                height: 50px;
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 20px;
                color: white;
            }

            .stat-icon.users {
                background: #e74c3c;
            }

            .stat-icon.orders {
                background: #f39c12;
            }

            .stat-icon.products {
                background: #27ae60;
            }

            .stat-title {
                font-size: 14px;
                color: #7f8c8d;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .stat-value {
                font-size: 36px;
                font-weight: bold;
                color: #2c3e50;
                margin: 10px 0;
            }

            .stat-description {
                font-size: 14px;
                color: #95a5a6;
            }

            /* Quick Actions */
            .quick-actions {
                background: white;
                border-radius: 12px;
                padding: 25px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .section-title {
                font-size: 20px;
                font-weight: bold;
                color: #2c3e50;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
            }

            .section-title i {
                margin-right: 10px;
                color: #3498db;
            }

            .actions-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 15px;
            }

            .action-btn {
                display: flex;
                align-items: center;
                padding: 15px 20px;
                background: #f8f9fa;
                border: 2px solid #e9ecef;
                border-radius: 8px;
                text-decoration: none;
                color: #2c3e50;
                transition: all 0.3s;
                font-weight: 500;
            }

            .action-btn:hover {
                background: #3498db;
                color: white;
                border-color: #3498db;
                transform: translateY(-2px);
            }

            .action-btn i {
                margin-right: 12px;
                font-size: 18px;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .header {
                    padding: 15px 20px;
                }

                .logo {
                    font-size: 20px;
                }

                .sidebar {
                    transform: translateX(-100%);
                    transition: transform 0.3s;
                    z-index: 1001;
                }

                .sidebar.open {
                    transform: translateX(0);
                }

                .main-content {
                    margin-left: 0;
                    padding: 20px;
                }

                .stats-grid {
                    grid-template-columns: 1fr;
                    gap: 20px;
                }

                .actions-grid {
                    grid-template-columns: 1fr;
                }

                .menu-toggle {
                    display: block;
                    background: none;
                    border: none;
                    font-size: 20px;
                    color: #2c3e50;
                    cursor: pointer;
                }
            }

            @media (min-width: 769px) {
                .menu-toggle {
                    display: none;
                }
            }

            /* Overlay for mobile */
            .sidebar-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0,0,0,0.5);
                z-index: 1000;
            }

            .sidebar-overlay.open {
                display: block;
            }

            /* Simple animations */
            .fade-in {
                animation: fadeIn 0.5s ease-in;
            }

            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }

            /* Loading state */
            .loading {
                opacity: 0.7;
                pointer-events: none;
            }

            /* Custom scrollbar */
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
        </style>
    </head>
    <body>
        <!-- Header -->
        <header class="header">
            <div class="logo">
                <img src="logo.png" alt="Logo">
                <span>Admin Panel</span>
            </div>
            
            <div class="user-info">
                <button class="menu-toggle" onclick="toggleSidebar()">
                    <i class="fas fa-bars"></i>
                </button>
                <span class="user-name">Welcome, ${acc.username}</span>
                <a href="LogOutController" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i>
                    Logout
                </a>
            </div>
        </header>

        <!-- Sidebar Overlay for Mobile -->
        <div class="sidebar-overlay" onclick="closeSidebar()"></div>

        <!-- Main Container -->
        <div class="main-container">
            <!-- Sidebar -->
            <nav class="sidebar" id="sidebar">
                <div class="sidebar-section">
                    <ul class="sidebar-menu">
                        <li>
                            <a href="#" class="active">
                                <i class="fas fa-tachometer-alt"></i>
                                Dashboard
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="sidebar-section">
                    <div class="sidebar-title">ADMIN MANAGE</div>
                    <ul class="sidebar-menu">
                        <li>
                            <a href="ManagerUserURL">
                                <i class="fas fa-users"></i>
                                Manage User
                            </a>
                        </li>
                        <li>
                            <a href="ManageShopURL">
                                <i class="fas fa-store"></i>
                                Manage Shop
                            </a>
                        </li>
                        <li>
                            <a href="view_category">
                                <i class="fas fa-tags"></i>
                                Manage Category
                            </a>
                        </li>
                        <li>
                            <a href="mange_product">
                                <i class="fas fa-box"></i>
                                Manage Product
                            </a>
                        </li>
                        <li>
                            <a href="GetPaymentMethodList">
                                <i class="fas fa-credit-card"></i>
                                Manage Payment Method
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="main-content">
                <h1 class="page-title fade-in">
                    <i class="fas fa-chart-line"></i>
                    Dashboard Overview
                </h1>

                <!-- Statistics Cards -->
                <div class="stats-grid fade-in">
                    <div class="stat-card users">
                        <div class="stat-header">
                            <div>
                                <div class="stat-title">Total Users</div>
                                <div class="stat-value">${totalUsers}</div>
                                <div class="stat-description">Registered users</div>
                            </div>
                            <div class="stat-icon users">
                                <i class="fas fa-users"></i>
                            </div>
                        </div>
                    </div>

                    <div class="stat-card orders">
                        <div class="stat-header">
                            <div>
                                <div class="stat-title">Total Orders</div>
                                <div class="stat-value">${totalOrders}</div>
                                <div class="stat-description">All time orders</div>
                            </div>
                            <div class="stat-icon orders">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                        </div>
                    </div>

                    <div class="stat-card products">
                        <div class="stat-header">
                            <div>
                                <div class="stat-title">Total Products</div>
                                <div class="stat-value">${totalProducts}</div>
                                <div class="stat-description">Available products</div>
                            </div>
                            <div class="stat-icon products">
                                <i class="fas fa-box"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="quick-actions fade-in">
                    <h2 class="section-title">
                        <i class="fas fa-bolt"></i>
                        Quick Actions
                    </h2>
                    <div class="actions-grid">
                        <a href="ManagerUserURL" class="action-btn">
                            <i class="fas fa-user-plus"></i>
                            Add New User
                        </a>
                        <a href="ManageShopURL" class="action-btn">
                            <i class="fas fa-store"></i>
                            Manage Shops
                        </a>
                        <a href="view_category" class="action-btn">
                            <i class="fas fa-tag"></i>
                            View Categories
                        </a>
                        <a href="mange_product" class="action-btn">
                            <i class="fas fa-plus-circle"></i>
                            Add Product
                        </a>
                        <a href="GetPaymentMethodList" class="action-btn">
                            <i class="fas fa-credit-card"></i>
                            Payment Settings
                        </a>
                        <a href="#" class="action-btn">
                            <i class="fas fa-chart-bar"></i>
                            View Reports
                        </a>
                    </div>
                </div>
            </main>
        </div>

        <script>
            // Mobile sidebar toggle
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                const overlay = document.querySelector('.sidebar-overlay');
                
                sidebar.classList.toggle('open');
                overlay.classList.toggle('open');
            }

            function closeSidebar() {
                const sidebar = document.getElementById('sidebar');
                const overlay = document.querySelector('.sidebar-overlay');
                
                sidebar.classList.remove('open');
                overlay.classList.remove('open');
            }

            // Add active class to current page
            document.addEventListener('DOMContentLoaded', function() {
                // Get current page URL
                const currentPage = window.location.pathname;
                
                // Find matching sidebar link and add active class
                const sidebarLinks = document.querySelectorAll('.sidebar-menu a');
                sidebarLinks.forEach(link => {
                    if (link.getAttribute('href') && currentPage.includes(link.getAttribute('href'))) {
                        link.classList.add('active');
                    }
                });

                // Add click effects to stat cards
                const statCards = document.querySelectorAll('.stat-card');
                statCards.forEach(card => {
                    card.addEventListener('click', function() {
                        // Add a subtle click effect
                        this.style.transform = 'scale(0.98)';
                        setTimeout(() => {
                            this.style.transform = '';
                        }, 150);
                    });
                });

                // Add hover effects to action buttons
                const actionBtns = document.querySelectorAll('.action-btn');
                actionBtns.forEach(btn => {
                    btn.addEventListener('mouseenter', function() {
                        this.style.transform = 'translateY(-3px)';
                    });
                    
                    btn.addEventListener('mouseleave', function() {
                        this.style.transform = 'translateY(0)';
                    });
                });
            });

            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function(e) {
                const sidebar = document.getElementById('sidebar');
                const menuToggle = document.querySelector('.menu-toggle');
                
                if (window.innerWidth <= 768) {
                    if (!sidebar.contains(e.target) && !menuToggle.contains(e.target)) {
                        closeSidebar();
                    }
                }
            });
        </script>
    </body>
</html>
