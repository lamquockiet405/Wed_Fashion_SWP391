<%-- 
    Document   : ManagerCustomer
    Created on : Feb 27, 2022, 10:49:45 PM
    Author     : Admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manage Shops - Admin Dashboard</title>
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

            /* Action Links */
            .action-link {
                color: #3498db;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s;
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }

            .action-link:hover {
                color: #2980b9;
                text-decoration: underline;
            }

            /* Status Badges */
            .status-badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }

            .status-badge.pending {
                background-color: #fff3cd;
                color: #856404;
            }

            .status-badge.approved {
                background-color: #d4edda;
                color: #155724;
            }

            .status-badge.rejected {
                background-color: #f8d7da;
                color: #721c24;
            }

            /* Action Buttons */
            .action-buttons {
                display: flex;
                gap: 8px;
                align-items: center;
            }

            .action-btn {
                width: 32px;
                height: 32px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
                font-size: 14px;
            }

            .approve-btn {
                background-color: #28a745;
                color: white;
            }

            .approve-btn:hover {
                background-color: #218838;
                transform: translateY(-1px);
            }

            .reject-btn {
                background-color: #dc3545;
                color: white;
            }

            .reject-btn:hover {
                background-color: #c82333;
                transform: translateY(-1px);
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
                max-width: 600px;
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
                color: #2c3e50;
                line-height: 1.6;
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

                .modal-content {
                    margin: 5% auto;
                    width: 95%;
                    padding: 20px;
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
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
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
                <form action="SearchShop" method="Post">
                    <input type="text" placeholder="Search shops by email..." name="email">
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
                            <a href="ManageShopURL" class="active">
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
                    <span>Manage Shops</span>
                </div>

                <h1 class="page-title fade-in">
                    <i class="fas fa-store"></i>
                    Shop Management
                </h1>

                <!-- Table Container -->
                <div class="table-container fade-in">


                    <div class="table-responsive">
                        <table class="table" id="shopTable">
                            <thead>
                                <tr>
                                    <th>Shop Name</th>
                                    <th>Email</th>
                                    <th>Phone Number</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${ShopList}" var="shop">
                                    <tr>
                                        <td>
                                            <strong>${shop.name}</strong>
                                        </td>

                                        <%-- Initialize variables to store user information --%>
                                        <c:set var="foundUserName" value="" scope="page"/>
                                        <c:set var="foundEmail" value="" scope="page"/>
                                        <c:set var="foundFirstName" value="" scope="page"/>
                                        <c:set var="foundLastName" value="" scope="page"/>
                                        <c:set var="foundPhoneNumber" value="" scope="page"/>

                                        <%-- Find user with userID matching shop.userId --%>
                                        <c:forEach items="${UserList}" var="user">
                                            <c:if test="${shop.userId == user.userID}">
                                                <c:set var="foundUserName" value="${user.username}" scope="page"/>
                                                <c:set var="foundEmail" value="${user.email}" scope="page"/>
                                                <c:set var="foundFirstName" value="${user.firstName}" scope="page"/>
                                                <c:set var="foundLastName" value="${user.lastName}" scope="page"/>
                                                <c:set var="foundPhoneNumber" value="${user.phoneNumber}" scope="page"/>
                                            </c:if>
                                        </c:forEach>

                                        <%-- Display user information --%>
                                        <td>${foundEmail}</td>
                                        <td>${foundPhoneNumber}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${shop.status == 'Pending'}">
                                                    <span class="status-badge pending">
                                                        <i class="fas fa-clock"></i> Pending
                                                    </span>
                                                </c:when>
                                                <c:when test="${shop.status == 'Approved'}">
                                                    <span class="status-badge approved">
                                                        <i class="fas fa-check-circle"></i> Approved
                                                    </span>
                                                </c:when>
                                                <c:when test="${shop.status == 'Rejected'}">
                                                    <span class="status-badge rejected">
                                                        <i class="fas fa-times-circle"></i> Rejected
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge pending">
                                                        <i class="fas fa-clock"></i> Pending
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="${pageContext.request.contextPath}/ViewShopInformation?id=${shop.id}" class="action-link">
                                                    <i class="fas fa-eye"></i>
                                                    View Details
                                                </a>
                                                
                                                <c:if test="${shop.status == 'Pending'}">
                                                    <button onclick="approveShop(${shop.id})" class="action-btn approve-btn" title="Approve Shop">
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                    <button onclick="rejectShop(${shop.id})" class="action-btn reject-btn" title="Reject Shop">
                                                        <i class="fas fa-times"></i>
                                                    </button>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <div id="pagination" class="pagination"></div>
                </div>
            </main>
        </div>

        <!-- Description Modal -->
        <div id="descriptionModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title">Shop Details</h3>
                    <button class="close">&times;</button>
                </div>
                <div class="modal-body">
                    <p id="fullDescription"></p>
                </div>
            </div>
        </div>

        <script>
            // Shop approval functions
            function approveShop(shopId) {
                if (confirm('Bạn có chắc chắn muốn duyệt shop này?')) {
                    const adminNotes = prompt('Nhập ghi chú (tùy chọn):') || '';
                    
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'ApproveShop';
                    
                    const shopIdInput = document.createElement('input');
                    shopIdInput.type = 'hidden';
                    shopIdInput.name = 'shopId';
                    shopIdInput.value = shopId;
                    
                    const actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'approve';
                    
                    const notesInput = document.createElement('input');
                    notesInput.type = 'hidden';
                    notesInput.name = 'adminNotes';
                    notesInput.value = adminNotes;
                    
                    form.appendChild(shopIdInput);
                    form.appendChild(actionInput);
                    form.appendChild(notesInput);
                    
                    document.body.appendChild(form);
                    form.submit();
                }
            }

            function rejectShop(shopId) {
                if (confirm('Bạn có chắc chắn muốn từ chối shop này?')) {
                    const adminNotes = prompt('Nhập lý do từ chối (bắt buộc):');
                    if (!adminNotes || adminNotes.trim() === '') {
                        alert('Vui lòng nhập lý do từ chối!');
                        return;
                    }
                    
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'ApproveShop';
                    
                    const shopIdInput = document.createElement('input');
                    shopIdInput.type = 'hidden';
                    shopIdInput.name = 'shopId';
                    shopIdInput.value = shopId;
                    
                    const actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'reject';
                    
                    const notesInput = document.createElement('input');
                    notesInput.type = 'hidden';
                    notesInput.name = 'adminNotes';
                    notesInput.value = adminNotes;
                    
                    form.appendChild(shopIdInput);
                    form.appendChild(actionInput);
                    form.appendChild(notesInput);
                    
                    document.body.appendChild(form);
                    form.submit();
                }
            }

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
            document.addEventListener("DOMContentLoaded", function () {
                const modal = document.getElementById("descriptionModal");
                const modalContent = document.getElementById("fullDescription");
                const closeBtn = document.querySelector(".close");
                const rowsPerPage = 10;
                const table = document.getElementById("shopTable");
                const tbody = table.querySelector("tbody");
                const rows = tbody.querySelectorAll("tr");
                const totalRows = rows.length;
                const totalPages = Math.ceil(totalRows / rowsPerPage);
                const pagination = document.getElementById("pagination");

                // Modal event listeners
                document.querySelectorAll(".view-full-description").forEach(item => {
                    item.addEventListener("click", function (event) {
                        event.preventDefault();
                        const description = this.getAttribute("data-description");
                        let formattedText = description.replace(/(.{80})/g, "$1\n");
                        modalContent.innerText = formattedText;
                        modal.style.display = "block";
                    });
                });

                closeBtn.onclick = function () {
                    modal.style.display = "none";
                };

                window.onclick = function (event) {
                    if (event.target == modal) {
                        modal.style.display = "none";
                    }
                };

                // Pagination functionality
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
                        prevBtn.onclick = function () {
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
                        nextBtn.onclick = function () {
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
                        if (button.innerHTML.includes('chevron'))
                            return; // Skip navigation buttons
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
                    row.addEventListener('mouseenter', function () {
                        this.style.transform = 'scale(1.01)';
                        this.style.boxShadow = '0 2px 8px rgba(0,0,0,0.1)';
                    });

                    row.addEventListener('mouseleave', function () {
                        this.style.transform = 'scale(1)';
                        this.style.boxShadow = 'none';
                    });
                });
            });

            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function (e) {
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
