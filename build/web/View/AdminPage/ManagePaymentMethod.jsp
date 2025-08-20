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
        <title>Manage Payment Methods - Admin Dashboard</title>
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

            .status-inactive {
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
            .modal-overlay {
                display: none;
                position: fixed;
                z-index: 2000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                backdrop-filter: blur(5px);
                justify-content: center;
                align-items: center;
            }

            .modal-box {
                background: white;
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
                            <a href="GetPaymentMethodList" class="active">
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
                    <span>Manage Payment Methods</span>
                </div>

                <h1 class="page-title fade-in">
                    <i class="fas fa-credit-card"></i>
                    Payment Method Management
                </h1>

                <!-- Table Container -->
                <div class="table-container fade-in">
                    <div class="table-header">
                        <h2 class="table-title">Payment Methods</h2>
                        <div class="table-actions">
                            <button class="btn btn-primary" id="openModalBtn">
                                <i class="fas fa-plus"></i>
                                Add Payment Method
                            </button>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table" id="paymentTable">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Payment Method</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="id" value="0" />
                                <c:forEach items="${PaymentMethodList}" var="pm" varStatus="loop">
                                    <tr>
                                        <c:set var="id" value="${loop.count}"/>
                                        <td>${id}</td>
                                        <td>
                                            <strong>${pm.paymentMethod}</strong>
                                        </td>
                                        <td>
                                            <span class="status-badge ${pm.status == 1 ? 'status-active' : 'status-inactive'}">
                                                ${pm.status == 1 ? 'Active' : 'Inactive'}
                                            </span>
                                        </td>
                                        <td>
                                            <form action="UpdatePaymentMethodStatus" method="post" style="display: inline;">
                                                <input type="hidden" name="paymentId" value="${pm.paymentID}">
                                                <select class="form-select" name="status" onchange="this.form.submit()" style="width: 120px;">
                                                    <option value="0" ${pm.status == 0 ? 'selected' : ''}>Inactive</option>
                                                    <option value="1" ${pm.status == 1 ? 'selected' : ''}>Active</option>
                                                </select>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>

        <!-- Add Payment Method Modal -->
        <div id="addAddressModal" class="modal-overlay">
            <div class="modal-box">
                <div class="modal-header">
                    <h3 class="modal-title">Add New Payment Method</h3>
                </div>
                <div class="modal-body">
                    <form action="/Ecommerce_SWP/AddPaymentMethod" method="post">
                        <div class="form-group">
                            <label class="form-label">Payment Method Name</label>
                            <input type="text" class="form-control" name="methodName" required>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" id="closeModalBtn">Cancel</button>
                            <button type="submit" class="btn btn-primary">Add Payment Method</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
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

            // Modal functionality
            document.addEventListener('DOMContentLoaded', function() {
                const openModalBtn = document.getElementById("openModalBtn");
                const closeModalBtn = document.getElementById("closeModalBtn");
                const modal = document.getElementById("addAddressModal");

                openModalBtn.addEventListener("click", function () {
                    modal.style.display = "flex";
                });

                closeModalBtn.addEventListener("click", function () {
                    modal.style.display = "none";
                });

                // Close modal when clicking outside
                modal.addEventListener("click", function (event) {
                    if (event.target === modal) {
                        modal.style.display = "none";
                    }
                });

                // URL parameter message
                const urlParams = new URLSearchParams(window.location.search);
                const message = urlParams.get("mess");
                if (message) {
                    alert(message);
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