<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product Detail - Admin Panel</title>
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

            /* Product Detail Container */
            .product-detail-container {
                background: white;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                overflow: hidden;
                margin-bottom: 25px;
            }

            .product-detail-header {
                background: #f8f9fa;
                padding: 20px 30px;
                border-bottom: 1px solid #e9ecef;
            }

            .product-detail-title {
                font-size: 24px;
                font-weight: 600;
                color: #2c3e50;
                margin: 0;
            }

            .product-detail-content {
                padding: 30px;
            }

            /* Product Images */
            .product-images-section {
                margin-bottom: 30px;
            }

            .product-images-title {
                font-size: 18px;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 20px;
            }

            .product-images-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
                gap: 15px;
            }

            .product-image-item {
                border: 1px solid #e1e8ed;
                border-radius: 8px;
                padding: 8px;
                text-align: center;
                transition: all 0.3s ease;
            }

            .product-image-item:hover {
                border-color: #3498db;
                box-shadow: 0 2px 8px rgba(52, 152, 219, 0.2);
            }

            .product-image {
                max-width: 100%;
                height: auto;
                border-radius: 4px;
            }

            /* Product Information */
            .product-info-section {
                margin-bottom: 30px;
            }

            .product-info-title {
                font-size: 18px;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 20px;
            }

            .info-item {
                margin-bottom: 20px;
            }

            .info-label {
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 8px;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .info-value {
                background: #f8f9fa;
                border: 1px solid #e1e8ed;
                border-radius: 8px;
                padding: 12px 15px;
                color: #2c3e50;
                font-size: 14px;
                min-height: 45px;
                display: flex;
                align-items: center;
            }

            .info-description {
                background: #f8f9fa;
                border: 1px solid #e1e8ed;
                border-radius: 8px;
                padding: 15px;
                color: #2c3e50;
                font-size: 14px;
                min-height: 100px;
                white-space: pre-wrap;
                line-height: 1.6;
            }

            /* Product Variants */
            .product-variants-section {
                margin-bottom: 30px;
            }

            .product-variants-title {
                font-size: 18px;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 20px;
            }

            .variants-table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }

            .variants-table thead th {
                background: #f8f9fa;
                padding: 15px 20px;
                text-align: left;
                font-weight: 600;
                color: #2c3e50;
                border-bottom: 2px solid #e9ecef;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .variants-table tbody td {
                padding: 15px 20px;
                border-bottom: 1px solid #f1f3f4;
                color: #2c3e50;
                font-size: 14px;
                vertical-align: middle;
            }

            .variants-table tbody tr:hover {
                background: #f8f9fa;
            }

            .variant-image {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 6px;
                border: 1px solid #e1e8ed;
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

            .btn-success {
                background: #27ae60;
                color: white;
            }

            .btn-success:hover {
                background: #229954;
                color: white;
                text-decoration: none;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(39, 174, 96, 0.3);
            }

            .btn-danger {
                background: #e74c3c;
                color: white;
            }

            .btn-danger:hover {
                background: #c0392b;
                color: white;
                text-decoration: none;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(231, 76, 60, 0.3);
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

                .product-images-grid {
                    grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
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
                <form action="mange_product" method="get">
                    <input type="text" placeholder="Search products by name..." name="search">
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
                            <a href="mange_product" class="active">
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
                <div class="container-fluid p-0">
                    <jsp:include page="./detail.jsp" />
                </div>
            </main>
        </div>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        
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

            // SweetAlert notifications
            document.addEventListener("DOMContentLoaded", function () {
                const error = "${error}";
                const success = "${success}";

                if (error) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: error,
                        timer: 3000,
                        showConfirmButton: false
                    });
                }

                if (success) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: success,
                        timer: 2000,
                        showConfirmButton: false
                    });
                }
            });
        </script>
    </body>
</html>