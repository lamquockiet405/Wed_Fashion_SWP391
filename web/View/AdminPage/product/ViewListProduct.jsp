<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Products - Admin Panel</title>
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
                margin: 5px 0;
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

            /* Product Type Container */
            .product-type-container {
                display: flex;
                gap: 15px;
                margin-bottom: 25px;
                flex-wrap: wrap;
            }

            .product_type {
                padding: 12px 20px;
                border-radius: 8px;
                text-decoration: none;
                font-size: 14px;
                font-weight: 500;
                color: #555;
                background: #fff;
                border: 1px solid #e1e8ed;
                transition: all 0.3s ease;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }

            .product_type:hover {
                background: #3498db;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(52, 152, 219, 0.3);
                text-decoration: none;
            }

            .active_ptype {
                background: #3498db !important;
                color: white !important;
                font-weight: 600;
                border-color: #3498db;
            }

            /* Filter Section */
            .filter-section {
                background: white;
                border-radius: 12px;
                padding: 20px;
                margin-bottom: 25px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .search-box {
                display: flex;
                gap: 10px;
                align-items: center;
                margin-bottom: 20px;
            }

            .search-box input {
                flex: 1;
                padding: 10px 15px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 14px;
            }

            .search-box button {
                padding: 10px 20px;
                background: #3498db;
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .search-box button:hover {
                background: #2980b9;
            }

            .sort-buttons {
                display: flex;
                gap: 10px;
                align-items: center;
            }

            .sort-btn {
                padding: 8px 16px;
                background: #f8f9fa;
                border: 1px solid #e1e8ed;
                border-radius: 6px;
                text-decoration: none;
                color: #555;
                font-size: 13px;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .sort-btn:hover {
                background: #3498db;
                color: white;
                text-decoration: none;
            }

            .sort-btn.active {
                background: #3498db;
                color: white;
                border-color: #3498db;
            }

            /* Product Table */
            .product-table-container {
                background: white;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                overflow: hidden;
                margin-bottom: 25px;
            }

            .product-table {
                width: 100%;
                border-collapse: collapse;
            }

            .product-table thead th {
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

            .product-table tbody td {
                padding: 15px 20px;
                border-bottom: 1px solid #f1f3f4;
                color: #2c3e50;
                font-size: 14px;
                vertical-align: middle;
            }

            .product-table tbody tr:hover {
                background: #f8f9fa;
            }

            .product-name {
                color: #3498db;
                cursor: pointer;
                font-weight: 500;
                transition: color 0.3s ease;
            }

            .product-name:hover {
                color: #2980b9;
                text-decoration: underline;
            }

            .status-select {
                padding: 6px 12px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 13px;
                background: white;
                cursor: pointer;
                transition: border-color 0.3s ease;
            }

            .status-select:focus {
                outline: none;
                border-color: #3498db;
                box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            }

            .detail-btn {
                background: #f39c12;
                color: white;
                padding: 6px 12px;
                border-radius: 6px;
                text-decoration: none;
                font-size: 12px;
                transition: background-color 0.3s ease;
            }

            .detail-btn:hover {
                background: #e67e22;
                color: white;
                text-decoration: none;
            }

            /* Pagination */
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 5px;
                margin-top: 30px;
            }

            .pagination a, .pagination span {
                padding: 8px 12px;
                text-decoration: none;
                color: #555;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 14px;
                transition: all 0.3s ease;
            }

            .pagination a:hover {
                background: #3498db;
                color: white;
                border-color: #3498db;
                text-decoration: none;
            }

            .pagination .current {
                background: #3498db;
                color: white;
                border-color: #3498db;
                font-weight: 600;
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

                .product-type-container {
                    flex-direction: column;
                }

                .product_type {
                    text-align: center;
                }

                .search-box {
                    flex-direction: column;
                }

                .sort-buttons {
                    flex-wrap: wrap;
                }

                .product-table-container {
                    overflow-x: auto;
                }

                .product-table {
                    min-width: 600px;
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
                    <input type="text" placeholder="Search products by name..." name="search" value="${search}">
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
                <h1 class="page-title">Manage Products</h1>
                
                <div class="container-fluid p-0">
                    <div>
                        <jsp:include page="./filter.jsp"/>
                    </div>
                    <div class="mt-3">
                        <jsp:include page="./product.jsp" />
                    </div>
                    <div>
                        <jsp:include page="./page_number.jsp"/>
                    </div>
                </div>
            </main>
        </div>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
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
                const successUpdateProduct = "${successUpdateProduct}";
                const errorUpdateProduct = "${errorUpdateProduct}";
                const error = "${error}";
                const errorAddCategory = "${errorAddCategory}";
                const successAddCategory = "${successAddCategory}";
                const errorUpdateCategory = "${errorUpdateCategory}";
                const successUpdateCategory = "${successUpdateCategory}";
                
                if (errorAddCategory) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: errorAddCategory,
                        timer: 3000,
                        showConfirmButton: false
                    });
                }
                if (errorUpdateCategory) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: errorUpdateCategory,
                        timer: 3000,
                        showConfirmButton: false
                    });
                }
                if (successAddCategory) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: successAddCategory,
                        timer: 2000,
                        showConfirmButton: false
                    });
                }
                if (successUpdateCategory) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: successUpdateCategory,
                        timer: 2000,
                        showConfirmButton: false
                    });
                }
                if (error) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: error,
                        timer: 3000,
                        showConfirmButton: false
                    });
                }
                if (successUpdateProduct) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: successUpdateProduct,
                        timer: 2000,
                        showConfirmButton: false
                    });
                } else if (errorUpdateProduct) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: errorUpdateProduct,
                        timer: 3000,
                        showConfirmButton: false
                    });
                }
            });
        </script>
    </body>
</html>
