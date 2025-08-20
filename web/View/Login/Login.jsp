

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.0.0/mdb.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.0.0/mdb.min.js"></script>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - EZShop</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/View/Login/LoginCSS.css">
    </head>
    <body>
        <div class="login-container">
            <div class="login-card">
                <div class="login-image">
                    <img src="${pageContext.request.contextPath}/View/Login/484642829_625080040682257_1102424871640656189_n.png" alt="Login Illustration">
                </div>
                <div class="login-form">
                    <div class="login-header">
                        <h1 class="login-title">Welcome Back</h1>
                        <p class="login-subtitle">Sign in to your account to continue</p>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/LoginController" method="post" id="loginForm">
                        <c:if test="${not empty message}">
                            <div class="error-message">
                                ${message}
                            </div>
                        </c:if>
                        
                        <!-- Hiển thị thông báo lỗi từ URL parameter -->
                        <c:if test="${not empty param.error}">
                            <div class="error-message">
                                ${param.error}
                            </div>
                        </c:if>

                        <div class="form-group">
                            <label class="form-label" for="email">Email Address</label>
                            <input type="email" 
                                   id="email" 
                                   name="email" 
                                   class="form-control" 
                                   placeholder="Enter your email address"
                                   required>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="password">Password</label>
                            <input type="password" 
                                   id="password" 
                                   name="pass" 
                                   class="form-control" 
                                   placeholder="Enter your password"
                                   required>
                        </div>

                        <div class="login-options">
                            <div class="remember-me">
                                <input type="checkbox" id="remember" name="remember">
                                <label for="remember">Remember me</label>
                            </div>
                            <a href="${pageContext.request.contextPath}/forgotPassword" class="forgot-link">
                                Forgot password?
                            </a>
                        </div>

                        <button type="submit" class="login-btn" id="loginBtn">
                            <span>Sign In</span>
                        </button>
                    </form>

                    <div class="register-link">
                        <p>Don't have an account? 
                            <a href="${pageContext.request.contextPath}/View/SignUp/SignUp.jsp">Create Account</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Form submission with loading state
            document.getElementById('loginForm').addEventListener('submit', function(e) {
                const btn = document.getElementById('loginBtn');
                btn.classList.add('loading');
                btn.querySelector('span').textContent = 'Signing In...';
            });

            // Auto-hide error messages after 5 seconds
            setTimeout(function() {
                const errorMessage = document.querySelector('.error-message');
                if (errorMessage) {
                    errorMessage.style.opacity = '0';
                    setTimeout(() => errorMessage.remove(), 300);
                }
            }, 5000);

            // Add focus effects to form inputs
            document.querySelectorAll('.form-control').forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.classList.add('focused');
                });
                
                input.addEventListener('blur', function() {
                    if (!this.value) {
                        this.parentElement.classList.remove('focused');
                    }
                });
            });
        </script>
    </body>
</html>