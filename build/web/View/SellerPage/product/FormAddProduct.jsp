<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<main class="container ">
    <h2 class="mb-4 text-center"> ${action != null ? action : "Add New"}  Product</h2>
    <form class="border p-3 rounded shadow" action="${action != null ? "update_product" : "add_new_product"}" method="post" enctype="multipart/form-data" novalidate>
        <jsp:include page="./image_upload.jsp" />
        <!-- Product Name -->
        <div class="mb-3">
            <label for="product_name" class="form-label fw-bold">
                <span class="text-danger">*</span>Product Name  <span id="name_counter" class="text-muted">(${product != null ? product.productName.length() : "0"}/100)</span>
            </label>
            <input class="form-control" id="product_name" type="text" value="${product != null ? product.productName : ""}" name="productName" 
                   placeholder="Enter the product name" required minlength="2"/>
            <div class="invalid-feedback">Product name must be between 2 and 100 characters.</div>
        </div>

        <jsp:include page="./ProductVariant.jsp" />

        <!-- Category ID -->
        <c:if test="${action == null}">
            <div class="mb-3">
                <label for="category_id" class="form-label fw-bold"><span class="text-danger">*</span>Category</label>
                <select name="category" class="form-select" id="category_id" required>
                    <option value="">Select category</option>
                    <c:forEach var="category" items="${categoryList}">
                        <option value="${category.categoryId}" ${product != null ? ((product.categoryId + "").equals((category.categoryId + "")) ? "selected" : "") : ""}>${category.categoryName}</option>
                    </c:forEach>
                </select>
                <div class="invalid-feedback">Please select a category.</div>
            </div>
        </c:if>

        <!-- Description -->
        <div class="mb-3">
            <label for="description" class="form-label fw-bold">
                <span class="text-danger">*</span>Description 
                <span id="desc_counter" class="text-muted">(${product != null ? product.description.length() : "0"}/3000)</span>
            </label>
            <textarea class="form-control" id="description" name="description" rows="3" 
                      placeholder="Enter product description" required minlength="2" maxlength="3000">${product != null ? product.description : ""}</textarea>
            <div class="invalid-feedback">Description must be between 2 and 3000 characters.</div>
        </div>

        <!-- Submit Button -->
        <div class="d-flex justify-content-center">
            <button type="submit" class="btn ${action != null ? "btn-warning" : "btn-primary"}">${action != null ? action : "Add"} Product</button>
        </div>
        <input type="hidden" name="idProduct" value="${product != null ? product.productId : ""}" />
    </form>
</main>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.querySelector("form");
        const inputs = document.querySelectorAll("input, textarea, select");
        const nameCounter = document.getElementById("name_counter");
        const descCounter = document.getElementById("desc_counter");
        const nameInput = document.getElementById("product_name");
        const descInput = document.getElementById("description");

        const categorySelect = document.getElementById("category_id");
        if (categorySelect) {
            categorySelect.addEventListener("change", function () {
                validateField(categorySelect);
            });
        }

        // Đếm ký tự cho Product Name
        nameInput.addEventListener("input", function () {
            nameCounter.textContent = "(" + nameInput.value.trim().replace(/\s+/g, " ").length + "/100)";
            validateField(nameInput);
        });

        // Đếm ký tự cho Description
        descInput.addEventListener("input", function () {
            descCounter.textContent = "(" + descInput.value.trim().length + "/3000)";
            validateField(descInput);
        });

        // Hàm gắn sự kiện input cho tất cả các trường
        function setupInputListeners() {
            document.querySelectorAll("input, textarea, select").forEach(input => {
                input.removeEventListener("input", handleInput); // Tránh gắn trùng
                input.addEventListener("input", handleInput);
            });
        }

        function handleInput(e) {
            const input = e.target;
            if (input.closest("#product_variant")) {
                validateProductVariant(input);
            } else {
                validateField(input);
            }
        }

        setupInputListeners();

        // Xử lý submit form
        form.addEventListener("submit", function (event) {
            let isValid = true;

            // Kiểm tra upload ảnh
            if (!window.validateImageUpload()) {
                document.getElementById("imageError").textContent = "Please upload at least one image.";
                document.getElementById("upload-box").classList.add("is-invalid");
                isValid = false;
            }

            // Kiểm tra tất cả các input, textarea, select
            document.querySelectorAll("input, textarea, select").forEach(input => {
                if (input.closest("#product_variant")) {
                    if (!validateProductVariant(input)) {
                        isValid = false;
                    }
                } else {
                    console.log(input);
                    if (!validateField(input)) {
                        isValid = false;
                    }
                }
            });

            // Kiểm tra riêng category_id nếu action là add new
            const categorySelect = document.getElementById("category_id");
            if (categorySelect && !validateField(categorySelect)) {
                isValid = false;
            }

            if (!isValid) {
                event.preventDefault();
            }
        });

        // Hàm validate cho các trường thông thường
        function validateField(input) {
            const value = input.value.trim();
            const formGroup = input.closest(".mb-3");
            if (!formGroup)
                return true;

            let errorMessage = "";

            if (input.id === "product_name" && value === "") {
                errorMessage = "Product name is required.";
            } else if (input.id === "product_name" && (value.replace(/\s+/g, " ").length < 2 || value.replace(/\s+/g, " ").length > 100)) {
                errorMessage = "Product name must be between 2 and 100 characters.";
            }
            if (input.id === "description" && value === "") {
                errorMessage = "Product description is required.";
            } else if (input.id === "description" && (value.length < 2 || value.length > 3000)) {
                errorMessage = "Description must be between 2 and 3000 characters.";
            }
            if (input.id === "category_id" && value === "") {
                errorMessage = "Please select a category.";
            }

            if (errorMessage) {
                input.classList.add("is-invalid");
                input.classList.remove("is-valid");
                setInvalidFeedback(input, errorMessage);
                return false;
            } else {
                input.classList.remove("is-invalid");
                input.classList.add("is-valid");
                removeInvalidFeedback(input);
                return true;
            }
        }

        // Hàm validate riêng cho product variant
        function validateProductVariant(input) {
            const value = input.value.trim();
            const container = input.closest(".d-flex") || input.closest(".variant-row");
            let errorMessage = "";
            const preview = container.querySelector('.image_preview');
            const imgProductVariant = container.querySelector('.img_product_variant');


            if (input.classList.contains('product_variant_image')) {
                const file = input.files[0];
                if (!file && (!preview.src || preview.src === '#' || !imgProductVariant.value)) {
                    errorMessage = "Please select an image.";
                } else if (file && file.size > maxFileSize) {
                    errorMessage = "File is greater than 1MB.";
                }
            }

            if (input.name === "product_variant_name" && value === "") {
                errorMessage = "Product variant name is required.";
            }
            if (input.name === "product_variant_name" && value !== "") {
                const allVariantNames = Array.from(document.querySelectorAll('input[name="product_variant_name"]'))
                        .map(nameInput => nameInput.value.trim());
                const duplicateCount = allVariantNames.filter(name => name === value).length;
                if (duplicateCount > 1) {
                    errorMessage = "Product variant name already exists.";
                }
            }
            if (input.name === "price" && value === "") {
                errorMessage = "Price is required.";
            } else if (input.name === "price" && parseFloat(value) <= 1000) {
                errorMessage = "Price must be greater than 1,000.";
            }
            if (input.name === "stockQuantity" && value === "") {
                errorMessage = "Stock quantity is required.";
            } else if (input.name === "stockQuantity" && parseInt(value) <= 1) {
                errorMessage = "Stock quantity must be greater than 1.";
            }

            if (errorMessage) {
                input.classList.add("is-invalid");
                input.classList.remove("is-valid");
                setInvalidFeedback(input, errorMessage);
                return false;
            } else {
                input.classList.remove("is-invalid");
                input.classList.add("is-valid");
                removeInvalidFeedback(input);
                return true;
            }
        }

        // Hàm hỗ trợ
        function setInvalidFeedback(input, message) {
            let feedback = input.parentNode.querySelector(".invalid-feedback");
            if (feedback) {
                feedback.textContent = message;
            }
        }

        function removeInvalidFeedback(input) {
            let feedback = input.parentNode.querySelector(".invalid-feedback");
            if (feedback) {
                feedback.textContent = "";
            }
        }

        // Cập nhật listener khi thêm variant mới
        document.getElementById('product_variant_add_more').addEventListener('click', function () {
            setTimeout(setupInputListeners, 100); // Đợi DOM cập nhật
        });
    });
</script>
