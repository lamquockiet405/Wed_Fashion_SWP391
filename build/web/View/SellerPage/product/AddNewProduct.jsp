<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <title>${action != null ? action : "Add new"} product</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                background-color: #f8f9fa;
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
                padding: 40px;
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
            
            /* Form Container */
            .form-container {
                background: rgba(255, 255, 255, 0.95);
                border-radius: 20px;
                box-shadow: 0 12px 30px rgba(0,0,0,0.15);
                padding: 40px;
                max-width: 900px;
                margin: 0 auto;
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.2);
                position: relative;
                overflow: hidden;
            }

            .form-container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(135deg, #27ae60, #229954);
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
                
                .form-container {
                    padding: 25px;
                    margin: 0 10px;
                }

                .page-title {
                    font-size: 24px;
                    margin-bottom: 30px;
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
            
            <!-- Main content -->
            <main class="main-content">
                <h1 class="page-title">
                    <i class="fas fa-plus"></i> ${action != null ? action : "Add New"} Product
                </h1>
                
                <div class="form-container">
                    <jsp:include page="./FormAddProduct.jsp"/>
                </div>
            </main>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

        <!-- SweetAlert2 để hiển thị thông báo -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {

                const input = document.getElementById("product_name");
                const action = "${action}".trim();
                const success = "${success}";
                const error = "${error}";
                const errorAddProduct = "${errorAddProduct}";
                if (errorAddProduct) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: errorAddProduct,
                        timer: 3000,
                        showConfirmButton: false
                    });
                    input.classList.add("is-invalid");
                    input.classList.remove("is-valid");
                    setInvalidFeedback(input, errorAddProduct);
                }

                if (error) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: error,
                        timer: 3000,
                        showConfirmButton: false
                    });
                }

                if (action !== "") {
                    if (success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success',
                            text: success,
                            timer: 2000,
                            showConfirmButton: false
                        });
                    }
                } else {
                    if (success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success',
                            text: success,
                            timer: 2000,
                            showConfirmButton: false
                        }).then(() => {
                            window.location.href = "view_product?ptype=review";
                        });
                    }
                }


                function setInvalidFeedback(input, message) {
                    let feedback = input.parentNode.querySelector(".invalid-feedback");
                    if (feedback) {
                        feedback.textContent = message;
                    }
                }
            });
        </script>
    </body>
</html>
