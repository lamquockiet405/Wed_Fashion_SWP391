<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product Management - Seller Panel</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                background-color: #f4f6f9;
                color: #333;
                line-height: 1.6;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            /* Main Container */
            .main-container {
                display: flex;
                min-height: 100vh;
            }

            .main-content {
                flex: 1;
                padding: 40px;
                margin-left: 280px;
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
            }

            .page-title {
                font-size: 32px;
                font-weight: 700;
                color: #2c3e50;
                margin-bottom: 40px;
                text-align: center;
                text-shadow: 0 2px 4px rgba(0,0,0,0.1);
                position: relative;
            }

            .page-title::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 4px;
                background: linear-gradient(135deg, #3498db, #2980b9);
                border-radius: 2px;
            }

            .page-title i {
                color: #3498db;
                margin-right: 15px;
                font-size: 36px;
            }

            /* Product Type Container */
            .product-type-container {
                display: flex;
                gap: 12px;
                margin-bottom: 30px;
                flex-wrap: wrap;
                justify-content: center;
            }

            .product_type {
                padding: 14px 24px;
                border-radius: 12px;
                text-decoration: none;
                font-size: 15px;
                font-weight: 600;
                color: #495057;
                background: rgba(255, 255, 255, 0.9);
                border: 2px solid transparent;
                transition: all 0.3s ease;
                box-shadow: 0 4px 12px rgba(0,0,0,0.08);
                backdrop-filter: blur(10px);
            }

            .product_type:hover {
                background: linear-gradient(135deg, #3498db, #2980b9);
                color: white;
                transform: translateY(-3px);
                box-shadow: 0 8px 20px rgba(52, 152, 219, 0.3);
                text-decoration: none;
                border-color: #3498db;
            }

            .active_ptype {
                background: linear-gradient(135deg, #3498db, #2980b9) !important;
                color: white !important;
                font-weight: 700;
                border-color: #3498db;
                box-shadow: 0 8px 20px rgba(52, 152, 219, 0.3);
            }

            /* Filter Section */
            .filter-section {
                background: rgba(255, 255, 255, 0.95);
                border-radius: 16px;
                padding: 30px;
                margin-bottom: 30px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.1);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            .search-box {
                display: flex;
                gap: 15px;
                align-items: center;
                margin-bottom: 25px;
            }

            .search-box input {
                flex: 1;
                padding: 14px 20px;
                border: 2px solid #e9ecef;
                border-radius: 12px;
                font-size: 15px;
                transition: all 0.3s ease;
                background: rgba(255, 255, 255, 0.9);
            }

            .search-box input:focus {
                outline: none;
                border-color: #3498db;
                box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
                background: white;
            }

            .search-box button {
                padding: 14px 24px;
                background: linear-gradient(135deg, #3498db, #2980b9);
                color: white;
                border: none;
                border-radius: 12px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-weight: 600;
                font-size: 15px;
                box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
            }

            .search-box button:hover {
                background: linear-gradient(135deg, #2980b9, #1f5f8b);
                transform: translateY(-2px);
                box-shadow: 0 6px 16px rgba(52, 152, 219, 0.4);
            }

            .sort-buttons {
                display: flex;
                gap: 12px;
                align-items: center;
                justify-content: flex-end;
            }

            .sort-btn {
                padding: 12px 20px;
                background: rgba(248, 249, 250, 0.9);
                border: 2px solid #e1e8ed;
                border-radius: 10px;
                text-decoration: none;
                color: #495057;
                font-size: 14px;
                font-weight: 600;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 8px;
                backdrop-filter: blur(10px);
            }

            .sort-btn:hover {
                background: linear-gradient(135deg, #3498db, #2980b9);
                color: white;
                text-decoration: none;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
                border-color: #3498db;
            }

            .sort-btn.active {
                background: linear-gradient(135deg, #f39c12, #e67e22);
                color: white;
                border-color: #f39c12;
                box-shadow: 0 4px 12px rgba(243, 156, 18, 0.3);
            }

            /* Product Table */
            .product-table-container {
                background: rgba(255, 255, 255, 0.95);
                border-radius: 16px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.1);
                overflow: hidden;
                margin-bottom: 30px;
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            .product-table {
                width: 100%;
                border-collapse: collapse;
            }

            .product-table thead th {
                background: linear-gradient(135deg, #f8f9fa, #e9ecef);
                padding: 20px 25px;
                text-align: left;
                font-weight: 700;
                color: #2c3e50;
                border-bottom: 3px solid #e9ecef;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 1px;
                position: relative;
            }

            .product-table thead th::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                height: 2px;
                background: linear-gradient(135deg, #3498db, #2980b9);
            }

            .product-table tbody td {
                padding: 18px 25px;
                border-bottom: 1px solid #f1f3f4;
                color: #2c3e50;
                font-size: 14px;
                vertical-align: middle;
                transition: all 0.3s ease;
            }

            .product-table tbody tr:hover {
                background: linear-gradient(135deg, #f8f9fa, #e9ecef);
                transform: scale(1.01);
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }

            .product-image {
                width: 70px;
                height: 70px;
                object-fit: cover;
                border-radius: 12px;
                border: 2px solid #e1e8ed;
                transition: all 0.3s ease;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .product-table tbody tr:hover .product-image {
                transform: scale(1.1);
                border-color: #3498db;
                box-shadow: 0 4px 12px rgba(52, 152, 219, 0.2);
            }

            .product-name {
                color: #3498db;
                font-weight: 600;
                transition: color 0.3s ease;
                font-size: 15px;
            }

            .product-name:hover {
                color: #2980b9;
                text-decoration: underline;
            }

            .status-badge {
                display: inline-flex;
                align-items: center;
                padding: 6px 14px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .status-active {
                background: linear-gradient(135deg, rgba(39, 174, 96, 0.1), rgba(39, 174, 96, 0.2));
                color: #27ae60;
                border: 1px solid rgba(39, 174, 96, 0.3);
            }

            .status-pending {
                background: linear-gradient(135deg, rgba(243, 156, 18, 0.1), rgba(243, 156, 18, 0.2));
                color: #f39c12;
                border: 1px solid rgba(243, 156, 18, 0.3);
            }

            .status-violating {
                background: linear-gradient(135deg, rgba(231, 76, 60, 0.1), rgba(231, 76, 60, 0.2));
                color: #e74c3c;
                border: 1px solid rgba(231, 76, 60, 0.3);
            }

            .action-btn {
                padding: 8px 16px;
                border-radius: 8px;
                text-decoration: none;
                font-size: 13px;
                font-weight: 600;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 6px;
                margin-right: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .btn-edit {
                background: linear-gradient(135deg, #f39c12, #e67e22);
                color: white;
            }

            .btn-edit:hover {
                background: linear-gradient(135deg, #e67e22, #d35400);
                color: white;
                text-decoration: none;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(243, 156, 18, 0.3);
            }

            .btn-delete {
                background: linear-gradient(135deg, #e74c3c, #c0392b);
                color: white;
            }

            .btn-delete:hover {
                background: linear-gradient(135deg, #c0392b, #a93226);
                color: white;
                text-decoration: none;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(231, 76, 60, 0.3);
            }

            /* Pagination */
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                margin-top: 40px;
            }

            .pagination a, .pagination span {
                padding: 12px 16px;
                text-decoration: none;
                color: #495057;
                border: 2px solid #e1e8ed;
                border-radius: 10px;
                font-size: 14px;
                font-weight: 600;
                transition: all 0.3s ease;
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(10px);
            }

            .pagination a:hover {
                background: linear-gradient(135deg, #3498db, #2980b9);
                color: white;
                border-color: #3498db;
                text-decoration: none;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
            }

            .pagination .current {
                background: linear-gradient(135deg, #3498db, #2980b9);
                color: white;
                border-color: #3498db;
                font-weight: 700;
                box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
            }

            /* Mobile Responsive */
            @media (max-width: 768px) {
                .main-content {
                    margin-left: 0;
                    padding: 20px;
                }

                .page-title {
                    font-size: 24px;
                    margin-bottom: 30px;
                }

                .product-type-container {
                    flex-direction: column;
                    align-items: center;
                }

                .product_type {
                    width: 100%;
                    text-align: center;
                }

                .search-box {
                    flex-direction: column;
                }

                .sort-buttons {
                    flex-wrap: wrap;
                    justify-content: center;
                }

                .product-table-container {
                    overflow-x: auto;
                }

                .product-table {
                    min-width: 600px;
                }
            }

            /* Animation */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .main-content {
                animation: fadeIn 0.6s ease-out;
            }

            /* Add Product Button */
            .add-product-btn {
                position: fixed;
                bottom: 30px;
                right: 30px;
                background: linear-gradient(135deg, #27ae60, #229954);
                color: white;
                border: none;
                border-radius: 50px;
                padding: 16px 24px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 8px 20px rgba(39, 174, 96, 0.3);
                z-index: 1000;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .add-product-btn:hover {
                background: linear-gradient(135deg, #229954, #1e8449);
                transform: translateY(-3px);
                box-shadow: 0 12px 25px rgba(39, 174, 96, 0.4);
            }
        </style>
    </head>
    <body>
        <!-- Main Container -->
        <div class="main-container">
            <!-- Sidebar -->
            <jsp:include page="../common/sidebar.jsp"/>

            <!-- Main Content -->
            <main class="main-content">
                <h1 class="page-title">
                    <i class="fas fa-box"></i> Product Management
                </h1>
                
                <div class="container-fluid p-0">
                    <div>
                        <jsp:include page="filter/filterProduct.jsp" />
                    </div>
                    <div class="mt-3">
                        <jsp:include page="displayProduct/product.jsp" />
                    </div>
                    <div>
                        <jsp:include page="displayProduct/displayPageNumber.jsp" />
                    </div>
                </div>
            </main>
        </div>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        
        <script>
            // SweetAlert notifications
            document.addEventListener("DOMContentLoaded", function () {
                const successUpdateProduct = "${successUpdateProduct}";
                const errorUpdateProduct = "${errorUpdateProduct}";
                const error = "${error}";

                if (error) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: error,
                        timer: 3000,
                        showConfirmButton: false
                    });
                }

                if (successUpdateProduct) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: successUpdateProduct,
                        timer: 2000,
                        showConfirmButton: false
                    });
                } else if (errorUpdateProduct) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: errorUpdateProduct,
                        timer: 3000,
                        showConfirmButton: false
                    });
                }
            });
        </script>
    </body>
</html>
