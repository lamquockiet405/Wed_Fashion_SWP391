<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/vendor.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Open+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            <%@ include file="ProductListCSS.css" %>
        </style>
    </head>
    <body>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <div id="Header"></div>
        <div class="main-container">
            <aside class="category-section">

                <div class="category-filter">
                    <h5>SEARCH FILTERS</h5>
                    <h6>By Category</h6>
                    <select id="categorySelect" class="form-select">
                        <option value="">By Category</option>
                        <c:forEach var="ct" items="${requestScope.ListCategories}">
                            <option value="${ct.categoryID}" 
                                    ${param.categoryID == ct.categoryID ? 'selected' : ''}>
                                ${ct.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="price-filter">
                    <h6>Price Range</h6>
                    <form id="priceForm" action="productList" method="GET">
                        <!-- Hidden input để giữ lại categoryID khi submit -->
                        <input type="hidden" name="categoryID" id="hiddenCategoryID" value="${param.categoryID}">

                        <input type="number" name="minPrice" id="minPrice" placeholder="$ from"
                               style="width: 45%; margin-right: 5%;"  
                               value="${param.minPrice}" min="0" >

                        <input type="number" name="maxPrice" id="maxPrice" placeholder="$ to"
                               style="width: 45%;"  
                               value="${param.maxPrice}" min="1">
                        <button type="submit" style="width: 100%; background: red; color: white; padding: 5px; margin-top: 5px; border: none; border-radius: 3px;">
                            APPLY
                        </button>
                    </form>
                </div>


                <!--                <div class="extra-filter">
                                    <h6>Thêm Bộ Lọc</h6>
                                    <ul>
                                        <li><input type="checkbox" class="filter-checkbox"> Đánh giá cao</li>
                                        <li><input type="checkbox" class="filter-checkbox"> Giao hàng nhanh</li>
                                        <li><input type="checkbox" class="filter-checkbox"> Giá dưới 100k</li>
                                    </ul>
                                </div>-->
                <button class="clear-filters" onclick="clearAllFilters()">Clean</button>
                <script>
                    function clearAllFilters() {
                        var url = new URL(window.location.href);

                        // Xóa tất cả các tham số
                        url.search = "";

                        // Reload lại trang với URL sạch
                        window.location.href = url.toString();
                    }
                </script>
                <style>
                    .category-section {
                        position: sticky;
                        top: 20px; /* Giữ khoảng cách với phần trên */
                        left: 0;
                        width: 260px; /* Điều chỉnh theo giao diện */
                        height: auto; /* Tự động co giãn */
                        background: white;
                        padding: 15px;
                        border-radius: 8px; /* Bo góc đẹp hơn */
                        box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1); /* Hiệu ứng bóng */
                        z-index: 1000;
                        .category-section {
                            transition: all 0.3s ease-in-out;
                        }
                    }
                </style>


            </aside>
            <section class="product-section" class="product-section" style="background-color: #f8f9fa; padding: 20px;">
                <div class="container-fluid">
                    <div class="bootstrap-tabs product-tabs">
                        <div class="d-flex justify-content-start w-100">
                            <div class="sort-options">
                                <span class="me-2">Sort by</span>
                                <button class="btn sort-btn" data-sort="newest" ${param.sort == 'newest' ? 'style="background: red; color: white;"' : ''}>Newest</button>

                                <div class="dropdown">
                                    <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown">Price</button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item sort-btn" data-sort="price_asc" href="#">Price: Low to High</a></li>
                                        <li><a class="dropdown-item sort-btn" data-sort="price_desc" href="#">Price: High to Low</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- iteam product-->
                    <script>
                        function updateURLParams(param, value) {
                            var url = new URL(window.location.href);
                            if (value) {
                                url.searchParams.set(param, value);
                            } else {
                                url.searchParams.delete(param);
                            }
                            window.location.href = url.toString();
                        }

                        // Khi chọn danh mục
                        document.getElementById("categorySelect").addEventListener("change", function () {
                            updateURLParams("categoryID", this.value);
                        });

                        // Khi bấm nút "Áp dụng" (lọc )
                        document.getElementById("priceForm").addEventListener("submit", function (event) {
                            event.preventDefault(); // Chặn hành động mặc định để cập nhật URL
                            var minPrice = document.getElementById("minPrice").value;
                            var maxPrice = document.getElementById("maxPrice").value;
                            var categoryID = document.getElementById("categorySelect").value;

                            var url = new URL(window.location.href);

                            if (categoryID) {
                                url.searchParams.set("categoryID", categoryID);
                            } else {
                                url.searchParams.delete("categoryID");
                            }

                            if (minPrice) {
                                url.searchParams.set("minPrice", minPrice);
                            } else {
                                url.searchParams.delete("minPrice");
                            }

                            if (maxPrice) {
                                url.searchParams.set("maxPrice", maxPrice);
                            } else {
                                url.searchParams.delete("maxPrice");
                            }

                            window.location.href = url.toString();
                        });

                        // Khi chọn sắp xếp
                        document.querySelectorAll(".sort-btn").forEach(button => {
                            button.addEventListener("click", function () {
                                updateURLParams("sort", this.getAttribute("data-sort"));
                            });
                        });
                    </script>



                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="nav-all" role="tabpanel" aria-labelledby="nav-all-tab">
                            <div class="product-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5">

                                <c:forEach var="product" items="${requestScope.MenuChose}">
                                    <div class="product-card">
                                        <div class="product-image">
                                            <c:forEach var="img" items="${requestScope.Listimage}">
                                                <c:if test="${img.productID == product.productID}">
                                                    <a href="product_detail?productID=${product.productID}">
                                                        <img src="${img.image}" alt="${product.productName}">
                                                    </a>
                                                    <c:remove var="img"/>  <!-- Thoát khỏi vòng lặp sau khi tìm được ảnh -->
                                                </c:if>
                                            </c:forEach>
                                        </div>

                                        <div class="product-info">
                                            <h5 class="product-title" style="font-size: 10px; word-wrap: break-word; overflow-wrap: break-word; white-space: normal;">
                                                ${product.productName}
                                            </h5>
                                            <div class="price-info">
                                                <c:forEach var="price" items="${requestScope.Listprice}">
                                                    <c:if test="${price.productID == product.productID}">
                                                        <span class="price" data-price="${price.priceMin}">$${price.priceMin}</span>
                                                    </c:if>
                                                </c:forEach>
                                            </div>

                                            <script>
                                                document.addEventListener("DOMContentLoaded", function () {
                                                    function formatPrice(number) {
                                                        return number.toLocaleString("en-US"); // Định dạng số có dấu phẩy
                                                    }

                                                    function updatePrice(element, value) {
                                                        // Kiểm tra nếu giá trị mới giống giá trị cũ thì không cập nhật lại
                                                        let currentValue = parseFloat(element.dataset.current || "0");
                                                        if (Math.floor(currentValue) === Math.floor(value))
                                                            return;

                                                        element.innerText = "$" + formatPrice(value);
                                                        element.dataset.current = value; // Lưu giá trị để tránh cập nhật lại không cần thiết
                                                    }

                                                    function animatePrice(element, value) {
                                                        let currentValue = parseFloat(element.dataset.current || "0");

                                                        // Nếu giá trị mới không đổi, không cần chạy lại hiệu ứng
                                                        if (Math.floor(currentValue) === Math.floor(value))
                                                            return;

                                                        let start = currentValue || 0;
                                                        let duration = 1000;
                                                        let step = (value - start) / (duration / 10);

                                                        let interval = setInterval(() => {
                                                            start += step;
                                                            if (start >= value) {
                                                                start = value;
                                                                clearInterval(interval);
                                                            }
                                                            element.innerText = "$" + formatPrice(Math.floor(start));
                                                        }, 10);

                                                        element.dataset.current = value;
                                                    }

                                                    function updateTotal() {
                                                        let total = 0;
                                                        let count = 0;

                                                        document.querySelectorAll(".item-checkbox:checked").forEach(item => {
                                                            let row = item.closest("tr");
                                                            let price = parseFloat(row.dataset.price.replace(/,/g, "")) || 0;
                                                            let quantity = parseInt(row.querySelector(".quantity").value) || 0;
                                                            let itemTotal = price * quantity;

                                                            let itemTotalElement = row.querySelector(".item-total");
                                                            updatePrice(itemTotalElement, itemTotal); // Cập nhật số trực tiếp, không hiệu ứng

                                                            total += itemTotal;
                                                            count += quantity;
                                                        });

                                                        let totalPriceElement = document.getElementById("total-price");
                                                        animatePrice(totalPriceElement, total); // Chỉ total-price có hiệu ứng

                                                        document.getElementById("total-items").innerText = count;
                                                    }

                                                    // Chạy hiệu ứng ban đầu cho giá trị có sẵn
                                                    document.querySelectorAll(".price, .total-price").forEach(priceElement => {
                                                        let priceValue = priceElement.dataset.price;
                                                        if (priceValue) {
                                                            let priceNumber = parseFloat(priceValue.replace(/,/g, ""));
                                                            if (!isNaN(priceNumber)) {
                                                                animatePrice(priceElement, priceNumber);
                                                            }
                                                        }
                                                    });

                                                    // Item-total chỉ cập nhật số, không chạy hiệu ứng
                                                    document.querySelectorAll(".item-total").forEach(priceElement => {
                                                        let priceValue = priceElement.dataset.price;
                                                        if (priceValue) {
                                                            let priceNumber = parseFloat(priceValue.replace(/,/g, ""));
                                                            if (!isNaN(priceNumber)) {
                                                                updatePrice(priceElement, priceNumber);
                                                            }
                                                        }
                                                    });

                                                    // Gán sự kiện cho checkbox và quantity
                                                    document.querySelectorAll(".item-checkbox, .quantity").forEach(input => {
                                                        input.addEventListener("change", updateTotal);
                                                    });
                                                });

                                            </script>
                                            <style>.price {
                                                    display: inline-block;
                                                    font-size: 24px;
                                                    font-weight: bold;
                                                    color: red;
                                                    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
                                                    transition: transform 0.3s ease-in-out;
                                                }

                                                .price:hover {
                                                    transform: scale(1.1);
                                                }</style>

                                            <c:forEach var="ct" items="${requestScope.ListCategories}">
                                                <c:if test="${ct.categoryID == product.categoryID}">
                                                    <div class="tags">
                                                        <span class="tag">${ct.categoryName}</span>
                                                    </div>
                                                    <c:remove var="ct"/>
                                                </c:if>
                                            </c:forEach>
                                            <c:forEach var="TotalOrder" items="${requestScope.TotalOrder}">
                                                <c:if test="${product.productID == TotalOrder.productID}">
                                                    <div class="location" style="font-size: 9px;">Number of products sold: ${TotalOrder.quantity}</div>

                                                </c:if>
                                            </c:forEach>

                                            <c:forEach var="shops" items="${requestScope.Shop}">
                                                <c:if test="${shops.id == product.shopId}">
                                                    <c:forEach var="user" items="${requestScope.ListUsers}">
                                                        <c:if test="${shops.userId == user.userID}">
                                                            <div class="location" style="font-size: 9px;">📍 ${user.address}</div>

                                                        </c:if>
                                                    </c:forEach>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:forEach>

                            </div> 
                        </div>
                    </div>
                    <!--end iteam-->

                </div>
            </section>
        </div>








        <div id="Footer"></div> <!-- Nơi sẽ load Footer.jsp -->
        <script src="${pageContext.request.contextPath}/js/jquery-1.11.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/js/script.js"></script>
        <script>
                                                async function loadComponent(id, file) {
                                                    const response = await fetch(file);
                                                    const content = await response.text();
                                                    document.getElementById(id).innerHTML = content;
                                                }

                                                loadComponent("Header", "${pageContext.request.contextPath}/View/Header/Header.jsp");
                                                loadComponent("Footer", "${pageContext.request.contextPath}/View/Footer/Footer.jsp");
        </script>
    </body>

</html>
