<%-- 
    Document   : Header
    Created on : Feb 21, 2025, 12:12:24 PM
    Author     : lenovo
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>FoodMart - Free eCommerce Grocery Store HTML Website Template</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="format-detection" content="telephone=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="author" content="">
        <meta name="keywords" content="">
        <meta name="description" content="">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="./css/vendor.css">
        <link rel="stylesheet" type="text/css" href="./style.css">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&family=Open+Sans:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&display=swap" rel="stylesheet">

        <style>
            /* Modern Header Styling */
            .modern-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                box-shadow: 0 8px 32px rgba(102, 126, 234, 0.3);
                backdrop-filter: blur(20px);
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                position: sticky;
                top: 0;
                z-index: 1000;
                transition: all 0.3s ease;
            }

            .modern-header:hover {
                box-shadow: 0 12px 40px rgba(102, 126, 234, 0.4);
            }

            .header-content {
                padding: 15px 0;
                position: relative;
            }

            .main-logo {
                position: relative;
                transition: all 0.3s ease;
            }

            .main-logo:hover {
                transform: scale(1.05);
            }

            .main-logo img {
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
                transition: all 0.3s ease;
            }

            .main-logo:hover img {
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.25);
                transform: rotate(5deg);
            }

            .search-container {
                position: relative;
                max-width: 500px;
                margin: 0 auto;
            }

            .search-bar {
                background: rgba(255, 255, 255, 0.95) !important;
                backdrop-filter: blur(20px);
                border: 2px solid rgba(255, 255, 255, 0.2);
                border-radius: 25px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                overflow: hidden;
            }

            .search-bar:hover {
                transform: translateY(-2px);
                box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
                border-color: rgba(255, 255, 255, 0.4);
            }

            .search-bar:focus-within {
                transform: translateY(-3px);
                box-shadow: 0 15px 50px rgba(102, 126, 234, 0.3);
                border-color: #667eea;
            }

            .search-input {
                border: none !important;
                background: transparent !important;
                padding: 15px 20px;
                font-size: 16px;
                color: #2d3748;
                font-weight: 500;
            }

            .search-input::placeholder {
                color: #718096;
                font-weight: 400;
            }

            .search-input:focus {
                outline: none !important;
                box-shadow: none !important;
            }

            .search-icon-container {
                background: linear-gradient(135deg, #667eea, #764ba2);
                border-radius: 50%;
                width: 45px;
                height: 45px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: all 0.3s ease;
                margin: 5px;
            }

            .search-icon-container:hover {
                transform: scale(1.1) rotate(5deg);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            }

            .search-icon {
                color: white;
                font-size: 18px;
            }

            .header-actions {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .action-button {
                background: rgba(255, 255, 255, 0.15);
                border: 2px solid rgba(255, 255, 255, 0.2);
                border-radius: 50%;
                width: 50px;
                height: 50px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                text-decoration: none;
                transition: all 0.3s ease;
                backdrop-filter: blur(10px);
                position: relative;
                overflow: hidden;
            }

            .action-button::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                transition: left 0.5s;
            }

            .action-button:hover::before {
                left: 100%;
            }

            .action-button:hover {
                background: rgba(255, 255, 255, 0.25);
                border-color: rgba(255, 255, 255, 0.4);
                transform: translateY(-3px) scale(1.05);
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            }

            .action-button svg {
                width: 24px;
                height: 24px;
                transition: all 0.3s ease;
            }

            .action-button:hover svg {
                transform: scale(1.1);
            }

            .shop-link {
                background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                color: white;
                padding: 12px 24px;
                border-radius: 25px;
                text-decoration: none;
                font-weight: 600;
                font-size: 14px;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(79, 172, 254, 0.3);
                border: none;
                position: relative;
                overflow: hidden;
            }

            .shop-link::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                transition: left 0.5s;
            }

            .shop-link:hover::before {
                left: 100%;
            }

            .shop-link:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(79, 172, 254, 0.4);
                color: white;
                text-decoration: none;
            }

            .cart-container {
                position: relative;
                display: inline-block;
            }

            .cart-button {
                background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
                border: none;
                border-radius: 50%;
                width: 55px;
                height: 55px;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: 700;
                font-size: 18px;
                transition: all 0.3s ease;
                box-shadow: 0 6px 20px rgba(250, 112, 154, 0.3);
                position: relative;
                overflow: hidden;
            }

            .cart-button::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                transition: left 0.5s;
            }

            .cart-button:hover::before {
                left: 100%;
            }

            .cart-button:hover {
                transform: translateY(-3px) scale(1.05);
                box-shadow: 0 10px 30px rgba(250, 112, 154, 0.4);
            }

            .cart-count {
                position: absolute;
                top: -8px;
                right: -8px;
                background: linear-gradient(135deg, #ff4d4f, #ff2d55);
                color: white;
                font-size: 12px;
                font-weight: 800;
                min-width: 24px;
                height: 24px;
                text-align: center;
                border-radius: 50%;
                line-height: 24px;
                box-shadow: 0 4px 12px rgba(255, 77, 79, 0.4);
                border: 2px solid white;
                transition: all 0.3s ease;
                animation: pulse 2s infinite;
            }

            @keyframes pulse {
                0% {
                    transform: scale(1);
                }
                50% {
                    transform: scale(1.1);
                }
                100% {
                    transform: scale(1);
                }
            }

            .cart-button:hover .cart-count {
                transform: scale(1.2) rotate(10deg);
                box-shadow: 0 6px 16px rgba(255, 77, 79, 0.6);
            }

            .logout-link {
                background: linear-gradient(135deg, #ff6b6b, #ee5a52);
                color: white;
                padding: 10px 20px;
                border-radius: 20px;
                text-decoration: none;
                font-weight: 600;
                font-size: 14px;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
                border: none;
            }

            .logout-link:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(255, 107, 107, 0.4);
                color: white;
                text-decoration: none;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .search-container {
                    margin: 15px 0;
                }
                
                .header-actions {
                    gap: 10px;
                    flex-wrap: wrap;
                    justify-content: center;
                }
                
                .action-button {
                    width: 45px;
                    height: 45px;
                }
                
                .cart-button {
                    width: 50px;
                    height: 50px;
                    font-size: 16px;
                }
            }

            /* Animation for header elements */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .header-content > * {
                animation: fadeInUp 0.6s ease forwards;
            }

            .header-content > *:nth-child(1) { animation-delay: 0.1s; }
            .header-content > *:nth-child(2) { animation-delay: 0.2s; }
            .header-content > *:nth-child(3) { animation-delay: 0.3s; }
        </style>
    </head>
    <header class="modern-header">
        <div class="container-fluid">
            <div class="row header-content">
                <!-- Logo Section -->
                <div class="col-sm-4 col-lg-3 text-center text-sm-start">
                    <div class="main-logo">
                        <a href="${pageContext.request.contextPath}/homePage">
                            <img src="logo.png" width="60px" height="60px" alt="logo" class="img-fluid">
                        </a>
                    </div>
                </div>

                <!-- Search Section -->
                <div class="col-sm-6 offset-sm-2 offset-md-0 col-lg-5 d-none d-lg-block">
                    <div class="search-container">
                        <div class="search-bar row align-items-center">
                            <div class="col-11">
                            <form id="search-form" action="productList" method="GET">
                                    <input type="text" name="query" class="form-control search-input"
                                           placeholder="🔍 Search for more than 20,000 products..."
                                       value="<%= session.getAttribute("query") != null ? session.getAttribute("query") : "" %>">
                                <button type="submit" style="display: none;"></button>
                            </form>
                        </div>
                        <div class="col-1">
                                <div class="search-icon-container" id="search-icon">
                                    <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24">
                            <path fill="currentColor" d="M21.71 20.29L18 16.61A9 9 0 1 0 16.61 18l3.68 3.68a1 1 0 0 0 1.42 0a1 1 0 0 0 0-1.39ZM11 18a7 7 0 1 1 7-7a7 7 0 0 1-7 7Z"/>
                            </svg>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Actions Section -->
                <div class="col-sm-8 col-lg-4 d-flex justify-content-end align-items-center mt-4 mt-sm-0">
                    <div class="header-actions">
                        <!-- User Profile -->
                            <c:if test="${sessionScope.acc != null}">  
                            <a href="./view_information" class="action-button" title="User Profile">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                                    <path fill="currentColor" d="M15.71 12.71a6 6 0 1 0-7.42 0a10 10 0 0 0-6.22 8.18a1 1 0 0 0 2 .22a8 8 0 0 1 15.9 0a1 1 0 0 0 1 .89h.11a1 1 0 0 0 .88-1.1a10 10 0 0 0-6.25-8.19ZM12 12a4 4 0 1 1 4-4a4 4 0 0 1-4 4Z"/>
                                    </svg>
                                </a>
                            </c:if>
                            <c:if test="${sessionScope.acc == null}">  
                            <a href="./View/Login/Login.jsp" class="action-button" title="Login">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                                    <path fill="currentColor" d="M15.71 12.71a6 6 0 1 0-7.42 0a10 10 0 0 0-6.22 8.18a1 1 0 0 0 2 .22a8 8 0 0 1 15.9 0a1 1 0 0 0 1 .89h.11a1 1 0 0 0 .88-1.1a10 10 0 0 0-6.25-8.19ZM12 12a4 4 0 1 1 4-4a4 4 0 0 1-4 4Z"/>
                                    </svg>
                                </a>
                            </c:if>

                        <!-- Shop Registration/Link -->
                        <c:if test="${sessionScope.acc != null && (sessionScope.shop == null || sessionScope.shop.status == 'Rejected')}">  
                            <a href="./View/UserPage/RegisterShop.jsp" class="shop-link">
                                🏪 Register Shop
                            </a>
                        </c:if>
                        <c:if test="${sessionScope.acc != null && sessionScope.shop != null && sessionScope.shop.status == 'Approved'}">  
                            <a href="${pageContext.request.contextPath}/view_product" class="shop-link">
                                🏪 My Shop
                            </a>
                        </c:if>

                        <!-- Mobile Search & Cart -->
                        <div class="d-lg-none">
                            <a href="#" class="action-button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasSearch" aria-controls="offcanvasSearch" title="Search">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                                    <path fill="currentColor" d="M21.71 20.29L18 16.61A9 9 0 1 0 16.61 18l3.68 3.68a1 1 0 0 0 1.42 0a1 1 0 0 0 0-1.39ZM11 18a7 7 0 1 1 7-7a7 7 0 0 1-7 7Z"/>
                                </svg>
                            </a>
                            <a href="#" class="action-button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasCart" aria-controls="offcanvasCart" title="Cart">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                                    <path fill="currentColor" d="M8.5 19a1.5 1.5 0 1 0 1.5 1.5A1.5 1.5 0 0 0 8.5 19ZM19 16H7a1 1 0 0 1 0-2h8.491a3.013 3.013 0 0 0 2.885-2.176l1.585-5.55A1 1 0 0 0 19 5H6.74a3.007 3.007 0 0 0-2.82-2H3a1 1 0 0 0 0 2h.921a1.005 1.005 0 0 1 .962.725l.155.545v.005l1.641 5.742A3 3 0 0 0 7 18h12a1 1 0 0 0 0-2Zm-1.326-9l-1.22 4.274a1.005 1.005 0 0 1-.963.726H8.754l-.255-.892L7.326 7ZM16.5 19a1.5 1.5 0 1 0 1.5 1.5a1.5 1.5 0 0 0-1.5-1.5Z"/>
                                </svg>
                            </a>
                        </div>

                        <!-- Desktop Cart -->
                        <div class="cart-container d-none d-lg-block">
                            <button class="cart-button" type="button" onclick="window.location.href = '${pageContext.request.contextPath}/cart'">
                                🛒 <span id="cart-count" class="cart-count">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
                        </button>
                        </div>

                        <!-- Logout -->
                        <c:if test="${sessionScope.acc != null}"> 
                            <a href="LogOutController" class="logout-link">
                                🚪 Logout
                            </a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>   
    </header>

    <script>
        // Search functionality
        document.getElementById("search-icon").addEventListener("click", function () {
            document.getElementById("search-form").submit();
        });

        document.getElementById("search-icon").addEventListener("keypress", function (event) {
            if (event.key === "Enter" || event.key === " ") {
                document.getElementById("search-form").submit();
            }
        });

        // Cart count update
                    <c:if test="${not empty sessionScope.acc}">
                                    function updateCartCount() {
                                        $.ajax({
                                            url: "${pageContext.request.contextPath}/homePage",
                                            type: "GET",
                                            dataType: "json",
                                            success: function (data) {
                                                $("#cart-count").text(data.cartCount);
                                            },
                                            error: function (xhr, status, error) {
                                                console.error("Lỗi khi lấy số lượng giỏ hàng:", error);
                                            }
                                        });
                                    }

                                    $(document).ready(function () {
                                        updateCartCount();
                                    });
                    </c:if>
                    <c:if test="${empty sessionScope.acc}">
                        <% session.removeAttribute("cartCount"); %> 
                    </c:if>
    </script>
</html>
