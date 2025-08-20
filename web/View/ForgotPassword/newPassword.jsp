<!doctype html>
<%-- 
        Document   : forgotPassword
    Created on : May 24, 2024, 7:49:50 AM
    Author     : Dell : Quan merge all 
--%>

<!doctype html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <!-- Google Tag Manager -->
        <script>(function (w, d, s, l, i) {
                w[l] = w[l] || [];
                w[l].push({'gtm.start':
                            new Date().getTime(), event: 'gtm.js'});
                var f = d.getElementsByTagName(s)[0],
                        j = d.createElement(s), dl = l != 'dataLayer' ? '&l=' + l : '';
                j.async = true;
                j.src =
                        'https://www.googletagmanager.com/gtm.js?id=' + i + dl;
                f.parentNode.insertBefore(j, f);
            })(window, document, 'script', 'dataLayer', 'GTM-TAGCODE');</script>
        <!-- End Google Tag Manager -->
        <title>Logee - Login and Register HTML5 Template</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- External CSS libraries -->
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/View/ForgotPassword/assets_lg/css/bootstrap.min.css">
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/View/ForgotPassword/assets_lg/fonts/font-awesome/css/font-awesome.min.css">
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/View/ForgotPassword/assets_lg/fonts/flaticon/font/flaticon.css">

        <!-- Favicon icon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/View/ForgotPassword/assets_lg/img/favicon.ico" type="image/x-icon" >

        <!-- Google fonts -->
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800%7CPoppins:400,500,700,800,900%7CRoboto:100,300,400,400i,500,700">

        <!-- Custom Stylesheet -->
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/View/ForgotPassword/assets_lg/css/style.css">
        <link rel="stylesheet" type="text/css" id="style_sheet" href="${pageContext.request.contextPath}/View/ForgotPassword/assets_lg/css/skins/default.css">
        <link href="${pageContext.request.contextPath}/View/ForgotPassword/assets_h/css/style.css" rel="stylesheet">
    </head>
    <body id="top">
        <!-- Google Tag Manager (noscript) -->
        <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-TAGCODE"
                          height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
        <!-- End Google Tag Manager (noscript) -->
        <div class="page_loader"></div>

        <!-- Login 11 start -->
        <div class="login-11">
            <div class="container-fluid">

                <div class="row">
                    <div class="col-lg-6 col-md-12">
                        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
                             class="img-fluid" alt="Sample image">
                    </div>
                    <div class="col-lg-6 col-md-12 bg-color-13">
                        <div class="form-section">
                            <div class="logo clearfix">

                                <a href="${pageContext.request.contextPath}/index.html">
                                    <img  src="${pageContext.request.contextPath}/images/logo.png" alt="logo">
                                </a>
                            </div>
                            <% 
                            String status = (String) request.getAttribute("status");
                            boolean isStatusEmpty = (status == null || status.equals(""));
                            %>

                            <h3 style="color:<%= isStatusEmpty ?  "black":"red"  %>;"><%= isStatusEmpty ? "Recover your password" : status %></h3>

                            <div class="login-inner-form">
                                <form action="${pageContext.request.contextPath}/newPasswordUpdate" method="post" onsubmit="return validatePassword()">
                                    <div class="form-group form-box">
                                        <input type="password" id="password" name="password" class="input-text" placeholder="New Password" oninput="checkSpace(this)">
                                        <small id="passwordError" style="color: red;"></small>
                                    </div>
                                    <div class="form-group form-box">
                                        <input type="password" id="confPassword" name="confPassword" class="input-text" placeholder="Confirm Password" oninput="checkSpace(this)">
                                        <small id="confPasswordError" style="color: red;"></small>
                                    </div>
                                    <div class="col d-flex justify-content-center align-items-center">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="showPassword" onclick="togglePasswordVisibility()">
                                            <label class="form-check-label" for="showPassword">Show pass</label>
                                        </div>
                                    </div>
                                    <div class="form-group mb-0">
                                        <button type="submit" class="btn-md btn-theme btn-block">Save</button>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Login 11 end -->

        <!-- External JS libraries -->
        <script src="${pageContext.request.contextPath}/View/ForgotPassword/assets_lg/js/jquery-2.2.0.min.js"></script>
        <script src="${pageContext.request.contextPath}/View/ForgotPassword/assets_lg/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/View/ForgotPassword/assets_lg/js/bootstrap.min.js"></script>
        <!-- Custom JS Script -->
        <script>
    var countdownInterval; // Biến lưu ID của bộ đếm thời gian

    function checkSpace(input) {
        let errorField = document.getElementById(input.id + "Error");
        if (input.value.includes(" ")) {
            errorField.textContent = "Password cannot contain spaces!";
        } else {
            errorField.textContent = "";
        }
    }

    function validatePassword() {
        let password = document.getElementById('password').value;
        let confPassword = document.getElementById('confPassword').value;
        let passwordError = document.getElementById("passwordError");
        let confPasswordError = document.getElementById("confPasswordError");

        let passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$/;

        // Kiểm tra khoảng trắng
        if (password.includes(" ")) {
            passwordError.textContent = "Password cannot contain spaces!";
            return false;
        } else {
            passwordError.textContent = "";
        }

        if (confPassword.includes(" ")) {
            confPasswordError.textContent = "Confirm password cannot contain spaces!";
            return false;
        } else {
            confPasswordError.textContent = "";
        }

        // Kiểm tra độ mạnh của mật khẩu
        if (!passwordPattern.test(password)) {
            passwordError.textContent = "Password must contain at least 1 number, 1 letter, 1 special character and at least 6 characters.";
            return false;
        } else {
            passwordError.textContent = "";
        }

        // Kiểm tra xác nhận mật khẩu
        if (password !== confPassword) {
            confPasswordError.textContent = "Passwords do not match!";
            return false;
        } else {
            confPasswordError.textContent = "";
        }

        return true;
    }

    function togglePasswordVisibility() {
        var passwordField = document.getElementById('password');
        var confPasswordField = document.getElementById('confPassword');
        var showPasswordCheckbox = document.getElementById('showPassword');

        if (showPasswordCheckbox.checked) {
            passwordField.type = 'text';
            confPasswordField.type = 'text';
        } else {
            passwordField.type = 'password';
            confPasswordField.type = 'password';
        }
    }
</script>

    </body>
</html>