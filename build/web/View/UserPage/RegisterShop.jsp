
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shop Register</title>
        <link rel="stylesheet" href="RegisterShop.css">
    </head>
    <body>
        <form id="registerShopForm" action="/Ecommerce_SWP/RegisterShop" method="post" enctype="multipart/form-data" onsubmit="return validateShopForm()">
            <div class="container">
                <h2>Shop Information</h2>
                <label for="shop-name">Shop Name</label>
                <input type="text" id="shop-name" name="ShopName" placeholder="Input Shop Name" required="">
                <span id="shopNameError" class="error-message"></span>

                <label for="tax">Tax</label>
                <input type="text" id="tax" name="tax" placeholder="Input Tax" value="" required="">
                <span id="taxError" class="error-message"></span>

                <label for="describe">Shop Describe</label>
                <input type="text" id="describe" name="describe" placeholder="Input Shop Describe" required="">
                <span id="describeError" class="error-message"></span>

                <div class="btn-group">
                    <a href="${pageContext.request.contextPath}/homePage" class="btn-cancel">Cancel</a>
                    <button type="submit">Submit</button>
                </div>

            </div>
        </form>


        <script>
            function validateShopForm() {
                let isValid = true;

                // Validate Shop Name (ít nhất 10 ký tự)
                let shopName = document.getElementById("shop-name").value;
                let shopNameError = document.getElementById("shopNameError");
                if (shopName.length < 10) {
                    shopNameError.innerText = "Tên shop phải có ít nhất 10 ký tự.";
                    shopNameError.classList.add("show");
                    isValid = false;
                } else {
                    shopNameError.innerText = "";
                    shopNameError.classList.remove("show");
                }

                // Validate Tax Code (chỉ được 10 số)
                let tax = document.getElementById("tax").value;
                let taxError = document.getElementById("taxError");
                if (!/^\d{10}$/.test(tax)) {
                    taxError.innerText = "Mã số thuế phải có đúng 10 chữ số.";
                    taxError.classList.add("show");
                    isValid = false;
                } else {
                    taxError.innerText = "";
                    taxError.classList.remove("show");
                }

                // Validate Shop Description (ít nhất 50 ký tự)
                let describe = document.getElementById("describe").value;
                let describeError = document.getElementById("describeError");
                if (describe.length < 50) {
                    describeError.innerText = "Mô tả cửa hàng phải có ít nhất 50 ký tự.";
                    describeError.classList.add("show");
                    isValid = false;
                } else {
                    describeError.innerText = "";
                    describeError.classList.remove("show");
                }

                return isValid;
            }
        </script>

        <script>
            function previewImage(event) {
                var input = event.target;
                var reader = new FileReader();

                reader.onload = function () {
                    var imgElement = document.getElementById("preview");
                    imgElement.src = reader.result;
                    imgElement.style.display = "block"; // Hiển thị ảnh sau khi chọn
                };

                if (input.files && input.files[0]) {
                    reader.readAsDataURL(input.files[0]);
                }
            }
        </script>




    </body>
</html>
