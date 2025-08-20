<%-- 
    Document   : ChangePassword
    Created on : Mar 23, 2025, 1:01:43 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                background-color: #f0f2f5;
                font-family: 'Arial', sans-serif;
            }
            .info-container {
                max-width: 700px;
                margin: 50px auto;
                background: #fff;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
            }
            .profile-header {
                display: flex;
                align-items: center;
                gap: 15px;
                border-bottom: 1px solid #ddd;
                padding-bottom: 15px;
                margin-bottom: 15px;
            }
            .profile-header img {
                width: 90px;
                height: 90px;
                padding: 2px;
                border-radius: 50%;
                object-fit: cover;
                border: 1px solid #333;
            }
            .profile-header h2 {
                margin: 0;
                color: #333;
            }
            .table th {
                background-color: #f8f9fa;
                text-align: left;
                width: 30%;
            }
            .table td {
                text-align: left;
            }
            .btn-container {
                display: flex;
                justify-content: space-between;
            }
            .btn-primary {
                background-color: #1877f2;
                border: none;
            }
            .btn-primary:hover {
                background-color: #1558c5;
            }
            .btn-secondary {
                background-color: #42b72a;
                border: none;
            }
            .btn-secondary:hover {
                background-color: #369924;
            }
        </style>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                background-color: #6c757d;
            }
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
    </head>
    <body>
        <jsp:include page="./../../../Header/Header.jsp" />
        <div class="row">
            <div class="col-md-2">
                <jsp:include page="./../sidebar.jsp" />
            </div>
            <div class="col-md">
                <section class="vh-90">
                    <div class="container-fluid h-custom">
                        <div class="row d-flex justify-content-center align-items-center h-100">
                            <div class="col-md-9 col-lg-6 col-xl-5">
                                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp" class="img-fluid" alt="Sample image">
                            </div>
                            <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">


                                <!-- Change Password Form -->
                                <form action="${pageContext.request.contextPath}/changePassword" method="POST" class="mt-5" onsubmit="return validateForm()">

                                    <h5>Change Password</h5>

                                    <div class="form-outline mb-3">
                                         <label class="form-label">Current Password</label>
                                        <input type="password" id="currentPassword" name="currentPassword" class="form-control" placeholder="" required>
                                        
                                        <small id="currentPasswordError" class="text-danger" style="color: red !important;"></small>
                                    </div>

                                    <div class="form-outline mb-3">
                                         <label class="form-label">New Password</label>
                                        <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="" required oninput="checkSpace(this)">
                                        <small id="newPasswordError" class="text-danger" style="color: red !important;"></small>
                                    </div>

                                    <div class="form-outline mb-3">
                                        <label class="form-label">Confirm New Password</label>
                                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="" required oninput="checkSpace(this)">
                                       
                                        <small id="confirmPasswordError" class="text-danger" style="color: red !important;"></small>
                                    </div>

                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="showPassword" onclick="togglePasswordVisibility()">
                                        <label class="form-check-label" for="showPassword">Show Password</label>
                                    </div>

                                    <div class="text-danger" style="color: red !important;">${errorMessage}</div>
                                    <div class="text-center mt-3">
                                        <button type="submit" class="btn btn-success">Confirm</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <script>
            function checkSpace(input) {
                let errorField = document.getElementById(input.id + "Error");
                if (input.value.includes(" ")) {
                    errorField.textContent = "Password cannot contain spaces!";
                } else {
                    errorField.textContent = "";
                }
            }

            function validateForm() {
                let currentPassword = document.getElementById('currentPassword').value;
                let newPassword = document.getElementById('newPassword').value;
                let confirmPassword = document.getElementById('confirmPassword').value;

                let currentPasswordError = document.getElementById("currentPasswordError");
                let newPasswordError = document.getElementById("newPasswordError");
                let confirmPasswordError = document.getElementById("confirmPasswordError");

                let passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$/;

                // Kiểm tra khoảng trắng
                if (newPassword.includes(" ")) {
                    newPasswordError.textContent = "Password cannot contain spaces!";
                    return false;
                } else {
                    newPasswordError.textContent = "";
                }

                if (confirmPassword.includes(" ")) {
                    confirmPasswordError.textContent = "Confirm password cannot contain spaces!";
                    return false;
                } else {
                    confirmPasswordError.textContent = "";
                }

                // Kiểm tra độ mạnh của mật khẩu
                if (!passwordPattern.test(newPassword)) {
                    newPasswordError.textContent = "Password must be at least 6 characters long, contain 1 uppercase letter, 1 number, and 1 special character.";
                    return false;
                } else {
                    newPasswordError.textContent = "";
                }

                // Kiểm tra mật khẩu mới khác mật khẩu cũ
                if (newPassword === currentPassword) {
                    newPasswordError.textContent = "New password must be different from the current password!";
                    return false;
                } else {
                    newPasswordError.textContent = "";
                }

                // Kiểm tra xác nhận mật khẩu
                if (newPassword !== confirmPassword) {
                    confirmPasswordError.textContent = "Passwords do not match!";
                    return false;
                } else {
                    confirmPasswordError.textContent = "";
                }

                return true;
            }

            function togglePasswordVisibility() {
                let passwordFields = ["currentPassword", "newPassword", "confirmPassword"];
                let showPasswordCheckbox = document.getElementById('showPassword');

                passwordFields.forEach(id => {
                    let field = document.getElementById(id);
                    field.type = showPasswordCheckbox.checked ? 'text' : 'password';
                });
            }
        </script>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</html>
