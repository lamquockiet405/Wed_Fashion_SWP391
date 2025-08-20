<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Shop Bị Từ Chối</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .rejected-container {
            min-height: 100vh;
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .rejected-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            padding: 3rem;
            text-align: center;
            max-width: 500px;
            width: 100%;
        }
        .rejected-icon {
            font-size: 4rem;
            color: #dc3545;
            margin-bottom: 1rem;
        }
        .status-badge {
            background: #f8d7da;
            color: #721c24;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-weight: 600;
            display: inline-block;
            margin: 1rem 0;
        }
        .btn-home {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-home:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            color: white;
        }
        .btn-register {
            background: #28a745;
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-left: 10px;
        }
        .btn-register:hover {
            background: #218838;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            color: white;
        }
    </style>
</head>
<body>
    <div class="rejected-container">
        <div class="rejected-card">
            <div class="rejected-icon">
                <i class="fas fa-times-circle"></i>
            </div>
            
            <h2 class="mb-3 text-danger">Shop Bị Từ Chối</h2>
            
            <div class="status-badge">
                <i class="fas fa-ban me-2"></i>Đã Từ Chối
            </div>
            
            <p class="text-muted mb-4">
                Shop <strong>"${shopName}"</strong> của bạn đã bị Admin từ chối.
            </p>
            
            <div class="alert alert-danger" role="alert">
                <h6><i class="fas fa-exclamation-triangle me-2"></i>Lý Do Từ Chối:</h6>
                <p class="mb-0">${message}</p>
            </div>
            
            <div class="alert alert-info" role="alert">
                <h6><i class="fas fa-info-circle me-2"></i>Bạn Có Thể:</h6>
                <ul class="mb-0 text-start">
                    <li>Xem lại thông tin shop và sửa lỗi</li>
                    <li>Đăng ký lại shop với thông tin mới</li>
                    <li>Liên hệ Admin để được hỗ trợ</li>
                </ul>
            </div>
            
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/homePage" class="btn btn-home">
                    <i class="fas fa-home me-2"></i>Về Trang Chủ
                </a>
                <a href="${pageContext.request.contextPath}/RegisterShop" class="btn btn-register">
                    <i class="fas fa-plus me-2"></i>Đăng Ký Lại
                </a>
            </div>
            
            <div class="mt-3">
                <small class="text-muted">
                    <i class="fas fa-question-circle me-1"></i>
                    Cần hỗ trợ? Liên hệ <a href="#" class="text-primary">support@ecommerce.com</a>
                </small>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
