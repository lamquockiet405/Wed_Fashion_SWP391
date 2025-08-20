<%-- 
    Document   : Cart
    Created on : Mar 12, 2025, 10:40:31 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="Model.Chinh.Cart" %>
<%@page import="Model.Chinh.Products" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <title>Shopping Cart</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/View/Cart/CartCSS.css">
    </head>
    <body>
        <div id="Header"></div>
        <div class="container mt-4">
            <h2 class="text-center">SHOPPING CART</h2>
            
            <!-- Kiểm tra user đã đăng nhập chưa -->
            <c:if test="${sessionScope.acc == null}">
                <div class="login-required-container">
                    <div class="alert alert-warning text-center" role="alert">
                        <i class="fas fa-exclamation-triangle fa-2x mb-3"></i>
                        <h4>Login Required!</h4>
                        <p>Please login to view your shopping cart and place orders.</p>
                        <a href="${pageContext.request.contextPath}/View/Login/Login.jsp" class="btn btn-primary btn-lg">
                            <i class="fas fa-sign-in-alt"></i> Login Now
                        </a>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${sessionScope.acc != null}">
            <form id="cart-form" action="CreateOrders" method="get">
                <div class="cart-container">
                    <table class="table table-bordered cart-table">
                        <thead class="table-warning">
                            <tr>
                                <th><input type="checkbox" id="select-all">SELECT ALL</th>
                                <th>Product</th>
                                <th>Product Variant</th>
                                <th>Unit Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cart" items="${requestScope.Carts}">
                                <c:forEach var="variant" items="${requestScope.variant}">
                                    <c:if test="${cart.productVariantID == variant.productVariantID}">
                                        <tr class="cart-item" data-price="${variant.price}" data-cartid="${cart.cartID}">
                                            <td>
                                                <input type="checkbox" class="item-checkbox" onchange="updateTotal()" ${variant.stockQuantity == 0 ? 'disabled' : ''}>
                                            </td>
                                            <td>
                                                <img src="${variant.getImage()}" class="img-thumbnail" style="width: 80px;">
                                                <c:forEach var="product" items="${requestScope.Products}">
                                                    <c:if test="${product.productID == variant.productID}">
                                                        <p class="mb-0">${product.productName}</p>
                                                    </c:if>
                                                </c:forEach>
                                                <p class="text-danger">${variant.stockQuantity == 0 ? "Temporarily out of stock!!!" : ""}</p>
                                            </td>
                                            <td>${variant.getProductVariantName()}</td>
                                            <td class="price" data-price="${variant.price}"></td>
                                            <td>
                                                <div class="quantity-container">
                                                    <button type="button" class="btn btn-sm btn-outline-secondary"
                                                            onclick="changeQuantity(this, -1, ${cart.cartID}, ${variant.stockQuantity})"
                                                            ${variant.stockQuantity == 0 ? 'disabled' : ''}>-</button>
                                                    <input type="number" class="quantity text-center" value="${cart.quantity}" min="1"
                                                           onchange="updateTotal()"
                                                           oninput="validateAndUpdateQuantity(this, ${cart.cartID}, ${variant.stockQuantity})"
                                                           ${variant.stockQuantity == 0 ? 'disabled' : ''}>
                                                    <button type="button" class="btn btn-sm btn-outline-secondary"
                                                            onclick="changeQuantity(this, 1, ${cart.cartID}, ${variant.stockQuantity})"
                                                            ${variant.stockQuantity == 0 ? 'disabled' : ''}>+</button>
                                                </div>
                                            </td>
                                            <td class="item-total" data-price="${cart.quantity * variant.price}"></td>
                                            <td><button type="button" class="btn btn-danger btn-sm" onclick="removeItem(${cart.cartID})">DELETE</button></td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <input type="hidden" name="cartIDs" id="cartIDs">

                <div class="cart-footer">
                    <div>
                        DELETE All SELECT | <button type="button" class="btn btn-danger btn-sm" onclick="deleteSelectedItems()">Delete</button>
                    </div>
                    <div>
                        Total payment (<span id="total-items">0</span> Products): 
                        <span id="total-price" class="total-price" data-price="0">$0</span>
                    </div>
                    <button type="submit" class="btn btn-primary" onclick="prepareCartForm(event)">Purchase</button>
                </div>
            </form>
            </c:if>
        </div>
        <div id="Footer"></div>

        <script>document.addEventListener("DOMContentLoaded", function () {
                function formatPrice(number) {
                    return new Intl.NumberFormat('en-US', {
                        style: 'currency',
                        currency: 'USD',
                        minimumFractionDigits: 2,
                        maximumFractionDigits: 2
                    }).format(number);
                }

                function animatePrice(element, value) {
                    let start = 0;
                    let duration = 1000; // 1 giây
                    let step = (value - start) / (duration / 10);

                    let interval = setInterval(() => {
                        start += step;
                        if (start >= value) {
                            start = value;
                            clearInterval(interval);
                        }
                        element.textContent = formatPrice(start);
                    }, 10);
                }

                function updateTotal() {
                    let total = 0;
                    let count = 0;

                    document.querySelectorAll(".item-checkbox:checked").forEach(item => {
                        let row = item.closest("tr");
                        let price = parseFloat(row.dataset.price.replace(/,/g, "")) || 0;
                        let quantity = parseInt(row.querySelector(".quantity").value) || 0;
                        let itemTotal = price * quantity;

                        // Cập nhật unit price
                        let priceElement = row.querySelector(".price");
                        if (priceElement) {
                            priceElement.textContent = formatPrice(price);
                        }

                        // Cập nhật item-total có dấu phẩy
                        let itemTotalElement = row.querySelector(".item-total");
                        if (itemTotalElement) {
                            itemTotalElement.textContent = formatPrice(itemTotal);
                        }

                        total += itemTotal;
                        count += quantity;
                    });

                    // Cập nhật total-price với hiệu ứng
                    let totalPriceElement = document.getElementById("total-price");
                    if (totalPriceElement) {
                        totalPriceElement.textContent = formatPrice(total);
                    }

                    document.getElementById("total-items").innerText = count;
                }

                // Áp dụng hiệu ứng ban đầu
                document.querySelectorAll(".price, .item-total, .total-price").forEach(priceElement => {
                    let priceValue = priceElement.dataset.price;
                    if (priceValue) {
                        let priceNumber = parseFloat(priceValue.replace(/,/g, ""));
                        if (!isNaN(priceNumber)) {
                            priceElement.textContent = formatPrice(priceNumber);
                        }
                    }
                });

                // Gán sự kiện cho checkbox và quantity
                document.querySelectorAll(".item-checkbox, .quantity").forEach(input => {
                    input.addEventListener("change", updateTotal);
                });
            });</script>




        <script>
            document.querySelectorAll(".item-checkbox:checked").forEach(item => {
                let row = item.closest("tr");
                console.log("Row found:", row);
                if (row) {
                    let cartID = row.getAttribute("data-cartid");
                    console.log("Extracted cartID:", cartID);
                }
            });

            function prepareCartForm(event) {
                event.preventDefault();

                let selectedCartItems = [];
                document.querySelectorAll(".item-checkbox:checked").forEach(item => {
                    let row = item.closest("tr");
                    if (row) {
                        let cartID = row.getAttribute("data-cartid");
                        let quantity = row.querySelector(".quantity").value;
                        console.log("Found cartID:", cartID, "Quantity:", quantity);
                        if (cartID && quantity) {
                            selectedCartItems.push(cartID + ":" + quantity); // Ghép cartID và quantity
                        }
                    }
                });

                console.log("Selected Cart Items:", selectedCartItems);

                if (selectedCartItems.length === 0) {
                    alert("Please select at least one product to purchase!");
                    return;
                }

                document.getElementById("cartIDs").value = selectedCartItems.join(","); // Ví dụ: "3:2,9:5,13:1"

                console.log("Hidden input value:", document.getElementById("cartIDs").value);

                document.getElementById("cart-form").submit();
            }




            async function loadComponent(id, file) {
                const response = await fetch(file);
                const content = await response.text();
                document.getElementById(id).innerHTML = content;
            }

            loadComponent("Header", "${pageContext.request.contextPath}/View/Header/Header.jsp");
            loadComponent("Footer", "${pageContext.request.contextPath}/View/Footer/Footer.jsp");



            function changeQuantity(button, amount, cartID, maxQuantity) {
                let input = button.parentElement.querySelector(".quantity");
                let newValue = parseInt(input.value) + amount;
                if (newValue >= 1) {
                    if (newValue > maxQuantity) {
                        alert("You have reached the maximum stock quantity!");
                        input.value = maxQuantity;
                    } else {
                        input.value = newValue;
                    }
                    updateTotal();
                    $.post("${pageContext.request.contextPath}/cart", {action: "update", cartID: cartID, quantity: input.value})
                        .done(function(data) {
                            if (data.success) {
                                // Update successful
                            } else if (data.redirect) {
                                // Nếu cần login, chuyển hướng trực tiếp
                                window.location.href = data.redirect;
                            }
                        })
                        .fail(function(xhr, status, error) {
                            console.error("Error updating quantity:", error);
                        });
                }
            }

            function removeItem(cartID) {
                console.log("=== removeItem Debug ===");
                console.log("CartID to delete:", cartID);
                console.log("Type of cartID:", typeof cartID);
                
                if (confirm("Are you sure you want to delete this item?")) {
                    console.log("User confirmed deletion, sending AJAX request...");
                    console.log("Request URL:", "${pageContext.request.contextPath}/cart");
                    console.log("Request data:", {action: "delete", cartID: cartID});
                    
                    $.post("${pageContext.request.contextPath}/cart", {action: "delete", cartID: cartID})
                        .done(function(data) {
                            console.log("Delete response received:", data);
                            if (data.success) {
                                console.log("Delete successful, reloading page...");
                                location.reload();
                            } else if (data.redirect) {
                                console.log("Redirect needed:", data.redirect);
                                // Nếu cần login, chuyển hướng trực tiếp
                                window.location.href = data.redirect;
                            } else {
                                console.log("Delete failed with message:", data.message);
                                alert("Delete failed: " + (data.message || "Unknown error"));
                            }
                        })
                        .fail(function(xhr, status, error) {
                            console.error("Delete AJAX failed:");
                            console.error("Status:", status);
                            console.error("Error:", error);
                            console.error("Response text:", xhr.responseText);
                            console.error("Response status:", xhr.status);
                            console.error("Response headers:", xhr.getAllResponseHeaders());
                            
                            // Nếu có redirect trong response, chuyển hướng
                            try {
                                let response = JSON.parse(xhr.responseText);
                                if (response.redirect) {
                                    console.log("Redirect from failed request:", response.redirect);
                                    window.location.href = response.redirect;
                                } else {
                                    alert("Delete failed! Please try again.");
                                }
                            } catch (e) {
                                console.error("Could not parse response as JSON:", e);
                                alert("Delete failed! Please try again.");
                            }
                        });
                } else {
                    console.log("User cancelled deletion");
                }
            }


            function deleteSelectedItems() {
                console.log("=== deleteSelectedItems Debug ===");
                
                let selected = $(".item-checkbox:checked").map(function () {
                    let cartID = $(this).closest("tr").data("cartid");
                    console.log("Found selected cartID:", cartID);
                    return cartID;
                }).get();

                console.log("Selected cartIDs:", selected);
                console.log("Number of selected items:", selected.length);

                if (selected.length > 0 && confirm("Are you sure you want to delete the selected items?")) {
                    console.log("User confirmed deletion of multiple items");
                    console.log("Sending AJAX request to delete:", selected);
                    
                    $.ajax({
                        url: "${pageContext.request.contextPath}/cart",
                        type: "POST",
                        data: {action: "deleteMultiple", cartIDs: selected},
                        traditional: true, // Quan trọng để gửi mảng đúng cách
                        success: function (data) {
                            console.log("Delete multiple response received:", data);
                            if (data.success) {
                                console.log("Delete multiple successful, reloading page...");
                                location.reload();
                            } else if (data.redirect) {
                                console.log("Redirect needed:", data.redirect);
                                // Nếu cần login, chuyển hướng trực tiếp
                                window.location.href = data.redirect;
                            } else {
                                console.log("Delete multiple failed with message:", data.message);
                                alert("Delete failed: " + (data.message || "Unknown error"));
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("Delete multiple AJAX failed:");
                            console.error("Status:", status);
                            console.error("Error:", error);
                            console.error("Response text:", xhr.responseText);
                            console.error("Response status:", xhr.status);
                            
                            // Nếu có redirect trong response, chuyển hướng
                            try {
                                let response = JSON.parse(xhr.responseText);
                                if (response.redirect) {
                                    console.log("Redirect from failed request:", response.redirect);
                                    window.location.href = response.redirect;
                                } else {
                                    alert("Delete failed! Please try again.");
                                }
                            } catch (e) {
                                console.error("Could not parse response as JSON:", e);
                                alert("Delete failed! Please try again.");
                            }
                        }
                    });
                } else {
                    console.log("No items selected or user cancelled deletion");
                }
            }
            function validateAndUpdateQuantity(input, cartID, maxQuantity) {
                let value = parseInt(input.value);
                if (isNaN(value) || value < 1) {
                    input.value = 1;
                } else if (value > maxQuantity) {
                    alert("You have reached the maximum stock quantity!");
                    input.value = maxQuantity;
                }
                updateTotal();
                $.post("${pageContext.request.contextPath}/cart", {action: "update", cartID: cartID, quantity: input.value})
                    .done(function(data) {
                        if (data.success) {
                            location.reload();
                        } else if (data.redirect) {
                            // Nếu cần login, chuyển hướng trực tiếp
                            window.location.href = data.redirect;
                        }
                    })
                    .fail(function(xhr, status, error) {
                        console.error("Error updating quantity:", error);
                    });
            }
            document.getElementById("select-all").addEventListener("change", function () {
                document.querySelectorAll(".item-checkbox").forEach(checkbox => checkbox.checked = this.checked);
                updateTotal();
            });
        </script>
    </body>
</html>
