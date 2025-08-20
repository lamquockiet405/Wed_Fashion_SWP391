<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chờ Duyệt Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .pending-container {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .pending-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            padding: 3rem;
            text-align: center;
            max-width: 500px;
            width: 100%;
        }
        .pending-icon {
            font-size: 4rem;
            color: #ffc107;
            margin-bottom: 1rem;
        }
        .status-badge {
            background: #fff3cd;
            color: #856404;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-weight: 600;
            display: inline-block;
            margin: 1rem 0;
        }
        .btn-home {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
    </style>
</head>
<body>
    <div class="pending-container">
        <div class="pending-card">
            <div class="pending-icon">
                <i class="fas fa-clock"></i>
            </div>
            
            <h2 class="mb-3 text-primary">Đăng Ký Shop Thành Công!</h2>
            
            <div class="status-badge">
                <i class="fas fa-hourglass-half me-2"></i>Đang Chờ Duyệt
            </div>
            
            <p class="text-muted mb-4">
                Shop <strong>"${shopName}"</strong> của bạn đã được đăng ký thành công và đang chờ Admin duyệt.
            </p>
            
            <div class="alert alert-info" role="alert">
                <h6><i class="fas fa-info-circle me-2"></i>Quy Trình Duyệt:</h6>
                <ul class="mb-0 text-start">
                    <li>Admin sẽ xem xét thông tin shop của bạn</li>
                    <li>Thời gian duyệt thường từ 1-3 ngày làm việc</li>
                    <li>Bạn sẽ nhận được email thông báo kết quả</li>
                    <li>Sau khi được duyệt, bạn có thể bắt đầu bán hàng</li>
                </ul>
            </div>
            
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/homePage" class="btn btn-home">
                    <i class="fas fa-home me-2"></i>Về Trang Chủ
                </a>
            </div>
            
            <div class="mt-3">
                <small class="text-muted">
                    <i class="fas fa-question-circle me-1"></i>
                    Có câu hỏi? Liên hệ <a href="#" class="text-primary">support@ecommerce.com</a>
                </small>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
