<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="mb-3">
    <label for="image_product" class="form-label fw-bold"><span class="text-danger">*</span>Upload File</label>
    <div class="d-flex flex-column align-items-center justify-content-center border border-2 border-secondary-subtle rounded p-2" 
         style="width: 120px; height: 120px; cursor: pointer;" id="upload-box">
        <input type="file" id="imageUpload" accept="image/*" multiple hidden>
        <img src="https://cdn-icons-png.flaticon.com/512/1829/1829586.png" class="mb-1" width="30" style="font-size: 12px;">
        <span class="text-danger fw-bold" id="image-count" style="font-size: 10px;">Add image (0/9)</span>
        <input type="hidden" name="img_convert_base64" value="${image != null ? image : ""}" id="getImgUpload"/>
    </div>
    <div class="invalid-feedback" id="imageError"></div>
    <div class="row mt-2" id="preview-container"></div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const maxImages = 9;
        const maxFileSize = 5 * 1024 * 1024; // 5MB
        const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
        const uploadBox = document.getElementById("upload-box");
        const imageUpload = document.getElementById("imageUpload");
        const previewContainer = document.getElementById("preview-container");
        const imageCountText = document.getElementById("image-count");
        const getImgUpload = document.getElementById("getImgUpload");

        // Khởi tạo mảng (convertImg chứa chuỗi Base64)
        window.convertImg = getImgUpload.value ? getImgUpload.value.split("|") : [];
        window.imageSuccess = []; // Chỉ chứa File mới tạm thời

        let totalSize = 0;

        // Hiển thị ảnh có sẵn khi tải trang
        displayExistingImages();

        uploadBox.addEventListener("click", function () {
            imageUpload.click();
        });

        imageUpload.addEventListener("change", function () {
            if (window.convertImg.length >= maxImages) {
                document.getElementById("imageError").textContent = "You can only upload up to 9 photos!";
                document.getElementById("upload-box").classList.add("is-invalid");
                imageUpload.value = '';
                return;
            }

            totalSize = 0;

            if (validateFile(imageUpload)) {
                convertToBlob(imageUpload.files);
            }

            imageUpload.value = '';
        });

        function validateFile(input) {
            const files = Array.from(input.files);
            let isValid = true;
            let errorMsg = "";

            files.forEach(file => {
                totalSize += file.size;

                if (totalSize > maxFileSize) {
                    errorMsg = 'File "' + file.name + '" exceeds maximum size (5MB).';
                    isValid = false;
                } else if (!allowedTypes.includes(file.type)) {
                    errorMsg = 'File "' + file.name + '" incorrect format (JPEG, JPG, PNG, GIF).';
                    isValid = false;
                } else if (isValid && window.convertImg.length < maxImages) {
                    window.imageSuccess.push(file);
                } else {
                    document.getElementById("imageError").textContent = "You can only upload up to 9 photos!";
                    document.getElementById("upload-box").classList.add("is-invalid");
                }
            });

            if (errorMsg) {
                document.getElementById("imageError").textContent = errorMsg;
                document.getElementById("upload-box").classList.add("is-invalid");
                return false;
            } else {
                document.getElementById("imageError").textContent = "";
                document.getElementById("upload-box").classList.remove("is-invalid");
            }

            updateImageCount();
            return true;
        }

        function convertToBlob(files) {
            const newFiles = Array.from(files);
            newFiles.forEach((file) => {
                const reader = new FileReader();
                reader.onload = function (event) {
                    const url = event.target.result;
                    if (window.convertImg.length < maxImages) {
                        window.convertImg.push(url);
                        updateHiddenInput();
                        refreshPreview();
                        updateImageCount();
                    }
                };
                reader.readAsDataURL(file);
            });
        }

        function displayExistingImages() {
            if (window.convertImg.length > 0) {
                refreshPreview();
                updateImageCount();
            }
        }

        function refreshPreview() {
            previewContainer.innerHTML = '';
            window.convertImg.forEach((url, index) => {
                const imageElement = document.createElement('div');
                imageElement.className = 'col-2 position-relative';
                imageElement.innerHTML = '<img src="' + url + '" class="img-fluid p-2 mb-2 me-2 border rounded" alt="Image Preview" style="width: 150px; height: 150px; object-fit: contain"><button class="btn btn-danger btn-sm rounded-circle" style = "position: absolute; top: -5px; right: 15px" onclick="deleteImage(' + index + ')">X</button>';
                previewContainer.appendChild(imageElement);
            });
        }

        function updateImageCount() {
            imageCountText.textContent = 'Add image (' + (window.convertImg.length + window.imageSuccess.length) + '/' + maxImages + ')';
        }

        function updateHiddenInput() {
            getImgUpload.value = window.convertImg.join("|");
        }

        window.deleteImage = function (index) {
            window.convertImg.splice(index, 1);
            updateHiddenInput();
            refreshPreview();
            updateImageCount();
        };

        // Hàm kiểm tra xem có ít nhất một hình ảnh được chọn hay không
        window.validateImageUpload = function () {
            return window.convertImg.length > 0;
        };
    });
</script>
