<%-- 
    Document   : ManagerCustomer
    Created on : Feb 27, 2022, 10:49:45 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="java.util.List"%>
<%@page import ="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manage Users - Admin Dashboard</title>
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

            .search-container {
                flex: 1;
                max-width: 400px;
                margin: 0 20px;
            }

            .search-container form {
                display: flex;
            }

            .search-container input {
                width: 100%;
                padding: 10px 15px;
                border: 2px solid #e9ecef;
                border-radius: 8px;
                font-size: 14px;
                transition: border-color 0.3s;
            }

            .search-container input:focus {
                outline: none;
                border-color: #3498db;
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

            /* Table Styles */
            .table-container {
                background: white;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .table-header {
                padding: 20px 25px;
                border-bottom: 1px solid #e9ecef;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .table-title {
                font-size: 20px;
                font-weight: bold;
                color: #2c3e50;
            }

            .table-actions {
                display: flex;
                gap: 10px;
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

            .btn-danger {
                background: #e74c3c;
                color: white;
            }

            .btn-danger:hover {
                background: #c0392b;
            }

            .btn-warning {
                background: #f39c12;
                color: white;
            }

            .btn-warning:hover {
                background: #e67e22;
            }

            /* Table */
            .table {
                width: 100%;
                border-collapse: collapse;
                margin: 0;
            }

            .table thead th {
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

            .table tbody td {
                padding: 15px 20px;
                border-bottom: 1px solid #f1f3f4;
                color: #2c3e50;
                font-size: 14px;
            }

            .table tbody tr:hover {
                background: #f8f9fa;
            }

            .table tbody tr:last-child td {
                border-bottom: none;
            }

            /* Status Badges */
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

            .status-banned {
                background: rgba(231, 76, 60, 0.1);
                color: #e74c3c;
                border: 1px solid rgba(231, 76, 60, 0.2);
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

            .form-control:disabled {
                background: #f8f9fa;
                color: #6c757d;
            }

            /* Action Links */
            .action-link {
                color: #3498db;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s;
            }

            .action-link:hover {
                color: #2980b9;
                text-decoration: underline;
            }

            /* Pagination */
            .pagination {
                display: flex;
                justify-content: center;
                gap: 5px;
                padding: 20px;
                background: #f8f9fa;
                border-top: 1px solid #e9ecef;
            }

            .pagination button {
                padding: 8px 12px;
                border: 1px solid #dee2e6;
                background: white;
                color: #3498db;
                border-radius: 6px;
                cursor: pointer;
                transition: all 0.3s;
                font-weight: 500;
            }

            .pagination button:hover {
                background: #3498db;
                color: white;
                border-color: #3498db;
            }

            .pagination button.active {
                background: #3498db;
                color: white;
                border-color: #3498db;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .header {
                    padding: 15px 20px;
                }

                .logo {
                    font-size: 20px;
                }

                .search-container {
                    margin: 0 10px;
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

                .table-container {
                    overflow-x: auto;
                }

                .table {
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
                <form action="SearchUser" method="Post">
                    <input type="text" placeholder="Search users by email..." name="email">
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
                <div class="breadcrumb fade-in">
                    <i class="fas fa-home"></i>
                    <span>Home</span>
                    <i class="fas fa-chevron-right"></i>
                    <span>Manage Users</span>
                </div>

                <h1 class="page-title fade-in">
                    <i class="fas fa-users"></i>
                    User Management
                </h1>

                <!-- Table Container -->
                <div class="table-container fade-in">

                    <div class="table-responsive">
                        <table class="table" id="userTable">
                            <thead>
                                <tr>
                                    <th>User Name</th>
                                    <th>Email</th>
                                    <th>Phone Number</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${not empty UserList}">
                                    <c:forEach items="${UserList}" var="user">
                                        <tr>
                                            <td>
                                                <strong>${user.username}</strong>
                                            </td>
                                            <td>${user.email}</td>
                                            <td>${user.phoneNumber}</td>
                                            <td>
                                                <span class="status-badge ${user.userRole == 'Admin' ? 'status-active' : 'status-banned'}">
                                                    ${user.userRole}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="status-badge ${user.status == 'Active' ? 'status-active' : 'status-banned'}">
                                                    ${user.status == 'Banned' ? 'Blocked' : 'Active'}
                                                </span>
                                            </td>
                                            <td>
                                                <div style="display: flex; gap: 10px; align-items: center;">
                                                    <form action="BanAccount" method="post" style="margin: 0;">
                                                        <input type="hidden" name="userID" value="${user.userID}">
                                                        <select class="form-control" name="status" onchange="confirmSubmit(this)" style="width: 100px;">
                                                            <option value="Banned" ${user.status == "Banned" ? 'selected' : ''}>Banned</option>
                                                            <option value="Active" ${user.status == "Active" ? 'selected' : ''}>Active</option>
                                                        </select>
                                                    </form>
                                                    <a href="${pageContext.request.contextPath}/ViewUserInformation?userID=${user.userID}" class="action-link">
                                                        <i class="fas fa-eye"></i>
                                                        Detail
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <div id="pagination" class="pagination"></div>
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

            // Confirm status change
            function confirmSubmit(selectElement) {
                if (confirm("Bạn có chắc muốn thay đổi trạng thái người dùng này?")) {
                    selectElement.form.submit();
                } else {
                    // Reset to previous value if cancelled
                    selectElement.value = selectElement.defaultValue;
                }
            }

            // Pagination functionality
            document.addEventListener("DOMContentLoaded", function () {
                const rowsPerPage = 10;
                const table = document.getElementById("userTable");
                const tbody = table.querySelector("tbody");
                const rows = tbody.querySelectorAll("tr");
                const totalRows = rows.length;
                const totalPages = Math.ceil(totalRows / rowsPerPage);
                const pagination = document.getElementById("pagination");

                function showPage(page) {
                    let start = (page - 1) * rowsPerPage;
                    let end = start + rowsPerPage;

                    rows.forEach((row, index) => {
                        row.style.display = index >= start && index < end ? "" : "none";
                    });
                }

                function createPaginationButtons() {
                    pagination.innerHTML = "";
                    
                    // Previous button
                    if (totalPages > 1) {
                        const prevBtn = document.createElement("button");
                        prevBtn.innerHTML = '<i class="fas fa-chevron-left"></i>';
                        prevBtn.onclick = function() {
                            const currentPage = parseInt(document.querySelector('.pagination button.active').textContent);
                            if (currentPage > 1) {
                                showPage(currentPage - 1);
                                highlightActivePage(currentPage - 1);
                            }
                        };
                        pagination.appendChild(prevBtn);
                    }

                    // Page numbers
                    for (let i = 1; i <= totalPages; i++) {
                        let button = document.createElement("button");
                        button.innerText = i;
                        button.onclick = function () {
                            showPage(i);
                            highlightActivePage(i);
                        };
                        pagination.appendChild(button);
                    }

                    // Next button
                    if (totalPages > 1) {
                        const nextBtn = document.createElement("button");
                        nextBtn.innerHTML = '<i class="fas fa-chevron-right"></i>';
                        nextBtn.onclick = function() {
                            const currentPage = parseInt(document.querySelector('.pagination button.active').textContent);
                            if (currentPage < totalPages) {
                                showPage(currentPage + 1);
                                highlightActivePage(currentPage + 1);
                            }
                        };
                        pagination.appendChild(nextBtn);
                    }
                }

                function highlightActivePage(activePage) {
                    let buttons = pagination.querySelectorAll("button");
                    buttons.forEach((button, index) => {
                        if (button.innerHTML.includes('chevron')) return; // Skip navigation buttons
                        button.classList.toggle("active", index === activePage);
                    });
                }

                if (totalPages > 1) {
                    createPaginationButtons();
                    showPage(1);
                    highlightActivePage(1);
                }

                // Add hover effects to table rows
                const tableRows = document.querySelectorAll('.table tbody tr');
                tableRows.forEach(row => {
                    row.addEventListener('mouseenter', function() {
                        this.style.transform = 'scale(1.01)';
                        this.style.boxShadow = '0 2px 8px rgba(0,0,0,0.1)';
                    });
                    
                    row.addEventListener('mouseleave', function() {
                        this.style.transform = 'scale(1)';
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










