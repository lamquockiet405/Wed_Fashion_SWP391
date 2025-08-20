<%-- 
    Document   : Checkout
    Created on : Mar 19, 2025, 2:27:37 AM
    Author     : lenovo
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thanh Toán - EZShop</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #667eea;
                --secondary-color: #764ba2;
                --success-color: #28a745;
                --danger-color: #dc3545;
                --warning-color: #ffc107;
                --info-color: #17a2b8;
                --light-color: #f8f9fa;
                --dark-color: #343a40;
                --border-radius: 12px;
                --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                --transition: all 0.3s ease;
            }

            body {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                min-height: 100vh;
            }

            .checkout-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            .checkout-header {
                text-align: center;
                margin-bottom: 30px;
                color: var(--dark-color);
            }

            .checkout-header h1 {
                font-size: 2.5rem;
                font-weight: 700;
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 10px;
            }

            .checkout-header p {
                color: #6c757d;
                font-size: 1.1rem;
            }

            .checkout-card {
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                margin-bottom: 25px;
                overflow: hidden;
                transition: var(--transition);
            }

            .checkout-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            }

            .card-header {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                padding: 20px 25px;
                font-weight: 600;
                font-size: 1.1rem;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .card-body {
                padding: 25px;
            }

            .address-info {
                background: #f8f9fa;
                border-radius: 8px;
                padding: 20px;
                border-left: 4px solid var(--primary-color);
            }

            .address-info p {
                margin-bottom: 8px;
                color: #495057;
            }

            .address-info strong {
                color: var(--dark-color);
            }

            .change-address-btn {
                background: var(--primary-color);
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 6px;
                font-size: 0.9rem;
                transition: var(--transition);
                margin-top: 10px;
            }

            .change-address-btn:hover {
                background: var(--secondary-color);
                transform: translateY(-1px);
            }

            .product-card {
                background: white;
                border: 1px solid #e9ecef;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 15px;
                display: flex;
                align-items: center;
                gap: 20px;
                transition: var(--transition);
            }

            .product-card:hover {
                border-color: var(--primary-color);
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.1);
            }

            .product-image {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 8px;
                border: 2px solid #e9ecef;
            }

            .product-details {
                flex: 1;
            }

            .product-name {
                font-weight: 600;
                color: var(--dark-color);
                margin-bottom: 5px;
                font-size: 1.1rem;
            }

            .product-price {
                color: var(--primary-color);
                font-weight: 600;
                font-size: 1.2rem;
            }

            .product-quantity {
                background: #e9ecef;
                color: #495057;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 0.9rem;
                font-weight: 500;
            }

            .product-total {
                font-weight: 700;
                color: var(--success-color);
                font-size: 1.3rem;
            }

            .payment-methods {
                display: grid;
                gap: 15px;
            }

            .payment-option {
                background: #f8f9fa;
                border: 2px solid #e9ecef;
                border-radius: 10px;
                padding: 15px;
                cursor: pointer;
                transition: var(--transition);
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .payment-option:hover {
                border-color: var(--primary-color);
                background: #f0f4ff;
            }

            .payment-option input[type="radio"] {
                width: 20px;
                height: 20px;
                accent-color: var(--primary-color);
            }

            .payment-option input[type="radio"]:checked + label {
                color: var(--primary-color);
                font-weight: 600;
            }

            .payment-option label {
                margin: 0;
                cursor: pointer;
                font-size: 1rem;
                color: #495057;
            }

            .total-section {
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
                border-radius: var(--border-radius);
                padding: 25px;
                text-align: center;
            }

            .total-label {
                font-size: 1.1rem;
                margin-bottom: 10px;
                opacity: 0.9;
            }

            .total-amount {
                font-size: 2.5rem;
                font-weight: 700;
                margin: 0;
            }

            .confirm-order-btn {
                background: linear-gradient(135deg, var(--success-color), #20c997);
                color: white;
                border: none;
                padding: 15px 30px;
                border-radius: var(--border-radius);
                font-size: 1.1rem;
                font-weight: 600;
                width: 100%;
                transition: var(--transition);
                margin-top: 20px;
            }

            .confirm-order-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3);
            }

            /* Login Required Message */
            .login-required-message {
                margin: 20px 0;
            }

            .login-required-message .alert {
                border: none;
                border-radius: var(--border-radius);
                padding: 20px;
                display: flex;
                align-items: center;
                gap: 15px;
                background: linear-gradient(135deg, #fff3cd, #ffeaa7);
                color: #856404;
                border-left: 4px solid #ffc107;
            }

            .login-required-message .alert i {
                font-size: 24px;
                color: #f39c12;
            }

            .login-required-message .btn {
                background: linear-gradient(135deg, #007bff, #0056b3);
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                color: white;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .login-required-message .btn:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
                color: white;
                text-decoration: none;
            }

            /* Modal Styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                backdrop-filter: blur(5px);
            }

            .modal.show {
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .modal-content {
                background: white;
                border-radius: var(--border-radius);
                padding: 30px;
                max-width: 500px;
                width: 90%;
                max-height: 80vh;
                overflow-y: auto;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            }

            .address-item {
                background: #f8f9fa;
                border: 2px solid #e9ecef;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 10px;
                cursor: pointer;
                transition: var(--transition);
            }

            .address-item:hover {
                border-color: var(--primary-color);
                background: #f0f4ff;
            }

            .address-item input[type="radio"]:checked + label {
                border-color: var(--primary-color);
                background: #f0f4ff;
            }

            .modal-actions {
                display: flex;
                gap: 15px;
                margin-top: 20px;
            }

            .modal-actions .btn {
                flex: 1;
                padding: 12px;
                border-radius: 8px;
                border: none;
                font-weight: 600;
                transition: var(--transition);
            }

            .btn.cancel {
                background: #6c757d;
                color: white;
            }

            .btn.confirm {
                background: var(--primary-color);
                color: white;
            }

            .btn:hover {
                transform: translateY(-1px);
            }

            .error-message {
                background: #f8d7da;
                color: #721c24;
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 20px;
                border-left: 4px solid #dc3545;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .checkout-container {
                    padding: 15px;
                }

                .checkout-header h1 {
                    font-size: 2rem;
                }

                .product-card {
                    flex-direction: column;
                    text-align: center;
                    gap: 15px;
                }

                .product-image {
                    width: 100px;
                    height: 100px;
                }

                .modal-content {
                    margin: 20px;
                    width: calc(100% - 40px);
                }
            }
        </style>
    </head>
    <body>
        <div id="Header"></div>
        
        <div class="checkout-container">
            <div class="checkout-header">
                <h1><i class="fas fa-shopping-cart"></i> Checkout</h1>
                <p>Complete your purchase securely</p>
            </div>

            <!-- Kiểm tra user đã đăng nhập chưa -->
            <c:if test="${sessionScope.acc == null}">
                <div class="login-required-message">
                    <div class="alert alert-warning" role="alert">
                        <i class="fas fa-exclamation-triangle"></i>
                        <strong>Login Required!</strong> Please login to complete your order.
                        <a href="${pageContext.request.contextPath}/View/Login/Login.jsp" class="btn btn-primary ms-3">
                            <i class="fas fa-sign-in-alt"></i> Login Now
                        </a>
                    </div>
                </div>
            </c:if>

            <c:if test="${sessionScope.acc != null}">
            <form action="CreateBill" method="POST">
                <!-- Địa chỉ nhận hàng -->
                <div class="checkout-card">
                    <div class="card-header">
                        <i class="fas fa-map-marker-alt"></i>
                        Shipping Address
                    </div>
                    <div class="card-body">
                        <c:forEach var="sa" items="${ShippingAddressesList}">
                            <c:if test="${sa.status == 'true'}">
                                <div class="address-info">
                                    <p><strong><i class="fas fa-user"></i> Receiver:</strong> <span id="receiver-name" name="username">${sa.username}</span></p>
                            <input hidden="" name="username" value="${sa.username}">

                                    <p><strong><i class="fas fa-phone"></i> Phone:</strong> <span id="phone-number">${sa.phoneNumber}</span></p>
                                    <p><strong><i class="fas fa-home"></i> Address:</strong> <span id="selected-address" name="shippingAddress">${sa.address}</span></p>
                                <input hidden="" name="shippingAddress" value="${sa.address}">

                                    <button type="button" class="change-address-btn" onclick="openAddressModal()">
                                        <i class="fas fa-edit"></i> Change Address
                                    </button>
                                </div>
                        </c:if>
                    </c:forEach>
                    </div>
                </div>

                <!-- Sản phẩm -->
                <div class="checkout-card">
                    <div class="card-header">
                        <i class="fas fa-box"></i>
                        Order Items
                    </div>
                    <div class="card-body">
                            <c:set var="totalBill" value="0" />
                            <c:forEach var="vq" items="${variantList}" varStatus="status">
                                <c:set var="pvl" value="${productVariantList[status.index]}" />
                            <input type="hidden" name="pvId" value="${pvl.productVariantID}" />
                            
                            <div class="product-card">
                                <img class="product-image" name="pvImage" src="${pvl.image}" alt="Product Image">
                                    <input hidden="" name="pvImage" value="${pvl.image}">
                                
                                    <div class="product-details">
                                    <div class="product-name" name="pvName">${pvl.productVariantName}</div>
                                        <input hidden="" name="pvName" value="${pvl.productVariantName}">
                                    <div class="product-price">
                                        $<fmt:formatNumber value="${pvl.price}" pattern="#,###"/>
                                    </div>
                                    <input type="hidden" name="price" value="${pvl.price}">
                                </div>
                                
                                <div class="product-quantity">
                                    <i class="fas fa-times"></i> ${vq.quantity}
                                </div>
                                    <input hidden="" name="quantity" value="${vq.quantity}">

                                <div class="product-total">
                                    $<fmt:formatNumber value="${vq.quantity * pvl.price}" pattern="#,###"/>
                                </div>
                            </div>
                                <c:set var="totalBill" value="${totalBill + (pvl.price * vq.quantity)}" />
                        </c:forEach>
                    </div>
                </div>

                <!-- Phương thức thanh toán -->
                <div class="checkout-card">
                    <div class="card-header">
                        <i class="fas fa-credit-card"></i>
                        Payment Method
                    </div>
                    <div class="card-body">
                    <div class="payment-methods">
                        <c:forEach var="pm" items="${PaymentMethodList}" varStatus="loop">
                            <c:if test="${pm.status == '1'}">
                                    <div class="payment-option">
                                    <input type="radio" class="form-check-input" 
                                           name="paymentMethod" 
                                           id="pm_${pm.paymentMethod}" 
                                           value="${pm.paymentMethod}" 
                                           required=""
                                               ${loop.first ? 'checked' : ''}>
                                        <label for="pm_${pm.paymentMethod}">
                                            <i class="fas fa-credit-card"></i> ${pm.paymentMethod}
                                    </label>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                </div>

                <!-- Tổng thanh toán -->
                <div class="total-section">
                    <div class="total-label">Total Amount</div>
                    <div class="total-amount" id="total-price" name="totalAmount">
                        $<fmt:formatNumber value="${totalBill}" pattern="#,###"/>
                    </div>
                    <input type="hidden" name="totalAmount" value="${totalBill}">
                </div>

                <!-- Nút đặt hàng -->
                <button type="submit" class="confirm-order-btn" id="place-order">
                    <i class="fas fa-check"></i> Confirm Order
                </button>
            </form>
            </c:if>

            <!-- Modal chọn địa chỉ -->
            <div id="address-modal" class="modal">
                <div class="modal-content">
                    <div class="card-header">
                        <i class="fas fa-map-marker-alt"></i>
                        Select Address
                    </div>

                    <div class="address-list">
                        <c:forEach var="sa" items="${ShippingAddressesList}">
                            <div class="address-item">
                                <label class="address-label">
                                    <div class="address-info">
                                        <p><strong class="receiver-name">${sa.username}</strong></p>
                                        <p>Phone: <span class="phone-number">${sa.phoneNumber}</span></p>
                                        <p>Address: <span class="full-address">${sa.address}</span></p>
                                    </div>
                                    <input type="radio" name="selectedAddress" value="${sa.id}" 
                                           <c:if test="${sa.status == 'true'}">checked</c:if> />
                                    </label>
                                </div>
                        </c:forEach>
                    </div>
                    
                    <div class="modal-actions">
                        <button class="btn cancel" onclick="closeAddressModal()">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                        <button class="btn confirm" onclick="confirmAddress()">
                            <i class="fas fa-check"></i> Confirm
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div id="Footer"></div>

        <script>
            function confirmAddress() {
                let selectedRadio = $("input[name='selectedAddress']:checked");
                let selectedAddress = selectedRadio.val();

                if (!selectedAddress) {
                    alert("Please select an address!");
                    return;
                }

                $.ajax({
                    url: "/Ecommerce_SWP/ChooseAddress",
                    type: "POST",
                    data: {confirmedAddress: selectedAddress},
                    success: function (response) {
                        let addressInfo = selectedRadio.closest(".address-label").find(".address-info");
                        let receiverName = addressInfo.find(".receiver-name").text();
                        let phoneNumber = addressInfo.find(".phone-number").text();
                        let address = addressInfo.find(".full-address").text();

                        $("#receiver-name").text(receiverName);
                        $("#phone-number").text(phoneNumber);
                        $("#selected-address").text(address);

                        closeAddressModal();
                    },
                    error: function (xhr, status, error) {
                        console.error("Failed to send Address:", error);
                    }
                });
            }

            function openAddressModal() {
                $("#address-modal").addClass("show");
            }

            function closeAddressModal() {
                $("#address-modal").removeClass("show");
            }

            // Close modal when clicking outside
            $(document).on('click', '.modal', function(e) {
                if (e.target === this) {
                    closeAddressModal();
                }
            });
        </script>

        <script>
            async function loadComponent(id, file) {
                const response = await fetch(file);
                const content = await response.text();
                document.getElementById(id).innerHTML = content;
            }

            loadComponent("Header", "./View/Header/Header.jsp");
            loadComponent("Footer", "./View/Footer/Footer.jsp");
        </script>

        <script>
            $(document).ready(function () {
                // Payment method selection
                $(".payment-option").click(function () {
                    $(".payment-option").removeClass("active");
                    $(this).addClass("active");
                    $(this).find('input[type="radio"]').prop('checked', true);
                });

                // Show error message if exists
                const urlParams = new URLSearchParams(window.location.search);
                const message = urlParams.get("error");
                if (message) {
                    const errorDiv = $('<div class="error-message"><i class="fas fa-exclamation-triangle"></i> ' + message + '</div>');
                    $('.checkout-header').after(errorDiv);
                }
            });
        </script>
    </body>
</html>