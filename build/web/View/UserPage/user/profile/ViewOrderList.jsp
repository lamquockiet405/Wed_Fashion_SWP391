<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <style>
            body {
                background-color: #f4f6f9;
                font-family: 'Arial', sans-serif;
                color: #333;
            }

            /* Container */
            .order-container {
                padding: 20px;
            }

            /* Order Card */
            .order-card {
                background: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
                cursor: pointer;
                border-left: 5px solid #007bff;
            }

            .order-card:hover {
                transform: scale(1.03);
                box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
            }

            /* Order Header */
            .order-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 2px solid #ddd;
                padding-bottom: 10px;
                margin-bottom: 10px;
                font-size: 1.1em;
            }

            /* Order Details */
            .order-details {
                display: none;
                margin-top: 15px;
                border-top: 2px solid #ddd;
                padding-top: 15px;
                animation: fadeIn 0.4s ease-in-out;
            }

            /* Price Formatting */
            .price {
                font-size: 22px;
                font-weight: bold;
                color: black !important;
                text-shadow: none;
            }

            /* Order Total */
            .order-total {
                font-size: 1.5em;
                font-weight: bold;
                text-align: right;
                margin-top: 15px;
                color: #dc3545;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
            }

            /* Badge */
            .badge {
                font-size: 14px;
                padding: 6px 12px;
                border-radius: 8px;
            }

            /* Status Colors */
            .bg-success {
                background-color: #28a745 !important;
                color: white !important;
            }

            .bg-danger {
                background-color: #dc3545 !important;
                color: white !important;
            }

            /* Hover Effects for Buttons */
            .btn {
                border-radius: 6px;
                transition: all 0.3s ease;
            }

            .btn:hover {
                opacity: 0.85;
            }

            /* Fade-in Animation */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Table Styling */
            .table {
                width: 100%;
                border-collapse: collapse;
                table-layout: fixed;
            }

            .table th, .table td {
                padding: 12px;
                text-align: center;
                border-bottom: 1px solid #ddd;
                word-wrap: break-word;
                white-space: nowrap;
            }

            .table th {
                background: #212529;
                color: white;
                font-weight: bold;
            }

            .table td img {
                max-width: 50px;
                height: auto;
            }

            /* Đặt chiều rộng hợp lý cho từng cột */
            .table th:nth-child(1), .table td:nth-child(1) {
                width: 25%;
            } /* Cột Image */

            .table th:nth-child(2), .table td:nth-child(2) {
                width: 100%;
            } /* Cột Price */

            .table th:nth-child(3), .table td:nth-child(3) {
                width: 15%;
            } /* Cột Quantity */

            .table th:nth-child(4), .table td:nth-child(4) {
                width: 100%;
            } /* Cột Total */
        </style>
    </head>
    <body>
        <jsp:include page="./../../../Header/Header.jsp" />
        <div class="row">
            <div class="col-md-2">
                <jsp:include page="./../sidebar.jsp" />
            </div>
            <div class="col-md order-container">
                <h2 class="text-center mb-4">Your Orders</h2>

                <div class="search-filter position-relative">
                    <i class="bi bi-search search-icon"></i>

                    <input type="text" class="form-control w-50" id="searchInput" placeholder="Search by Order ID or Product Name">

                    

                    <button class="btn btn-primary" type="button" id="minPriceBtn">Min Price</button>
                    <button class="btn btn-primary" type="button" id="maxPriceBtn">Max Price</button>
                </div>

                <script>
                    function applyFilters() {
                        const search = document.getElementById('searchInput').value.trim();
                        const status = document.getElementById('statusFilter').value;

                        // Kiểm tra xem nút nào đang active
                        let priceFilter = '';
                        const minBtn = document.getElementById('minPriceBtn');
                        const maxBtn = document.getElementById('maxPriceBtn');

                        if (minBtn.classList.contains('active')) {
                            priceFilter = 'min';
                        } else if (maxBtn.classList.contains('active')) {
                            priceFilter = 'max';
                        }

                        let params = new URLSearchParams(window.location.search);

                        

                        if (search) {
                            params.set('search', search);
                        } else {
                            params.delete('search'); // Xóa search nếu input trống
                        }

                        if (priceFilter) {
                            params.set('priceFilter', priceFilter);
                        } else {
                            params.delete('priceFilter'); // Xóa bộ lọc giá nếu không có gì
                        }

                        let url = 'view_order_list';
                        if (params.toString()) {
                            url += '?' + params.toString();
                        }

                        console.log("Redirecting to:", url);
                        window.location.href = url;
                    }

// Khi nhấn Enter trong ô tìm kiếm mới thực hiện lọc
                    document.getElementById('searchInput').addEventListener('keypress', function (event) {
                        if (event.key === "Enter") {
                            event.preventDefault(); // Ngăn form submit nếu có
                            applyFilters();
                        }
                    });

                    document.getElementById('statusFilter').addEventListener('change', applyFilters);

// Xử lý bấm Min Price
                    document.getElementById('minPriceBtn').addEventListener('click', function () {
                        if (this.classList.contains('active')) {
                            this.classList.remove('active');
                        } else {
                            this.classList.add('active');
                            document.getElementById('maxPriceBtn').classList.remove('active');
                        }
                        applyFilters();
                    });

// Xử lý bấm Max Price
                    document.getElementById('maxPriceBtn').addEventListener('click', function () {
                        if (this.classList.contains('active')) {
                            this.classList.remove('active');
                        } else {
                            this.classList.add('active');
                            document.getElementById('minPriceBtn').classList.remove('active');
                        }
                        applyFilters();
                    });

// Preserve selected filters on page load
                    window.addEventListener('DOMContentLoaded', function () {
                        let params = new URLSearchParams(window.location.search);

                        

                        const search = params.get('search');
                        if (search) {
                            document.getElementById('searchInput').value = search;
                        }

                        const priceFilter = params.get('priceFilter');
                        if (priceFilter === 'min') {
                            document.getElementById('minPriceBtn').classList.add('active');
                        } else if (priceFilter === 'max') {
                            document.getElementById('maxPriceBtn').classList.add('active');
                        }
                    });
                </script>





                <c:forEach var="bills" items="${requestScope.bills}">
                    <div class="order-card" onclick="toggleOrderDetails(${bills.billID})">
                        <div class="order-header">
                            <strong>Order ID: ${bills.billID }</strong>

                        </div>
                        <p><strong>Order Date:</strong> ${bills.orderDate}</p>
                        <p><strong>Shipping Address:</strong> ${bills.shippingAddress}</p>
                        <p class="order-total price" data-price="${bills.totalAmount}">
                            Total Amount: $<span class="amount">${bills.totalAmount}</span>
                        </p> <!-- Đưa ra ngoài -->

                        <div class="order-details" id="order-details-${bills.billID}">
                            <table class="table table-striped table-bordered">
                                <thead class="table-dark">
                                    <tr class="row">
                                        <th class="col-md">Image</th>
                                        <th class="col-md">Price</th>
                                        <th class="col-md">Quantity</th>
                                        <th class="col-md">Total</th>
                                        <th class="col-md">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="BillDetail" items="${requestScope.BillDetail}">
                                        <c:if test="${bills.billID == BillDetail.billID}">
                                            <tr class="row">
                                                <td class="col-md">
                                                    <img src="${BillDetail.productVariantImage}" alt="${BillDetail.productVariantName}" width="50"><br>
                                                    ${BillDetail.productVariantName}
                                                </td>
                                                <td class="price col-md" data-price="${BillDetail.price}">
                                                    $<span class="amount">${BillDetail.price}</span>
                                                </td>

                                                <td  class="col-md">${BillDetail.quantity}</td>
                                                <td class="price col-md" data-price="${BillDetail.price * BillDetail.quantity}">
                                                    $<span class="amount">${BillDetail.price * BillDetail.quantity}</span>
                                                </td>
                                                <td class="col-md">
                                                    <span class="badge ${BillDetail.status == 1 ? 'bg-success' : BillDetail.status == 0 ? 'bg-danger':'bg-warning'} fw-normal"
                                                          style="color: ${BillDetail.status == 1 ? 'white' :  BillDetail.status == 0 ? 'red':'black'} !important;">
                                                        ${BillDetail.status == 1 ? 'Delivered' : BillDetail.status == 0 ? 'Cancel': 'Pending'}
                                                    </span>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:forEach>
                <script>document.addEventListener("DOMContentLoaded", function () {
                        function formatPrice(number) {
                            return number.toLocaleString("en-US"); // Định dạng số có dấu phẩy
                        }

                        function animatePrice(element, value) {
                            let start = 0;
                            let duration = 1000; // 1 giây
                            let step = Math.max((value - start) / (duration / 10), 1); // Bước tăng tối thiểu là 1

                            let interval = setInterval(() => {
                                start += step;
                                if (start >= value) {
                                    start = value;
                                    clearInterval(interval);
                                }
                                element.innerText = formatPrice(Math.floor(start)); // Làm tròn số và hiển thị
                            }, 10);
                        }

                        document.querySelectorAll(".price").forEach(priceElement => {
                            let priceText = priceElement.dataset.price;
                            let priceNumber = parseFloat(priceText.replace(/,/g, ""));

                            let amountElement = priceElement.querySelector(".amount");

                            if (!isNaN(priceNumber) && amountElement) {
                                animatePrice(amountElement, priceNumber);
                            }
                        });
                    });</script>



                <%
    String queryString = request.getQueryString();
    String baseUrl = "view_order_list?";
    if (queryString != null) {
        queryString = queryString.replaceAll("&?page=\\d+", ""); // Xóa page hiện tại khỏi query
        baseUrl += queryString + "&";
    }
                %>

                <!-- PHÂN TRANG -->
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="<%= baseUrl %>page=${currentPage - 1}">Previous</a>
                            </li>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="<%= baseUrl %>page=${i}">${i}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="<%= baseUrl %>page=${currentPage + 1}">Next</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>

            </div>
        </div>

        <script>
            function toggleOrderDetails(orderId) {
                var details = document.getElementById('order-details-' + orderId);
                $(details).slideToggle();
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


<style>

    .sidebar {
        height: 100vh;
        background-color: #6c757d;
        box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    }
    .sidebar .btn-toggle {
        width: 100%;
        text-align: left;
        color: #333;
        font-weight: 500;
    }
    .sidebar .btn-toggle:hover {
        background-color: #bfdbfe;
    }
    .sidebar a {
        display: block;
        padding: 5px 15px;
        color: #555;
        text-decoration: none;
    }
    .sidebar a:hover {
        background-color: #bfdbfe;
        border-radius: 5px;
    }

    .active__sidebar__tiem  {
        background-color: #f8f9fa;
        border-left: 4px solid #ffc107;
        border-radius: 5px;
        font-weight: bold;
        margin-top: 8px;
        margin-bottom: 8px;
        transition: background-color 0.3s ease-in-out, transform 0.2s ease-in-out;
    }
</style>