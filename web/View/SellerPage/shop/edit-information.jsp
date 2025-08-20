<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<main class="container border shadow" style="border-radius: 5px;">
    <div class="row p-4">

        <form action="manager-edit-shop" method="post" novalidate enctype="multipart/form-data">
            <!-- Hidden field for shop ID -->
            <input type="hidden" name="id" value="${shop.id}">

            <div class="row">
                <div class="col-md-4 text-center">
                    <c:choose>
                        <c:when test="${not empty shop.logo}">
                            <img src="${shop.logo}" alt="Shop Logo" class="profile-img img-fluid rounded-circle border" 
                                 style="width: 200px; height: 200px; object-fit: contain;">
                        </c:when>
                        <c:otherwise>
                            <img src="" alt="Default Logo" class="profile-img img-fluid rounded-circle border" 
                                 style="width: 200px; height: 200px; object-fit: contain;">
                        </c:otherwise>
                    </c:choose>
                    <br/>
                    <label for="fileInput" class="btn btn-outline-secondary mt-2">Select Logo</label>
                    <input type="file" id="fileInput" name="logo" class="d-none" accept="image/jpeg, image/png">
                    <p class="text-muted mt-2">Maximum file size 1 MB<br>Format: JPEG, PNG</p>
                    <input name="blobImage" value="${shop.logo}" type="hidden"/>
                    <input name="currentLogo" value="${shop.logo}" type="hidden"/>
                </div>

                <div class="col-md-8">
                    <div class="card">
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Shop Name:</label>
                                <input type="text" name="name" class="form-control" 
                                       value="${shop.name}" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Tax Code:</label>
                                <input type="text" name="tax" class="form-control" 
                                       value="${shop.tax}" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Description:</label>
                                <textarea name="describe" class="form-control" rows="3" 
                                          required>${shop.describe}</textarea>
                            </div>

                            <!-- Hidden field for userId -->
                            <input type="hidden" name="shopId" value="${shop.id}">
                        </div>
                    </div>
                </div>

                <div class="col-12 mt-3 text-center">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                    <a href="manager_view_information_shop?uid=${shop.userId}" class="btn btn-secondary">Cancel</a>
                </div>
            </div>
        </form>
    </div>
</main>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const fileInput = document.getElementById("fileInput");
        const profileImg = document.querySelector(".profile-img");

        fileInput.addEventListener("change", function () {
            if (validateFile(fileInput)) {
                convertToBlob(fileInput.files[0]);
            }
        });

        function validateFile(input) {
            const file = input.files[0];
            const maxSize = 1 * 1024 * 1024; // 1MB
            let errorMessage = "";

            if (file) {
                if (file.size > maxSize) {
                    errorMessage = "File too large! Please select an image under 1MB.";
                } else if (!["image/jpeg", "image/png"].includes(file.type)) {
                    errorMessage = "Only JPEG, PNG formats are supported.";
                }
            }

            if (errorMessage) {
                input.classList.add("is-invalid");
                setInvalidFeedback(input, errorMessage);
                input.value = "";
                return false;
            } else {
                input.classList.remove("is-invalid");
                input.classList.add("is-valid");
                removeInvalidFeedback(input);
                return true;
            }
        }

        function convertToBlob(file) {
            const reader = new FileReader();
            reader.onload = function (event) {
                const url = event.target.result;
                profileImg.src = url;
                document.querySelector("input[name='blobImage']").value = url;
            };
            reader.readAsDataURL(file);
        }

        function setInvalidFeedback(input, message) {
            let feedback = input.parentNode.querySelector(".invalid-feedback");
            if (!feedback) {
                feedback = document.createElement("div");
                feedback.className = "invalid-feedback";
                input.parentNode.appendChild(feedback);
            }
            feedback.textContent = message;
        }

        function removeInvalidFeedback(input) {
            let feedback = input.parentNode.querySelector(".invalid-feedback");
            if (feedback) {
                feedback.remove();
            }
        }
    });
</script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.querySelector("form");
        const inputs = form.querySelectorAll("input, textarea");

        inputs.forEach(input => {
            input.addEventListener("input", function () {
                validateField(input);
            });
        });

        form.addEventListener("submit", function (event) {
            let isValid = true;
            inputs.forEach(input => {
                if (!validateField(input)) {
                    isValid = false;
                }
            });

            if (!isValid) {
                event.preventDefault();
            }
        });

        function validateField(input) {
            const value = input.value.trim();
            const formGroup = input.closest(".mb-3");
            if (!formGroup)
                return true; // Bỏ qua nếu không nằm trong form group

            let errorMessage = "";

            if (input.name === "name") {
                errorMessage = validateShopName(value);
            } else if (input.name === "tax") {
                errorMessage = validateTaxCode(value);
            } else if (input.name === "describe") {
                errorMessage = validateDescription(value);
            }

            if (errorMessage) {
                input.classList.add("is-invalid");
                setInvalidFeedback(input, errorMessage);
                return false;
            } else {
                input.classList.remove("is-invalid");
                input.classList.add("is-valid");
                removeInvalidFeedback(input);
                return true;
            }
        }

        function validateShopName(value) {
            if (value.length < 2) {
                return "Shop name must be at least 2 characters long.";
            } else if (value.length > 100) {
                return "Shop name cannot exceed 100 characters.";
            }
            return "";
        }

        function validateTaxCode(value) {
            const taxRegex = /^\d{10}$|^\d{13}$/; // Chỉ chấp nhận 10 hoặc 13 số
            if (!taxRegex.test(value)) {
                return "Tax code must be exactly 10 or 13 digits.";
            }
            return "";
        }

        function validateDescription(value) {
            if (value.length < 2) {
                return "Description must be at least 2 characters long.";
            }
            return "";
        }

        function setInvalidFeedback(input, message) {
            let feedback = input.parentNode.querySelector(".invalid-feedback");
            if (!feedback) {
                feedback = document.createElement("div");
                feedback.className = "invalid-feedback";
                input.parentNode.appendChild(feedback);
            }
            feedback.textContent = message;
        }

        function removeInvalidFeedback(input) {
            let feedback = input.parentNode.querySelector(".invalid-feedback");
            if (feedback) {
                feedback.remove();
            }
        }
    });
</script>