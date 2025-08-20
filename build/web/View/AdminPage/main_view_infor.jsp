<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Information - Admin Panel</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                background-color: #f4f6f9;
                color: #333;
                line-height: 1.6;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
                font-size: 20px;
                font-weight: 600;
                color: #2c3e50;
            }

            .logo img {
                width: 40px;
                height: 40px;
                margin-right: 10px;
            }

            .search-container {
                flex: 1;
                max-width: 400px;
                margin: 0 20px;
            }

            .search-container input {
                width: 100%;
                padding: 10px 15px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 14px;
                transition: border-color 0.3s ease;
            }

            .search-container input:focus {
                outline: none;
                border-color: #3498db;
                box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
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
                border-radius: 6px;
                text-decoration: none;
                font-size: 14px;
                transition: background-color 0.3s ease;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .logout-btn:hover {
                background: #c0392b;
                color: white;
                text-decoration: none;
            }

            .menu-toggle {
                display: none;
                background: none;
                border: none;
                font-size: 18px;
                color: #2c3e50;
                cursor: pointer;
                padding: 5px;
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

            .sidebar-menu {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .sidebar-menu li {
                margin: 0;
            }

            .sidebar-menu a {
                display: flex;
                align-items: center;
                padding: 12px 25px;
                color: #555;
                text-decoration: none;
                transition: all 0.3s ease;
                border-left: 3px solid transparent;
            }

            .sidebar-menu a:hover {
                background: #f8f9fa;
                color: #3498db;
                border-left-color: #3498db;
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

            /* Main Container */
            .main-container {
                display: flex;
                margin-top: 80px;
                min-height: calc(100vh - 80px);
            }

            .main-content {
                flex: 1;
                padding: 30px;
                margin-left: 250px;
            }

            .page-title {
                font-size: 28px;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 30px;
                text-align: center;
            }

            /* User Information Container */
            .user-info-container {
                background: white;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                overflow: hidden;
                margin-bottom: 25px;
                max-width: 800px;
                margin-left: auto;
                margin-right: auto;
            }

            .user-info-header {
                background: #f8f9fa;
                padding: 20px 30px;
                border-bottom: 1px solid #e9ecef;
            }

            .user-info-title {
                font-size: 24px;
                font-weight: 600;
                color: #2c3e50;
                margin: 0;
            }

            .user-info-content {
                padding: 30px;
            }

            /* Profile Header */
            .profile-header {
                display: flex;
                align-items: center;
                gap: 20px;
                border-bottom: 1px solid #e9ecef;
                padding-bottom: 25px;
                margin-bottom: 30px;
            }

            .profile-img {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid #3498db;
                box-shadow: 0 4px 8px rgba(52, 152, 219, 0.2);
            }

            .profile-name {
                font-size: 28px;
                font-weight: 600;
                color: #2c3e50;
                margin: 0;
            }

            /* Information Table */
            .info-table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }

            .info-table th {
                background: #f8f9fa;
                padding: 15px 20px;
                text-align: left;
                font-weight: 600;
                color: #2c3e50;
                border-bottom: 2px solid #e9ecef;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                width: 30%;
            }

            .info-table td {
                padding: 15px 20px;
                border-bottom: 1px solid #f1f3f4;
                color: #2c3e50;
                font-size: 14px;
                vertical-align: middle;
            }

            .info-table tr:hover {
                background: #f8f9fa;
            }

            .info-link {
                color: #3498db;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease;
            }

            .info-link:hover {
                color: #2980b9;
                text-decoration: underline;
            }

            /* Action Buttons */
            .action-buttons {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-top: 30px;
                flex-wrap: wrap;
            }

            .action-btn {
                padding: 12px 24px;
                border-radius: 8px;
                text-decoration: none;
                font-size: 14px;
                font-weight: 500;
                transition: all 0.3s ease;
                border: none;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-secondary {
                background: #95a5a6;
                color: white;
            }

            .btn-secondary:hover {
                background: #7f8c8d;
                color: white;
                text-decoration: none;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(149, 165, 166, 0.3);
            }

            /* Alert Styles */
            .alert {
                border-radius: 8px;
                border: none;
                padding: 15px 20px;
                margin-bottom: 20px;
            }

            .alert-danger {
                background: rgba(231, 76, 60, 0.1);
                color: #c0392b;
                border-left: 4px solid #e74c3c;
            }

            /* Mobile Responsive */
            .sidebar-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.5);
                z-index: 999;
            }

            @media (max-width: 768px) {
                .menu-toggle {
                    display: block;
                }

                .sidebar {
                    transform: translateX(-100%);
                    transition: transform 0.3s ease;
                    z-index: 1001;
                }

                .sidebar.active {
                    transform: translateX(0);
                }

                .sidebar-overlay.active {
                    display: block;
                }

                .main-content {
                    margin-left: 0;
                    padding: 20px;
                }

                .profile-header {
                    flex-direction: column;
                    text-align: center;
                }

                .info-table th,
                .info-table td {
                    padding: 12px 15px;
                    font-size: 13px;
                }

                .action-buttons {
                    flex-direction: column;
                    align-items: center;
                }

                .action-btn {
                    width: 100%;
                    max-width: 300px;
                    justify-content: center;
                }
            }

            /* Animation */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .main-content {
                animation: fadeIn 0.5s ease-out;
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
            <div class="search-container">
                <form action="ManagerUserURL" method="get">
                    <input type="text" placeholder="Search users..." name="search">
                </form>
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
                            <a href="AdminHome">
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
                            <a href="ManagerUserURL" class="active">
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
                <div class="user-info-container">
                    <div class="user-info-header">
                        <h1 class="user-info-title">
                            <i class="fas fa-user"></i> User Information
                        </h1>
                    </div>
                    
                    <div class="user-info-content">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger d-flex justify-content-between align-items-center" role="alert">
                                <span><i class="fas fa-exclamation-triangle"></i> ${error}</span>
                                <a href="LoginController" class="btn btn-danger">
                                    <i class="fas fa-sign-in-alt"></i> Login
                                </a>
                            </div>
                        </c:if>
                        
                        <c:if test="${empty error}">
                            <div class="profile-header">
                                <c:choose>
                                    <c:when test="${not empty user.image}">
                                        <img src="${user.image}" alt="Avatar" class="profile-img">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="images/avtdf.jpg" alt="Avatar" class="profile-img">
                                    </c:otherwise>
                                </c:choose>                        
                                <h2 class="profile-name">${user.firstName} ${user.lastName}</h2>
                            </div>
                            
                            <table class="info-table">
                                <tr>
                                    <th><i class="fas fa-user"></i> Username</th>
                                    <td>${user.username}</td>
                                </tr>
                                <tr>
                                    <th><i class="fas fa-envelope"></i> Email</th>
                                    <td>${user.email}</td>
                                </tr>
                                <tr>
                                    <th><i class="fas fa-phone"></i> Phone Number</th>
                                    <td>${user.phoneNumber}</td>
                                </tr>
                                <tr>
                                    <th><i class="fas fa-map-marker-alt"></i> Address</th>
                                    <td>${user.address}</td>
                                </tr>
                                <tr>
                                    <th><i class="fas fa-venus-mars"></i> Gender</th>
                                    <td>${user.gender == true ? "Male" : "Female"}</td>
                                </tr>
                                <tr>
                                    <th><i class="fas fa-birthday-cake"></i> Date of Birth</th>
                                    <td>${user.dateOfBirth}</td>
                                </tr>
                                <tr>
                                    <th><i class="fas fa-user-tag"></i> User Role</th>
                                    <td>${user.userRole}</td>
                                </tr>
                                <tr>
                                    <th><i class="fas fa-calendar-plus"></i> Created At</th>
                                    <td>${user.createAt}</td>
                                </tr>
                            </table>
                        </c:if>
                        
                        <div class="action-buttons">
                            <a href="/Ecommerce_SWP/ManagerUserURL" class="action-btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Back to User List
                            </a>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>
            // Sidebar toggle for mobile
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                const overlay = document.querySelector('.sidebar-overlay');
                sidebar.classList.toggle('active');
                overlay.classList.toggle('active');
            }

            function closeSidebar() {
                const sidebar = document.getElementById('sidebar');
                const overlay = document.querySelector('.sidebar-overlay');
                sidebar.classList.remove('active');
                overlay.classList.remove('active');
            }
        </script>
    </body>
</html>