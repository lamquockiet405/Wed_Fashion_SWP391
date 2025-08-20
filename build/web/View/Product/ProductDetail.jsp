<%-- 
    Document   : ProductDetail
    Created on : Feb 26, 2025, 4:21:08 PM
    Author     : Dell
--%>

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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/vendor.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Open+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="ProductDetailCSS.css">
    </head>
    <body>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <div id="Header"></div>


        <section>
            <div class="container">
                <div class="row gx-5">
                    <c:set var="product" value="${requestScope.Product}"/>
                    <aside class="col-lg-4"> <!-- Chỉnh lại từ col-lg-6 thành col-lg-4 để chiếm 1/3 -->

                        <div class="border-0 p-0 mb-3 d-flex justify-content-center bg-white">
                            <c:set var="img" value="${requestScope.ImagesDistinct}"/>
                            <a data-fslightbox="mygalley" class="w-100 h-100 d-flex align-items-center justify-content-center" target="_blank" data-type="image" 
                               href="">
                                <img style="width: 100%; height: auto; display: block;" class="fit" 
                                     src="${img}" />
                            </a>
                        </div>
                        <div class="mb-3 overflow-auto d-flex bg-white" style="max-width: 100%; white-space: nowrap;">
                            <c:forEach var="img" items="${requestScope.Listimage}">
                                <a class="border mx-1 p-1 bg-white" href="product_detail?productID=${product.productID}&img=${img.id}"><img width="80" height="80" src="${img.image}" /></a>
                                </c:forEach>
                        </div>


                    </aside>
                    <main class="col-lg-8 bg-white p-4"> <!-- Chỉnh lại từ col-lg-6 thành col-lg-8 để chiếm 2/3 -->
                        <div class="ps-lg-3">
                            <!--                            <span class="badge bg-danger text-white fw-bold">Yêu Thích</span>-->
                            <h4 class="title text-dark fw-bold">${product.productName}</h4>
                            <div class="d-flex flex-row my-3">
                                <div class="text-warning mb-1 me-2">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fas fa-star-half-alt"></i>
                                    <span class="ms-1" style="color: red !important;"></span>
                                </div>

                            </div>
                            <div class="mb-3">
                                <c:if test="${empty requestScope.Listprice}">
                                    <span class="h4 text-danger fw-bold price" 
                                          data-price="${sessionScope.VariantDetail.price}" 
                                          style="color: red !important;">
                                        $${sessionScope.VariantDetail.price}
                                    </span>
                                </c:if>
                                <c:forEach var="price" items="${requestScope.Listprice}">
                                    <c:if test="${price.productID == product.productID}">
                                        <c:choose>
                                            <c:when test="${price.priceMin == price.priceMax}">
                                                <span class="h4 text-danger fw-bold price"
                                                      data-price="${price.priceMin}"
                                                      style="color: red !important;">
                                                    $${price.priceMin}
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="h4 text-danger fw-bold price"
                                                      data-price="${price.priceMin}"
                                                      style="color: red !important;">
                                                    Min Price: $${price.priceMin}  
                                                </span>
                                                <span class="h4 text-danger fw-bold price"
                                                      data-price="${price.priceMax}"
                                                      style="color: red !important;">
                                                    Max Price: $${price.priceMax}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </c:forEach>
                            </div>
                            <script>document.addEventListener("DOMContentLoaded", function () {
                                    function formatPrice(number) {
                                        return number.toLocaleString("en-US"); // Định dạng số có dấu phẩy mỗi 3 chữ số
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
                                            element.innerText = "$" + formatPrice(Math.floor(start)); // Định dạng số
                                        }, 10);
                                    }

                                    document.querySelectorAll(".price").forEach(priceElement => {
                                        let priceValue = priceElement.dataset.price; // Lấy giá trị từ data-price
                                        let priceNumber = parseFloat(priceValue.replace(/,/g, "")); // Chuyển đổi chuỗi số thành float

                                        console.log("Price:", priceValue, "Parsed:", priceNumber); // Debug kiểm tra

                                        if (!isNaN(priceNumber)) {
                                            animatePrice(priceElement, priceNumber);
                                        }
                                    });
                                });</script>
                            <style>.price {
                                    display: block;
                                    font-size: 24px;
                                    font-weight: bold;
                                    color: red;
                                    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
                                    transition: transform 0.3s ease-in-out;
                                }

                                .price:hover {
                                    transform: scale(1.1);
                                }</style>

                            <div class="p-3 border bg-white">
                                <div class="row">
                                    <dt class="col-3 fw-bold">other products</dt>
                                    <dd class="col-9 d-flex flex-wrap gap-2">
                                        <c:forEach var="variant" items="${requestScope.Listvariant}">
                                            <c:choose>
                                                <c:when test="${variant.getStockQuantity() > 0}">
                                                    <%-- Nếu sản phẩm còn hàng, hiển thị link bình thường --%>
                                                    <a href="product_detail?productID=${product.productID}&variantID=${variant.getProductVariantID()}" 
                                                       class="btn btn-outline-secondary rounded d-flex align-items-center p-1 text-decoration-none variant-link
                                                       ${variant.getProductVariantID() == param.variantID ? 'selected' : ''}">
                                                        <img src="${variant.getImage()}" width="30" height="30" class="me-1"/> 
                                                        ${variant.getProductVariantName()}
                                                    </a>
                                                </c:when>

                                                <c:otherwise>
                                                    <%-- Nếu sản phẩm hết hàng, hiển thị thông báo khi bấm vào --%>
                                                    <a href="javascript:void(0);" 
                                                       class="btn btn-outline-secondary rounded d-flex align-items-center p-1 text-decoration-none variant-link"
                                                       onclick="alert('Sản phẩm này đã hết hàng!')"
                                                       style="opacity: 0.5;">
                                                        <img src="${variant.getImage()}" width="30" height="30" class="me-1"/> 
                                                        ${variant.getProductVariantName()}
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>



                                    </dd>
                                </div>
                                <script>
                                    document.addEventListener("DOMContentLoaded", function () {
                                        let urlParams = new URLSearchParams(window.location.search);
                                        let selectedVariantID = urlParams.get("variantID");

                                        if (selectedVariantID) {
                                            document.querySelectorAll(".variant-link").forEach(link => {
                                                if (link.href.includes("variantID=" + selectedVariantID)) {
                                                    link.classList.add("selected");
                                                } else {
                                                    link.classList.remove("selected");
                                                }
                                            });
                                            // Đảm bảo nút Add to Cart nắm được variant đã chọn khi trang tải lại
                                            updateAddToCartButton(selectedVariantID);
                                        }
                                        
                                        // Thêm click event cho variant links
                                        document.querySelectorAll(".variant-link").forEach(link => {
                                            link.addEventListener("click", function(e) {
                                                // Lấy variantID từ href
                                                let href = this.href;
                                                let variantIDMatch = href.match(/variantID=(\d+)/);
                                                if (variantIDMatch) {
                                                    let variantID = variantIDMatch[1];
                                                    console.log("Selected variant ID:", variantID);
                                                    
                                                    // Cập nhật session variantID (có thể cần AJAX call)
                                                    // Tạm thời lưu vào localStorage để test
                                                    localStorage.setItem("selectedVariantID", variantID);
                                                    
                                                    // Cập nhật nút Add to Cart
                                                    updateAddToCartButton(variantID);
                                                }
                                            });
                                        });
                                        
                                        // Hàm cập nhật nút Add to Cart
                                        function updateAddToCartButton(variantID) {
                                            let addToCartBtn = document.getElementById("addToCartBtn");
                                            if (addToCartBtn) {
                                                addToCartBtn.setAttribute("data-variant-id", variantID);
                                                console.log("Updated Add to Cart button with variant ID:", variantID);
                                            }
                                        }
                                        
                                        // Khởi tạo nút Add to Cart với variantID đầu tiên nếu có
                                        let firstVariant = document.querySelector(".variant-link");
                                        if (firstVariant && !selectedVariantID) {
                                            let href = firstVariant.href;
                                            let variantIDMatch = href.match(/variantID=(\d+)/);
                                            if (variantIDMatch) {
                                                let variantID = variantIDMatch[1];
                                                updateAddToCartButton(variantID);
                                            }
                                        }
                                    });
                                </script>
                                <div class="row mb-4 mt-3">
                                    <dt class="col-3 fw-bold">Quantity</dt>
                                    <dd class="col-9 d-flex align-items-center">
                                        <button class="btn btn-outline-secondary rounded-0" id="decreaseBtn">-</button>
                                        <input type="text" id="quantityInput" class="form-control text-center mx-2" style="width: 50px;" value="1">
                                        <button class="btn btn-outline-secondary rounded-0" id="increaseBtn">+</button>
                                        <span class="ms-2">${requestScope.AllQuantity} Products available</span>
                                    </dd>
                                    <p id="warningMessage" class="text-danger mt-2" style="color: red !important;">⚠ ️The quantity imported for the product is not reasonable.</p>
                                </div>
                                <script>
                                    document.addEventListener("DOMContentLoaded", function () {
                                        let stockQuantity = ${requestScope.AllQuantity != null ? requestScope.AllQuantity : 1}; // Số lượng tối đa
                                        let input = document.getElementById("quantityInput");
                                        let decreaseBtn = document.getElementById("decreaseBtn");
                                        let increaseBtn = document.getElementById("increaseBtn");
                                        let warningMessage = document.getElementById("warningMessage");

                                        // Ẩn cảnh báo khi load trang
                                        warningMessage.style.display = "none";

                                        function validateQuantity() {
                                            let currentValue = parseInt(input.value.trim(), 10);

                                            if (isNaN(currentValue) || currentValue < 1) {
                                                input.value = 1; // Nếu nhập 0 hoặc số âm, tự động đặt về 1
                                                warningMessage.style.display = "block";
                                            } else if (currentValue > stockQuantity) {
                                                input.value = stockQuantity;
                                                warningMessage.style.display = "block"; // Hiển thị cảnh báo
                                            } else {
                                                warningMessage.style.display = "block";
                                            }
                                        }

                                        // Xử lý khi bấm nút giảm
                                        decreaseBtn.addEventListener("click", function () {
                                            let currentValue = parseInt(input.value, 10) || 1;
                                            if (currentValue > 1) {
                                                input.value = currentValue - 1;
                                                warningMessage.style.display = "none";
                                            }
                                        });

                                        // Xử lý khi bấm nút tăng
                                        increaseBtn.addEventListener("click", function () {
                                            let currentValue = parseInt(input.value, 10) || 1;
                                            if (currentValue < stockQuantity) {
                                                input.value = currentValue + 1;
                                                warningMessage.style.display = "none";
                                            } else {
                                                input.value = stockQuantity;
                                                warningMessage.style.display = "block";
                                            }
                                        });

                                        // Kiểm tra khi người dùng nhập trực tiếp và nhấn Enter hoặc click ra ngoài
                                        input.addEventListener("change", validateQuantity);
                                        input.addEventListener("blur", validateQuantity);
                                    });
                                </script>



                            </div>
                            <div class="mt-4 d-flex gap-3">
                                <!--                                <a href="#" class="btn btn-danger px-5 py-3 fw-bold rounded">Buy Now</a>-->
                                <a href="" id="addToCartBtn" data-variant-id="${empty param.variantID ? '' : param.variantID}" class="btn btn-outline-danger px-5 py-3 fw-bold rounded border-2">
                                    Add to Cart
                                </a>
                            </div>
                            <script>
                                $(document).ready(function () {
                                    $("#addToCartBtn").click(function (event) {
                                        event.preventDefault(); // Ngăn chặn điều hướng mặc định

                                        // Lấy variantID từ data attribute của nút
                                        let variantID = $(this).attr("data-variant-id");
                                        let quantity = $("#quantityInput").val();

                                        console.log("=== Add to Cart Debug ===");
                                        console.log("VariantID from button:", variantID);
                                        console.log("Quantity:", quantity);

                                        // Kiểm tra xem variantID đã chọn chưa
                                        if (!variantID || variantID === "null" || variantID === "") {
                                            alert("Please select product variation before adding to cart!");
                                            return;
                                        }

                                        // Kiểm tra số lượng nhập vào
                                        if (!quantity || isNaN(quantity) || quantity <= 0) {
                                            alert("Please enter valid quantity!");
                                            return;
                                        }

                                        console.log("Sending AJAX request...");
                                        $.post("${pageContext.request.contextPath}/addProductToCart", {
                                            variantID: variantID,
                                            quantity: quantity
                                        }, function (data) {
                                            console.log("Response received:", data);
                                            if (data.success) {
                                                alert("🛒 Product has been successfully added to cart!");
                                                location.reload();
                                            } else {
                                                if (data.redirect) {
                                                    console.log("Redirecting to:", data.redirect);
                                                    // Nếu cần login, chuyển hướng trực tiếp
                                                    window.location.href = data.redirect;
                                                } else {
                                                    alert("❌ " + (data.message || "Add to cart failed! Please try again."));
                                                }
                                            }
                                        }, "json").fail(function (xhr, status, error) {
                                            console.error("AJAX failed - Status:", status, "Error:", error);
                                            console.error("Response text:", xhr.responseText);
                                            alert("⚠️ Error! Please try again.");
                                        });
                                    });
                                });
                            </script>

                        </div>
                    </main>
                    <div>
                        <a class="product-description">
                            <h2 class="product-title">PRODUCT DESCRIPTION</h2>
                            ${product.description}
                        </a>
                    </div>
                </div>
            </div>
        </section>











        <!-- content -->



        <div id="Footer"></div> <!-- Nơi sẽ load Footer.jsp -->



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


