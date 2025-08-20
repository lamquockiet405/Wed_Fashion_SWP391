<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="mb-3">
    <label class="form-label fw-bold"><span class="text-danger">*</span>Product Variant</label>
    <div class="p-3">
        <div id="product_variant">
            <table class="table table-bordered">
                <thead>
                    <tr class="text-center row">
                        <th class="col-md-3">Product Variant Image</th>
                        <th class="col-md">Product Variant Name</th>
                        <th class="col-md">Price</th>
                        <th class="col-md">Stock Quantity</th>
                        <th class="col-md-1">Action</th>
                    </tr>
                </thead>
                <tbody id="variant_tbody">
                    <c:choose>
                        <c:when test="${productVariantList != null}">
                            <c:forEach var="pv" items="${productVariantList}">
                                <tr class="text-center row variant-row">
                            <input type="hidden" name="productVariantId" value="${pv.productVariantId}" />
                            <td class="col-md-3">
                                <div class="d-flex flex-column align-items-center justify-content-center">
                                    <input type="hidden" class="img_product_variant" value="${pv.image}" name="img_product_variant" />
                                    <img class="mb-1 border rounded image_preview" src="${pv.image}" alt="Image preview" style="width: 100px; height: 100px; padding: 1px; object-fit: contain; ">
                                    <input hidden type="file" class="form-control product_variant_image" name="product_variant_image" accept="image/*" required>
                                    <label class="btn btn-secondary btn-sm upload-btn">Upload</label>
                                    <div class="invalid-feedback">Please select an image.</div>
                                </div>
                            </td>
                            <td class="col-md text-start d-flex flex-column align-items-center justify-content-center">
                                <input class="form-control" value="${pv.productVariantName}" type="text" name="product_variant_name" 
                                       placeholder="Enter product variant name" required/>
                                <div class="invalid-feedback">Product variant name is not empty.</div>
                            </td>
                            <td class="col-md text-start d-flex flex-column align-items-center justify-content-center">
                                <input class="form-control" name="price" value="${pv.price}" type="number"
                                       placeholder="Enter the price" required min="1001" step="0.5"/>
                                <div class="invalid-feedback">Price must be greater than 1,000.</div>
                            </td>
                            <td class="col-md text-start d-flex flex-column align-items-center justify-content-center">
                                <input class="form-control" value="${pv.stockQuantity}" type="number" name="stockQuantity" 
                                       placeholder="Enter stock quantity" required min="1" step="1"/>
                                <div class="invalid-feedback">Stock quantity must be greater than 1.</div>
                            </td>
                            <td class="col-md-1 d-flex flex-column align-items-center justify-content-center">
                                <span class="d-flex justify-content-center align-items-center remove-variant" 
                                      style="cursor: pointer">
                                    <i class="bi bi-trash-fill text-danger" style="font-size: 24px;"></i>
                                </span>
                            </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr class="text-center row variant-row">
                            <td class="col-md-3">
                                <div class="d-flex flex-column align-items-center justify-content-center">
                                    <input type="hidden" class="img_product_variant" name="img_product_variant" />
                                    <img class="mb-1 border rounded image_preview" src="#" alt="Image preview" style="width: 100px; display: none; height: 100px; padding: 1px; object-fit: contain; ">
                                    <input hidden type="file" class="form-control product_variant_image" name="product_variant_image" accept="image/*" required>
                                    <label class="btn btn-secondary btn-sm upload-btn">Upload</label>
                                    <div class="invalid-feedback">Please select an image.</div>
                                </div>
                            </td>
                            <td class="col-md text-start d-flex flex-column align-items-center justify-content-center">
                                <input class="form-control" value="" type="text" name="product_variant_name" 
                                       placeholder="Enter product variant name" required/>
                                <div class="invalid-feedback">Product variant name is not empty.</div>
                            </td>
                            <td class="col-md text-start d-flex flex-column align-items-center justify-content-center">
                                <input class="form-control" name="price" value="" type="number"
                                       placeholder="Enter the price" required min="1001"/>
                                <div class="invalid-feedback">Price must be greater than 1,000.</div>
                            </td>
                            <td class="col-md text-start d-flex flex-column align-items-center justify-content-center">
                                <input class="form-control" value="" type="number" name="stockQuantity" 
                                       placeholder="Enter stock quantity" required min="2"/>
                                <div class="invalid-feedback">Stock quantity must be greater than 1.</div>
                            </td>
                            <td class="col-md-1 d-flex flex-column align-items-center justify-content-center">
                                <span class="d-flex justify-content-center align-items-center remove-variant" 
                                      style="cursor: pointer">
                                    <i class="bi bi-trash-fill text-danger" style="font-size: 24px;"></i>
                                </span>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
            <div class="d-flex justify-content-center">
                <span class="border pt-2 pb-2 ps-3 pe-3 rounded text-center bg-warning" id="product_variant_add_more" style="cursor: pointer">
                    Add more product variant
                </span>
            </div>
        </div>
    </div>
</div>

<script>
    const maxFileSize = 1 * 1024 * 1024; // 1MB in bytes
    // Xử lý preview ảnh và upload button cho từng variant
    function setupVariantRow(row) {
        const input = row.querySelector('.product_variant_image');
        const img_product_variant = row.querySelector('.img_product_variant');
        const preview = row.querySelector('.image_preview');
        const uploadBtn = row.querySelector('.upload-btn');
        const stockInput = row.querySelector('input[name="stockQuantity"]');
        const feedback = row.querySelector('.invalid-feedback'); // Lấy phần tử feedback
        
        // Gắn sự kiện click cho button upload
        uploadBtn.addEventListener('click', () => input.click());

        // Xử lý preview ảnh khi chọn file
        input.addEventListener('change', function (e) {
            const file = e.target.files[0];
            
            if (file) {
                // Kiểm tra kích thước file
                if (file.size > maxFileSize) {
                    feedback.textContent = "File is greater than 1MB.";
                    input.classList.add('is-invalid');
                    input.classList.remove('is-valid');
                    preview.src = '#';
                    preview.style.display = 'none';
                    img_product_variant.value = '';
                    input.value = ''; // Xóa file đã chọn
                    return;
                }

                const reader = new FileReader();
                reader.onload = function (e) {
                    const url = e.target.result;
                    preview.src = url;
                    img_product_variant.value = url;
                    preview.style.display = 'block';
                    input.classList.remove('is-invalid');
                    input.classList.add('is-valid');
                    feedback.textContent = ''; // Xóa thông báo lỗi nếu hợp lệ
                };
                reader.readAsDataURL(file);
            } else {
                preview.src = '#';
                preview.style.display = 'none';
                img_product_variant.value = '';
            }
        });

        stockInput.addEventListener('keydown', function (e) {
            const allowedKeys = ["Backspace", "ArrowLeft", "ArrowRight", "Delete", "Tab"];
            if (!/^\d$/.test(e.key) && !allowedKeys.includes(e.key)) {
                e.preventDefault();
            }
        });

        stockInput.addEventListener('input', function () {
            let value = this.value;
            this.value = value.replace(/^0+(\d)/, '$1');
            if (this.value === "" || parseInt(this.value) < 2) {
                this.classList.add('is-invalid');
                this.classList.remove('is-valid');
            } else {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            }
        });

        // Xử lý xóa variant
        const removeBtn = row.querySelector('.remove-variant');
        removeBtn.addEventListener('click', function () {
            const variantCount = document.querySelectorAll('.variant-row').length;
            if (variantCount > 1) {
                row.remove();
            } else {
                alert('Cannot remove the last variant!');
            }
        });
    }

// Khởi tạo cho tất cả các variant-row hiện có
    const variantRows = document.querySelectorAll('.variant-row');
    variantRows.forEach(row => setupVariantRow(row));

// Xử lý thêm variant mới
    document.getElementById('product_variant_add_more').addEventListener('click', function () {
        const tbody = document.getElementById('variant_tbody');
        const newRow = document.createElement('tr');
        newRow.className = 'text-center row variant-row';
        newRow.innerHTML = `
        <td class="col-md-3">
            <div class="d-flex flex-column align-items-center justify-content-center">
                <input type="hidden" class="img_product_variant" name="img_product_variant" />
                <img class="mb-1 border rounded image_preview" src="#" alt="Image preview" style="width: 100px; display: none; height: 100px; padding: 1px; object-fit: contain; ">
                <input hidden type="file" class="form-control product_variant_image" name="product_variant_image" accept="image/*" required>
                <label class="btn btn-secondary btn-sm upload-btn">Upload</label>
                <div class="invalid-feedback">Please select an image.</div>
            </div>
        </td>
        <td class="col-md text-start d-flex flex-column align-items-center justify-content-center">
            <input class="form-control" value="" type="text" name="product_variant_name" 
                   placeholder="Enter product variant name" required/>
            <div class="invalid-feedback">Product variant name is not empty.</div>
        </td>
        <td class="col-md text-start d-flex flex-column align-items-center justify-content-center">
            <input class="form-control" name="price" value=""  type="number"
                   placeholder="Enter the price" required min="1001" step="0.5"/>
            <div class="invalid-feedback">Price must be greater than 1,000.</div>
        </td>
        <td class="col-md text-start d-flex flex-column align-items-center justify-content-center">
            <input class="form-control" value="" type="number" name="stockQuantity" 
                   placeholder="Enter stock quantity" required min="2" step="1"/>
            <div class="invalid-feedback">Stock quantity must be greater than 1.</div>
        </td>
        <td class="col-md-1 d-flex align-items-center justify-content-center">
            <span class="d-flex justify-content-center align-items-center remove-variant" 
                  style="cursor: pointer">
                <i class="bi bi-trash-fill text-danger" style="font-size: 24px;"></i>
            </span>
        </td>
    `;
        tbody.appendChild(newRow);
        setupVariantRow(newRow);
    });
</script>