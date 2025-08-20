<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Địa Chỉ Của Tôi</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .address-container { background: #fff; padding: 20px; border-radius: 8px; }
        .address-item { border-bottom: 1px solid #ddd; padding: 15px 0; }
        .default-label { color: red; font-weight: bold; }
        .btn-container { text-align: right; margin-top: 10px; }
        .btn-small { font-size: 14px; padding: 5px 10px; }
    </style>
</head>
<body>
<div class="container mt-4">
    <div class="address-container">
        <h4>Địa chỉ của tôi</h4>
        <div class="btn-container">
            <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#addAddressModal">+ Thêm địa chỉ mới</button>
        </div>

        <div class="mt-3">
            <c:forEach var="sa" items="${ShippingAddressesList}">
                <div class="address-item">
                    <div>
                        Tên người nhận: <strong>${sa.username}</strong> 
                        | Số điện thoại: <span>(${sa.phoneNumber})</span>
                    </div>
                    <div>Địa Chỉ: ${sa.address}</div>
                    
                    <c:if test="${sa.status == 'True'}">
                        <span class="default-label">Trạng thái: Mặc định</span>
                    </c:if>
                  
                    <div class="btn-container">
                        <button class="btn btn-primary btn-small edit-btn" 
                                data-id="${sa.id}" 
                                data-username="${sa.username}" 
                                data-phone="${sa.phoneNumber}" 
                                data-address="${sa.address}" 
                                data-bs-toggle="modal" 
                                data-bs-target="#editAddressModal">
                            Cập nhật
                        </button>
                        <a href="DeleteAddress?id=${sa.id}" class="btn btn-danger btn-small">Xóa</a>
                        <a href="SetAddressDefault?id=${sa.id}" class="btn btn-secondary btn-small">Thiết lập mặc định</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<!-- Modal Thêm Địa Chỉ -->
<div class="modal fade" id="addAddressModal" tabindex="-1" aria-labelledby="addAddressLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addAddressLabel">Địa chỉ mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/AddAddress" method="post">
                    <div class="mb-3">
                        <label class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" name="phoneNumber" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" name="address" required>
                    </div>
                    
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Trở Lại</button>
                        <button type="submit" class="btn btn-danger">Hoàn thành</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Cập Nhật Địa Chỉ -->
<div class="modal fade" id="editAddressModal" tabindex="-1" aria-labelledby="editAddressLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editAddressLabel">Cập nhật địa chỉ</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/UpdateAddress" method="post">
                    <input type="hidden" id="edit-id" name="id">
                    <div class="mb-3">
                        <label class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" id="edit-username" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" id="edit-phone" name="phoneNumber" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" id="edit-address" name="address" required>
                    </div>
                    
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const editButtons = document.querySelectorAll(".edit-btn");
        editButtons.forEach(button => {
            button.addEventListener("click", function () {
                document.getElementById("edit-id").value = this.dataset.id;
                document.getElementById("edit-username").value = this.dataset.username;
                document.getElementById("edit-phone").value = this.dataset.phone;
                document.getElementById("edit-address").value = this.dataset.address;
            });
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
