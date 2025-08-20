<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Edit information</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                background-color: #f8f9fa;
            }
            .container {
                max-width: 800px;
                margin: 50px auto;
                background: #fff;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
            }
            .profile-img {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
                border: 4px solid #007bff;
            }
            .form-label {
                font-weight: bold;
            }
            .btn-save {
                background-color: #dc3545;
                color: white;
                width: 100px;
            }
            .btn-change {
                color: #007bff;
                text-decoration: none;
                font-size: 14px;
            }
        </style>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                background-color: #f8f9fa;
            }
            .sidebar {
                height: 100vh;
                background-color: #ffffff;
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
    </head>
    <body>
        <jsp:include page="./../../../Header/Header.jsp" />
        <div class="row">
            <div class="col-md-2">
                <jsp:include page="./../sidebar.jsp" />
            </div>
            <div class="col-md">
                <jsp:include page="./../AddressList.jsp"/>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const successMessage = "${success}";
                const errorMessage = "${error}";
                const errorGetData = "${errorGetData}";
                const urlParams = new URLSearchParams(window.location.search);
                const message = urlParams.get("error");
                if (errorGetData) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: errorGetData,
                        timer: 3000,
                        showConfirmButton: false
                    }).then(() => {
                        window.location.href = "LoginController";
                    });
                }
                 if (message) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: message,
                        timer: 3000,
                        showConfirmButton: false
                    });
                }

                if (successMessage) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: successMessage,
                        timer: 1000,
                        showConfirmButton: false
                    }).then(() => {
                        window.location.href = "GetAddress";
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
