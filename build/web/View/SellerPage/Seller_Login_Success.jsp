<%-- 
    Document   : Seller_Login_Success
    Created on : Jan 29, 2025, 1:28:45 PM
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Seller Login Success</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .success-container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0,0,0,0.1);
                padding: 60px 40px;
                text-align: center;
                max-width: 500px;
                width: 90%;
                animation: slideIn 0.6s ease-out;
            }

            .success-icon {
                font-size: 80px;
                color: #27ae60;
                margin-bottom: 30px;
                animation: bounce 1s ease-in-out;
            }

            .success-title {
                font-size: 32px;
                font-weight: 700;
                color: #2c3e50;
                margin-bottom: 20px;
            }

            .success-message {
                font-size: 18px;
                color: #7f8c8d;
                margin-bottom: 40px;
                line-height: 1.6;
            }

            .redirect-btn {
                background: linear-gradient(135deg, #3498db, #2980b9);
                color: white;
                padding: 15px 30px;
                border: none;
                border-radius: 50px;
                font-size: 16px;
                font-weight: 600;
                text-decoration: none;
                display: inline-block;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
            }

            .redirect-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
                color: white;
                text-decoration: none;
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(-50px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @keyframes bounce {
                0%, 20%, 50%, 80%, 100% {
                    transform: translateY(0);
                }
                40% {
                    transform: translateY(-10px);
                }
                60% {
                    transform: translateY(-5px);
                }
            }

            @media (max-width: 768px) {
                .success-container {
                    padding: 40px 20px;
                }
                
                .success-title {
                    font-size: 24px;
                }
                
                .success-message {
                    font-size: 16px;
                }
            }
        </style>
    </head>
    <body>
        <div class="success-container">
            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <h1 class="success-title">Đăng nhập thành công!</h1>
            <p class="success-message">Chào mừng bạn đến với Seller Panel. Bạn sẽ được chuyển hướng trong giây lát...</p>
            <a href="view_product" class="redirect-btn">
                <i class="fas fa-arrow-right"></i> Tiếp tục
            </a>
        </div>

        <script>
            // Auto redirect after 3 seconds
            setTimeout(function() {
                window.location.href = "view_product";
            }, 3000);
        </script>
    </body>
</html>
