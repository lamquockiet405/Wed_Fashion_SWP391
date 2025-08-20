<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Categories - Admin Dashboard</title>
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
                position: relative;
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

            .breadcrumb {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 20px;
                color: #7f8c8d;
                font-size: 14px;
            }

            .breadcrumb i {
                color: #3498db;
            }

            /* Category Container */
            .category-container {
                background: white;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .category-header {
                padding: 20px 25px;
                border-bottom: 1px solid #e9ecef;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .category-title {
                font-size: 20px;
                font-weight: bold;
                color: #2c3e50;
            }

            .category-actions {
                display: flex;
                gap: 10px;
            }

            /* Filter Section */
            .filter-section {
                padding: 20px 25px;
                border-bottom: 1px solid #e9ecef;
                background: #f8f9fa;
            }

            .filter-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 15px;
            }

            .filter-left {
                display: flex;
                align-items: center;
                gap: 15px;
                flex-wrap: wrap;
            }

            .filter-right {
                display: flex;
                align-items: center;
                gap: 10px;
                flex-wrap: wrap;
            }

            .category-type-container {
                display: flex;
                gap: 5px;
                background: white;
                border-radius: 8px;
                padding: 5px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .category-type {
                padding: 8px 16px;
                border-radius: 6px;
                text-decoration: none;
                color: #6c757d;
                font-weight: 500;
                transition: all 0.3s ease;
                border: 1px solid transparent;
            }

            .category-type:hover {
                background: #e9ecef;
                color: #495057;
                text-decoration: none;
            }

            .category-type.active {
                background: #007bff;
                color: white;
                border-color: #007bff;
            }

            .search-container {
                display: flex;
                align-items: center;
                gap: 10px;
                background: white;
                border-radius: 8px;
                padding: 5px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .search-input {
                border: none;
                outline: none;
                padding: 8px 12px;
                border-radius: 6px;
                min-width: 200px;
                font-size: 14px;
            }

            .search-btn {
                background: #007bff;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 6px;
                cursor: pointer;
                transition: background 0.3s ease;
            }

            .search-btn:hover {
                background: #0056b3;
            }

            .sort-container {
                display: flex;
                gap: 5px;
                background: white;
                border-radius: 8px;
                padding: 5px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .sort-btn {
                display: flex;
                align-items: center;
                gap: 5px;
                padding: 8px 12px;
                border-radius: 6px;
                text-decoration: none;
                color: #6c757d;
                font-weight: 500;
                transition: all 0.3s ease;
                border: 1px solid transparent;
                font-size: 13px;
            }

            .sort-btn:hover {
                background: #e9ecef;
                color: #495057;
                text-decoration: none;
            }

            .sort-btn.active {
                background: #28a745;
                color: white;
                border-color: #28a745;
            }

            .sort-btn i {
                font-size: 12px;
            }

            .add-category-btn {
                background: #28a745;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .add-category-btn:hover {
                background: #218838;
                color: white;
                text-decoration: none;
                transform: translateY(-1px);
            }

            .btn {
                padding: 8px 16px;
                border: none;
                border-radius: 6px;
                text-decoration: none;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-primary {
                background: #3498db;
                color: white;
            }

            .btn-primary:hover {
                background: #2980b9;
            }

            .btn-success {
                background: #27ae60;
                color: white;
            }

            .btn-success:hover {
                background: #229954;
            }

            .btn-warning {
                background: #f39c12;
                color: white;
            }

            .btn-warning:hover {
                background: #e67e22;
            }

            /* Category List */
            .category-list {
                padding: 0;
            }

            .category-item {
                display: flex;
                align-items: center;
                padding: 15px 25px;
                border-bottom: 1px solid #f1f3f4;
                transition: all 0.3s;
            }

            .category-item:hover {
                background: #f8f9fa;
            }

            .category-item:last-child {
                border-bottom: none;
            }

            .category-number {
                width: 60px;
                font-weight: 600;
                color: #2c3e50;
            }

            .category-name {
                flex: 1;
                font-weight: 500;
                color: #2c3e50;
            }

            .category-status {
                width: 150px;
                text-align: center;
            }

            .status-badge {
                display: inline-flex;
                align-items: center;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .status-active {
                background: rgba(39, 174, 96, 0.1);
                color: #27ae60;
                border: 1px solid rgba(39, 174, 96, 0.2);
            }

            .status-inactive {
                background: rgba(231, 76, 60, 0.1);
                color: #e74c3c;
                border: 1px solid rgba(231, 76, 60, 0.2);
            }

            .category-actions-cell {
                width: 200px;
                display: flex;
                gap: 10px;
                justify-content: center;
            }

            /* Form Controls */
            .form-control {
                padding: 8px 12px;
                border: 2px solid #e9ecef;
                border-radius: 6px;
                font-size: 14px;
                transition: border-color 0.3s;
                background: white;
            }

            .form-control:focus {
                outline: none;
                border-color: #3498db;
            }

            .form-select {
                padding: 8px 12px;
                border: 2px solid #e9ecef;
                border-radius: 6px;
                font-size: 14px;
                transition: border-color 0.3s;
                background: white;
                cursor: pointer;
            }

            .form-select:focus {
                outline: none;
                border-color: #3498db;
            }

            /* Modal Styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 2000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                backdrop-filter: blur(5px);
            }

            .modal-content {
                background-color: white;
                margin: 10% auto;
                padding: 30px;
                border-radius: 12px;
                width: 90%;
                max-width: 500px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
                position: relative;
                animation: modalSlideIn 0.3s ease-out;
            }

            @keyframes modalSlideIn {
                from {
                    opacity: 0;
                    transform: translateY(-50px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 1px solid #e9ecef;
            }

            .modal-title {
                font-size: 20px;
                font-weight: bold;
                color: #2c3e50;
            }

            .close {
                font-size: 24px;
                font-weight: bold;
                color: #7f8c8d;
                cursor: pointer;
                transition: color 0.3s;
                background: none;
                border: none;
                padding: 5px;
            }

            .close:hover {
                color: #e74c3c;
            }

            .modal-body {
                margin-bottom: 20px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #2c3e50;
            }

            .modal-footer {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
                padding-top: 20px;
                border-top: 1px solid #e9ecef;
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

                .category-container {
                    overflow-x: auto;
                }

                .category-item {
                    min-width: 600px;
                }

                .menu-toggle {
                    display: block;
                    background: none;
                    border: none;
                    font-size: 20px;
                    color: #2c3e50;
                    cursor: pointer;
                }
                .filter-container {
                    flex-direction: column;
                    align-items: stretch;
                }
                
                .filter-left, .filter-right {
                    justify-content: center;
                }
                
                .search-input {
                    min-width: 150px;
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

            /* Animations */
            .fade-in {
                animation: fadeIn 0.5s ease-in;
            }

            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
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

            /* Pagination Styles */
            .pagination-container {
                padding: 20px 25px;
                border-top: 1px solid #e9ecef;
                background: #f8f9fa;
            }

            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                flex-wrap: wrap;
            }

            .pagination a,
            .pagination span {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                min-width: 40px;
                height: 40px;
                padding: 8px 12px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 500;
                font-size: 14px;
                transition: all 0.3s ease;
                border: 1px solid #e1e8ed;
            }

            .pagination a {
                background: white;
                color: #2c3e50;
                border-color: #e1e8ed;
            }

            .pagination a:hover {
                background: #3498db;
                color: white;
                border-color: #3498db;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(52, 152, 219, 0.3);
            }

            .pagination .current {
                background: #3498db;
                color: white;
                border-color: #3498db;
                font-weight: 600;
            }

            .pagination span:not(.current) {
                background: #f8f9fa;
                color: #6c757d;
                border-color: #e1e8ed;
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
                            <a href="view_category" class="active">
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
                <div class="breadcrumb fade-in">
                    <i class="fas fa-home"></i>
                    <span>Home</span>
                    <i class="fas fa-chevron-right"></i>
                    <span>Manage Categories</span>
                </div>

                <h1 class="page-title fade-in">
                    <i class="fas fa-tags"></i>
                    Category Management
                </h1>

                <!-- Category Container -->
                <div class="category-container fade-in">
                    <div class="category-header">
                        <h2 class="category-title">Category List</h2>
                        <div class="category-actions">
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                                <i class="fas fa-plus"></i>
                                Add Category
                            </button>
                        </div>
                    </div>

                    <!-- Filter and Search Section -->
                    <div class="filter-section">
                        <jsp:include page="./filter.jsp" />
                    </div>

                    <div class="category-list">
                        <c:set var="url" value="view_category" />
                        <form method="post" action="${url}">
                            <c:forEach var="c" items="${listCategory}" varStatus="status">
                                <div class="category-item">
                                    <div class="category-number">${ (currentPage - 1) * pageSize + status.index + 1 }</div>
                                    <div class="category-name">${c.categoryName}</div>
                                    <div class="category-status">
                                        <span class="status-badge ${c.status == 1 ? 'status-active' : 'status-inactive'}">
                                            ${c.status == 1 ? 'Active' : 'Inactive'}
                                        </span>
                                    </div>
                                    <div class="category-actions-cell">
                                        <select name="statusAction" class="form-select status-select">
                                            <option value="1|${c.categoryId}" ${c.status == 1 ? 'selected' : ''}>Active</option>
                                            <option value="0|${c.categoryId}" ${c.status == 0 ? 'selected' : ''}>Inactive</option>
                                        </select>
                                        <button type="button" class="btn btn-warning" 
                                                data-bs-toggle="modal" 
                                                data-bs-target="#updateCategoryModal-${c.categoryId}">
                                            <i class="fas fa-edit"></i>
                                            Update
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                            <input type="hidden" value="" name="c_select" id="c_select"/>
                        </form>
                    </div>
                    
                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination-container">
                            <jsp:include page="./page_number.jsp" />
                        </div>
                    </c:if>
                </div>
            </main>
        </div>

        <!-- Include modals -->
        <jsp:include page="./modal_add_category.jsp" />
        <jsp:include page="./modal_update_category.jsp" />

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        
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

            // Status change confirmation
            document.addEventListener('DOMContentLoaded', function () {
                let selects = document.querySelectorAll('.status-select');
                selects.forEach(function (select) {
                    select.addEventListener('change', function () {
                        document.getElementById("c_select").value = select.value;
                        if (confirm("Are you sure you want to change the status?")) {
                            select.form.submit();
                        } else {
                            select.value = select.dataset.previousValue;
                        }
                    });
                    select.dataset.previousValue = select.value;
                });

                // SweetAlert notifications
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

                // Add hover effects to category items
                const categoryItems = document.querySelectorAll('.category-item');
                categoryItems.forEach(item => {
                    item.addEventListener('mouseenter', function() {
                        this.style.transform = 'translateX(5px)';
                        this.style.boxShadow = '0 2px 8px rgba(0,0,0,0.1)';
                    });
                    
                    item.addEventListener('mouseleave', function() {
                        this.style.transform = 'translateX(0)';
                        this.style.boxShadow = 'none';
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