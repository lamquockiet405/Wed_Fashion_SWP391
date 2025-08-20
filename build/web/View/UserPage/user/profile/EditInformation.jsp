<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Edit information</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                background-color: #f8f9fa;
            }
            .container {
                max-width: 800px;
                margin: 50px auto;
                background: #fff;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
            }
            .profile-img {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
                border: 4px solid #007bff;
            }
            .form-label {
                font-weight: bold;
            }
            .btn-save {
                background-color: #dc3545;
                color: white;
                width: 100px;
            }
            .btn-change {
                color: #007bff;
                text-decoration: none;
                font-size: 14px;
            }
        </style>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                background-color: #f8f9fa;
            }
            .sidebar {
                height: 100vh;
                background-color: #ffffff;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            }
            .sidebar .btn-toggle {
                width: 100%;
                text-align: left;
                color: #333;
                font-weight: 500;
            }
            .sidebar .btn-toggle:hover {
                background-color: #bfdbfe;
            }
            .sidebar a {
                display: block;
                padding: 5px 15px;
                color: #555;
                text-decoration: none;
            }
            .sidebar a:hover {
                background-color: #bfdbfe;
                border-radius: 5px;
            }

            .active__sidebar__tiem  {
                background-color: #f8f9fa;
                border-left: 4px solid #ffc107;
                border-radius: 5px;
                font-weight: bold;
                margin-top: 8px;
                margin-bottom: 8px;
                transition: background-color 0.3s ease-in-out, transform 0.2s ease-in-out;
            }
        </style>
    </head>
    <body>
        <jsp:include page="./../../../Header/Header.jsp" />
        <div class="row">
            <div class="col-md-2">
                <jsp:include page="./../sidebar.jsp" />
            </div>
            <div class="col-md">
                <div class="container p-4">
                    <h4>My Profile</h4>
                    <p class="text-muted">Manage profile information to keep your account secure.</p>
                    <hr/>
                    <form method="post" action="edit_information" id="profileForm" novalidate enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-md-8 border-end">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">First name</label>
                                        <input type="text" name="firstName" id="firstName" value="${user.firstName}" class="form-control" required>
                                        <div class="invalid-feedback">First name is not blank</div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Last name</label>
                                        <input type="text" name="lastName" value="${user.lastName}" id="lastName" class="form-control" required>
                                        <div class="invalid-feedback">Last name is not black.</div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" name="email" value="${user.email}" id="email" class="form-control" required>
                                    <div class="invalid-feedback">Email is not valid.</div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Phone number</label>
                                    <input type="text" name="phoneNumber" value="${user.phoneNumber}" id="phoneNumber" class="form-control" required>
                                    <div class="invalid-feedback">Phone number is not valid(9-11 digits).</div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Address</label>
                                    <textarea name="address"  id="address" class="form-control" required>${user.address}</textarea>
                                    <div class="invalid-feedback">Address is not blank.</div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Gender</label>
                                    <div>
                                        <input type="radio" id="male" name="gender" value="male" ${user.gender ? "checked" : ""} required>
                                        <label for="male">Male</label>
                                        <input type="radio" id="female" name="gender" value="female" ${!user.gender ? "checked" : ""}>
                                        <label for="female">Female</label>
                                    </div>
                                    <div class="invalid-feedback">Please choose gender.</div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Date of birth</label>
                                    <input type="date" name="dob" id="dob" value="${user.dateOfBirth}" class="form-control" required>
                                    <div class="invalid-feedback">Please select date of birth.</div>
                                </div>

                                <div class="d-flex justify-content-center">
                                    <button type="submit" class="btn btn-danger" style="padding: 8px 32px">Save</button>
                                </div>
                            </div>

                            <!--image--> 
                            <div class="col-md-4 text-center">
                                <c:choose>
                                    <c:when test="${not empty user.image}">
                                        <img src="${user.image}" alt="Avatar" class="profile-img">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="image/avtdf.jpg" alt="Avatar" class="profile-img">
                                    </c:otherwise>
                                </c:choose>
                                <br/>
                                <label for="fileInput" class="btn btn-outline-secondary mt-2">Select Photo</label>
                                <input type="file" id="fileInput" name="profile" class="d-none " accept="image/jpeg, image/png">
                                <p class="text-muted mt-2">Maximum file size 1 MB<br>Format: JPEG, PNG</p>
                                <input name="blobImage" type="hidden"/>
                                <input name="profile" value="${user.image}" type="hidden"/>
                            </div>

                            <input name="id" type="hidden" value="${user.userId}" />
                        </div>
                    </form>
                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            const fileInput = document.getElementById("fileInput"); // lấy thẻ html bởi id 
                            const profileImg = document.querySelector(".profile-img"); // lấy thẻ html bởi cái j đó 

                            fileInput.addEventListener("change", function () {
                                if (validateFile(fileInput)) {
                                    convertToBlob(fileInput.files[0]); // mã hoá ảnh
                                }
                            });

                            function validateFile(input) {
                                const file = input.files[0];
                                const maxSize = 1 * 1024 * 1024; // 1MB
                                let errorMessage = ""; //fale hy

                                if (file) {
                                    if (file.size > maxSize) {
                                        errorMessage = "File too large! Please select an image under 1MB."; // true hy
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
                                const reader = new FileReader(); // khởi tạo đối tượng để đọc file 
                                reader.onload = function (event) {
                                    const url = event.target.result;
                                    profileImg.src = url;
                                    document.querySelector("input[name='blobImage']").value = url;
                                };
                                reader.readAsDataURL(file); // đọc giữ liệu từ file và mã hoá về base64
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
                        function isValidPhoneNumber(phone) {
                            const PHONE_PATTERN = /^(?:\+84|0)(3[2-9]|8[1-5]|7[06-9]|9[0-9]|5[2689])\d{7}$/;
                            if (!/^[0-9\+]+$/.test(phone)) {
                                return "Phone numbers must contain only numbers and can start with a '+' sign.";
                            }
                            if (!/^(?:\+84|0)\d{9}$/.test(phone)) {
                                return "Phone number must start with +84 or 0, and then 9 digits.";
                            }
                            if (!PHONE_PATTERN.test(phone)) {
                                return "Phone number is not valid in Vietnam.";
                            }
                            return "";
                        }

                        function isValidEmail(email) {
                            const EMAIL_PATTERN = /^(?=.{6,254}$)(?!.*\.\.)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,63}$/;
                            if (email.length < 6 || email.length > 254) {
                                return "Email must be between 6 and 254 characters long.";
                            }
                            if (email.includes("..")) {
                                return "Email cannot have two consecutive periods.";
                            }
                            if (!email.includes("@")) {
                                return "Email must contain the '@' character.";
                            }
                            if (!/^[a-zA-Z0-9._%+-]+@.+$/.test(email)) {
                                return "Invalid email username.";
                            }
                            if (!/^.+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,63}$/.test(email)) {
                                return "Invalid email domain.";
                            }
                            if (!EMAIL_PATTERN.test(email)) {
                                return "Invalid email format.";
                            }
                            return "";
                        }

                        // Hàm kiểm tra ngày sinh
                        function isValidDateOfBirth(dob) {
                            const selectedDate = new Date(dob);
                            const today = new Date();
                            today.setHours(0, 0, 0, 0); // Đặt giờ về 00:00:00 để so sánh chính xác ngày

                            if (selectedDate >= today) {
                                return "Date of birth cannot be today or in the future.";
                            }
                            return "";
                        }

                        document.addEventListener("DOMContentLoaded", function () {
                            const form = document.querySelector("#profileForm");
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

                                // Kiểm tra radio button
                                const genderSelected = form.querySelector('input[name="gender"]:checked');
                                if (!genderSelected) {
                                    isValid = false;
                                    const genderDiv = form.querySelector('input[name="gender"]').parentNode;
                                    setInvalidFeedback(genderDiv.querySelector('input'), "Please choose gender.");
                                }

                                if (!isValid) {
                                    event.preventDefault();
                                }
                            });

                            function validateField(input) {
                                const value = input.value.trim();
                                const formGroup = input.closest(".mb-3");
                                if (!formGroup)
                                    return true;

                                let errorMessage = "";

                                if (input.required && value === "") {
                                    errorMessage = "Please enter information.";
                                } else if (input.name === "phoneNumber") {
                                    errorMessage = isValidPhoneNumber(value);
                                } else if (input.name === "email") {
                                    errorMessage = isValidEmail(value);
                                } else if (input.name === "dob") {
                                    errorMessage = isValidDateOfBirth(value);
                                } else if (input.tagName === "TEXTAREA" && value === "") {
                                    errorMessage = "Address is not blank.";
                                }

                                if (errorMessage) {
                                    setInvalidFeedback(input, errorMessage);
                                    return false;
                                } else {
                                    removeInvalidFeedback(input);
                                    return true;
                                }
                            }

                            function setInvalidFeedback(input, message) {
                                let feedback = input.parentNode.querySelector(".invalid-feedback");
                                if (!feedback) {
                                    feedback = document.createElement("div");
                                    feedback.className = "invalid-feedback";
                                    input.parentNode.appendChild(feedback);
                                }
                                feedback.textContent = message;
                                input.classList.add("is-invalid");
                            }

                            function removeInvalidFeedback(input) {
                                let feedback = input.parentNode.querySelector(".invalid-feedback");
                                if (feedback) {
                                    feedback.textContent = "";
                                }
                                input.classList.remove("is-invalid");
                                input.classList.add("is-valid");
                            }

                            function isValidPhoneNumber(phone) {
                                const PHONE_PATTERN = /^(?:\+84|0)(3[2-9]|8[1-5]|7[06-9]|9[0-9]|5[2689])\d{7}$/;
                                if (!/^[0-9\+]+$/.test(phone)) {
                                    return "Phone numbers must contain only numbers and can start with a '+' sign.";
                                }
                                if (!PHONE_PATTERN.test(phone)) {
                                    return "Phone number is not valid (9-11 digits).";
                                }
                                return "";
                            }

                            function isValidEmail(email) {
                                const EMAIL_PATTERN = /^(?=.{6,254}$)(?!.*\.\.)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,63}$/;
                                if (!EMAIL_PATTERN.test(email)) {
                                    return "Invalid email format.";
                                }
                                return "";
                            }

                            function isValidDateOfBirth(dob) {
                                const selectedDate = new Date(dob);
                                const today = new Date();
                                today.setHours(0, 0, 0, 0);
                                if (selectedDate >= today) {
                                    return "Date of birth cannot be today or in the future.";
                                }
                                return "";
                            }
                        });
                    </script>
                    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            const successMessage = "${success}";
                            const errorMessage = "${error}";
                            const errorGetData = "${errorGetData}";

                            if (errorGetData) {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error',
                                    text: errorGetData,
                                    timer: 3000,
                                    showConfirmButton: false
                                }).then(() => {
                                    window.location.href = "login";
                                });
                            }

                            if (successMessage) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Success',
                                    text: successMessage,
                                    timer: 1000,
                                    showConfirmButton: false
                                }).then(() => {
                                    window.location.href = "view_information";
                                });
                            } else if (errorMessage) {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error',
                                    text: errorMessage,
                                    timer: 3000,
                                    showConfirmButton: false
                                });
                            }
                        });
                    </script>
                </div>
            </div>
        </div>

    </body>
</html>
