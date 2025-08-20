<%@ page import="Model.Shop" %>
<%@ page import="Model.Users" %>
<%@ page import="DAO.DAO_Seller.shop.ShopProcess" %>

<header class="header">
    <div class="logo">
        <img src="logo.png" alt="Logo">
        <span>Seller Panel</span>
    </div>
    
    <nav class="nav-menu">
        <ul class="nav-list">
            <li class="nav-item">
                <a href="view_product" class="nav-link">
                    <i class="fas fa-home"></i>
                    Home
                </a>
            </li>
            <li class="nav-item">
                <a href="manager_view_list_order" class="nav-link">
                    <i class="fas fa-shopping-cart"></i>
                    Orders
                </a>
            </li>
            <li class="nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle" id="dropdownProduct" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-box"></i>
                    Products
                </a>
                <ul class="dropdown-menu" aria-labelledby="dropdownProduct">
                    <li><a class="dropdown-item" href="view_product">
                        <i class="fas fa-list"></i> View Products
                    </a></li>
                    <li><a class="dropdown-item" href="add_new_product">
                        <i class="fas fa-plus"></i> Add New Product
                    </a></li>
                </ul>
            </li>
            <li class="nav-item">
                <a href="manager_view_information_shop" class="nav-link">
                    <i class="fas fa-store"></i>
                    Shop
                </a>
            </li>
        </ul>
    </nav>
    
    <div class="user-actions">
        <a href="${pageContext.request.contextPath}/LogOutController" class="back-link">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
        <div class="user-dropdown">
            <% 
                Users user = (Users) request.getSession().getAttribute("acc");
                if (user == null || !user.getUserRole().equalsIgnoreCase("seller")) {
                    response.sendRedirect(request.getContextPath() + "/LogOutController");
                    return;
                }
                Shop shop = ShopProcess.INSTANCE.getShopByUserId(user.getUserID());
            %>
            <button class="user-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                <img src="<%=user.getImage()%>" alt="Profile" class="user-avatar">
                <i class="fas fa-chevron-down"></i>
            </button>
            <ul class="dropdown-menu" aria-labelledby="dropdownUser1">
                <li><a class="dropdown-item" href="manager_view_information_shop">
                    <i class="fas fa-store"></i> View Shop
                </a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item" href="LogOutController">
                    <i class="fas fa-sign-out-alt"></i> Sign Out
                </a></li>
            </ul>
        </div>
    </div>
</header>

<style>
    /* Header Styles */
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

    .nav-menu {
        flex: 1;
        display: flex;
        justify-content: center;
    }

    .nav-list {
        display: flex;
        list-style: none;
        margin: 0;
        padding: 0;
        gap: 30px;
    }

    .nav-link {
        display: flex;
        align-items: center;
        gap: 8px;
        color: #555;
        text-decoration: none;
        font-weight: 500;
        padding: 8px 16px;
        border-radius: 8px;
        transition: all 0.3s ease;
    }

    .nav-link:hover {
        background: #f8f9fa;
        color: #3498db;
        text-decoration: none;
    }

    .nav-link i {
        font-size: 16px;
    }

    .dropdown-menu {
        border: none;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        border-radius: 8px;
        padding: 8px 0;
    }

    .dropdown-item {
        padding: 10px 20px;
        color: #555;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 10px;
        transition: background-color 0.3s ease;
    }

    .dropdown-item:hover {
        background: #f8f9fa;
        color: #3498db;
        text-decoration: none;
    }

    .dropdown-item i {
        width: 16px;
    }

    .user-actions {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .back-link {
        display: flex;
        align-items: center;
        gap: 8px;
        color: #3498db;
        text-decoration: none;
        font-weight: 500;
        padding: 8px 16px;
        border-radius: 6px;
        transition: all 0.3s ease;
    }

    .back-link:hover {
        background: #e3f2fd;
        color: #1976d2;
        text-decoration: none;
    }

    .user-dropdown {
        position: relative;
    }

    .user-toggle {
        display: flex;
        align-items: center;
        gap: 8px;
        background: none;
        border: none;
        padding: 8px;
        border-radius: 8px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .user-toggle:hover {
        background: #f8f9fa;
    }

    .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid #e1e8ed;
    }

    .user-toggle i {
        color: #555;
        font-size: 12px;
    }

    /* Mobile Responsive */
    @media (max-width: 768px) {
        .header {
            padding: 15px 20px;
        }

        .nav-menu {
            display: none;
        }

        .back-link {
            display: none;
        }

        .logo span {
            display: none;
        }
    }
</style>