<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Shop Information - Seller Panel</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                background-color: #f4f6f9;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            .main-container {
                display: flex;
                min-height: 100vh;
            }
            
            .sidebar {
                height: 100vh;
                background-color: #ffffff;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
                width: 280px;
                position: fixed;
                left: 0;
                top: 0;
                overflow-y: auto;
            }
            
            .main-content {
                flex: 1;
                margin-left: 280px;
                padding: 30px;
                background-color: #f4f6f9;
            }
            
            .page-title {
                font-size: 28px;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 30px;
                text-align: center;
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

            .active__sidebar {
                background-color: #93c5fd;
                border-radius: 5px;
                font-weight: bold;
                transition: background-color 0.3s ease-in-out, transform 0.2s ease-in-out;
            }

            .active__sidebar__tiem  {
                background-color: #ffffff;
                border-left: 4px solid #93c5fd;
                border-radius: 5px;
                font-weight: bold;
                margin-top: 8px;
                margin-bottom: 8px;
                transition: background-color 0.3s ease-in-out, transform 0.2s ease-in-out;
            }

            .block-filter-sort .filter-sort__list-filter .btn-filter {
                align-items: center;
                background: #f3f4f6;
                border: 1px solid #e5e7eb;
                border-radius: 10px;
                color: #444;
                cursor: pointer;
                display: flex;
                font-size: 12px;
                height: 34px;
                margin: 0 10px 10px 0;
                padding: 5px 10px;
                white-space: nowrap;
            }
            
            .pagination {
                text-align: center;
                margin: 20px;
            }

            .pagination a, .pagination span {
                margin: 0 5px;
                padding: 8px 12px;
                text-decoration: none;
                color: #333;
            }

            .pagination .current {
                border: 1px solid #dee2e6;
            }

            /* Modern UI Styles */
            .product-type-container {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
            }

            .product_type {
                padding: 12px 18px;
                border-radius: 8px;
                text-decoration: none;
                font-size: 16px;
                font-weight: 500;
                color: #333;
                background: #f8f9fa;
                transition: all 0.3s ease;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .product_type:hover {
                background: #4CAF50;
                color: white;
                transform: translateY(-2px);
            }

            .active_ptype {
                background: #4CAF50 !important;
                color: white !important;
                font-weight: bold;
            }
            
            /* Edit Form Container */
            .edit-form-container {
                background: white;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                padding: 30px;
                max-width: 800px;
                margin: 0 auto;
            }
            
            /* Animation */
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

            .main-content {
                animation: fadeIn 0.5s ease-out;
            }
            
            /* Mobile Responsive */
            @media (max-width: 768px) {
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
                
                .edit-form-container {
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>
        <div class="main-container">
            <!-- Sidebar -->
            <div class="sidebar">
                <jsp:include page="../common/sidebar.jsp"/>
            </div>
            
            <!-- Main Content -->
            <main class="main-content">
                <h1 class="page-title">
                    <i class="fas fa-edit"></i> Edit Shop Information
                </h1>
                
                <div class="edit-form-container">
                    <jsp:include page="./edit-information.jsp" />
                </div>
            </main>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const successMessage = "${success}";
                const errorMessage = "${error}";

                if (successMessage) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: successMessage,
                        timer: 2000,
                        showConfirmButton: false
                    }).then(() => {
                        window.location.href = "manager_view_information_shop";
                    });
                } else if (errorMessage) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: errorMessage,
                        timer: 3000,
                        showConfirmButton: false
                    });
                }
            });
        </script>
    </body>
</html>
