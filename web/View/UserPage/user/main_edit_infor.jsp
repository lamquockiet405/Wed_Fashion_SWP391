<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
                        <input type="text" name="firstName" id="firstName" value="${user.firstName}" class="form-control" required />
                        <div class="invalid-feedback">First name is not blank</div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Last name</label>
                        <input type="text" name="lastName" value="${user.lastName}" id="lastName" class="form-control" required />
                        <div class="invalid-feedback">Last name is not black.</div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md">
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" value="${user.email}" id="email" class="form-control" required />
                            <div class="invalid-feedback">Email is not valid.</div>
                        </div>
                    </div>
                    <div class="col-md">
                        <div class="mb-3">
                            <label class="form-label">Phone number</label>
                            <input type="text" name="phoneNumber" value="${user.phoneNumber}" id="phoneNumber" class="form-control" required />
                            <div class="invalid-feedback">Phone number is not valid(9-11 digits).</div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md">
                        <div class="mb-3">
                            <label class="form-label">Date of birth</label>
                            <input type="date" name="dob" id="dob" value="${user.dateOfBirth}" class="form-control" required />
                            <div class="invalid-feedback">Please select date of birth.</div>
                        </div>
                    </div>
                    <div class="col-md">
                        <div class="mb-3">
                            <label class="form-label">Gender</label>
                            <div>
                                <input type="radio" id="male" name="gender" value="male" ${user.gender ? "checked" : ""} required />
                                <label for="male">Male</label>
                                <input type="radio" id="female" name="gender" value="female" ${!user.gender ? "checked" : ""} />
                                <label for="female">Female</label>
                            </div>
                            <div class="invalid-feedback">Please choose gender.</div>
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Address</label>
                    <textarea name="address"  id="address" class="form-control" required>${user.address}</textarea>
                    <div class="invalid-feedback">Address is not blank.</div>
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
                    return true;

                let errorMessage = "";

                if (value === "") {
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
</div>