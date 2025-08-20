
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags-->
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Colorlib Templates">
        <meta name="author" content="Colorlib">
        <meta name="keywords" content="Colorlib Templates">


        <!-- Title Page-->
        <title>Sign Up</title>

        <!-- Icons font CSS-->
        <link href="vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
        <link href="vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">
        <!-- Font special for pages-->
        <link href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

        <!-- Vendor CSS-->
        <link href="vendor/select2/select2.min.css" rel="stylesheet" media="all">
        <link href="vendor/datepicker/daterangepicker.css" rel="stylesheet" media="all">

        <style>
            <%@ include file="main.css" %>
        </style>
        <!-- Main CSS-->


    </head>

    <body>
        <div class="page-wrapper bg-gra-02 p-t-100 p-b-100 font-poppins">
            <div class="wrapper wrapper--w680">
                <div class="card card-4">
                    <div class="card-body">
                        <h2 class="title">Registration Form</h2>
                        <p style="color: red;" id="errorMessage" ">${message}</p>
                        <c:if test="${not empty successMessage}">
                            <p style="color: green;">${successMessage}</p>
                            <script>
                                setTimeout(function () {
                                    window.location.href = '<%= request.getContextPath() %>/homePage';
                                }, 3000); // Chuyển hướng sau 3 giây
                            </script>
                        </c:if>
                        <form id="signupForm" action="${pageContext.request.contextPath}/SignUpController" method="POST" onsubmit="return validateForm()">
                            <div class="row row-space">
                                <div class="col-2">
                                    <div class="input-group">
                                        <label class="label">Username</label>
                                        <input class="input--style-4" type="text" name="username" id="username" required="">
                                        <span id="usernameError" class="error-message"></span>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <div class="input-group">
                                        <label class="label">Password</label>
                                        <input class="input--style-4" type="password" name="password" id="password" required="">
                                        <span id="passwordError" class="error-message"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row row-space">
                                <div class="col-2">
                                    <div class="input-group">
                                        <label class="label">Email</label>
                                        <input class="input--style-4" type="email" name="email" id="email" required="">
                                        <span id="emailError" class="error-message"></span>
                                    </div>
                                </div>

                                <div class="col-2">
                                    <div class="input-group">
                                        <label class="label">Phone Number</label>
                                        <input class="input--style-4" type="text" name="phonenumber" id="phonenumber" required="">
                                        <span id="phoneError" class="error-message"></span>
                                    </div>
                                </div>
                            </div>

                            <div class="row row-space">
                                <div class="col-2">
                                    <div class="input-group">
                                        <label class="label">Gender</label>
                                        <div class="p-t-10">
                                            <label class="radio-container m-r-45">Male
                                                <input type="radio" checked="checked" name="gender" value="1">
                                                <span class="checkmark"></span>
                                            </label>
                                            <label class="radio-container">Female
                                                <input type="radio" name="gender" value="0">
                                                <span class="checkmark"></span>
                                            </label>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="p-t-15">
                                <a href="${pageContext.request.contextPath}/homePage" class="btn-cancel">Cancel</a>
                                <button class="btn btn--radius-2 btn--blue" type="submit">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Jquery JS-->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.min.css">

        <!-- Vendor JS-->
        <script src="vendor/select2/select2.min.js"></script>
        <script src="vendor/datepicker/moment.min.js"></script>
        <script src="vendor/datepicker/daterangepicker.js"></script>

        <!-- Main JS-->
        <script src="js/global.js"></script>

        <script>
                            function validateForm() {
                                let isValid = true;

                                // Username validation (5-30 ký tự)
                                let username = document.getElementById("username").value;
                                if (username.length < 5 || username.length > 30) {
                                    document.getElementById("usernameError").innerText = "Username must have 5 to 30 characters.";
                                    isValid = false;
                                } else {
                                    document.getElementById("usernameError").innerText = "";
                                }

                                // Password validation (ít nhất 1 số, 1 chữ, 1 ký tự đặc biệt, > 5 ký tự)
                                let password = document.getElementById("password").value;
                                let passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$/;
                                if (!passwordPattern.test(password)) {
                                    document.getElementById("passwordError").innerText = "Password must have at least 1 number, 1 letter, 1 special character and at least 6 characters.";
                                    isValid = false;
                                } else {
                                    document.getElementById("passwordError").innerText = "";
                                }

                                // Email validation (phải có đuôi @gmail.com)
                                let email = document.getElementById("email").value;
                                if (!email.endsWith("@gmail.com")) {
                                    document.getElementById("emailError").innerText = "Email must have @gmail.com at last.";
                                    isValid = false;
                                } else {
                                    document.getElementById("emailError").innerText = "";
                                }


                                // Phone number validation (chỉ chứa số và ít nhất 10 số)
                                let phone = document.getElementById("phonenumber").value;
                                if (!/^\d{10,}$/.test(phone)) {
                                    document.getElementById("phoneError").innerText = "Phone Number must have at least 10 digits and do not contain characters.";
                                    isValid = false;
                                } else {
                                    document.getElementById("phoneError").innerText = "";
                                }

                                return isValid;
                            }
        </script>
        <style>
            .error-message {
                color: red;
                font-size: 14px;
            }
        </style>
        <script>
            setTimeout(function () {
                var errorMessage = document.getElementById("errorMessage");
                if (errorMessage) {
                    errorMessage.style.display = "none";
                }
            }, 5000); // Chuyển hướng sau 5 giây
        </script>





    </body><!-- This templates was made by Colorlib (https://colorlib.com) -->

</html>
<!-- end document-->