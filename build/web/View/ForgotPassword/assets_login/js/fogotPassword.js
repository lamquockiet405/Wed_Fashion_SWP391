/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
// Hàm xử lý sự kiện nhập vào trong các trường OTP
function handleInput(event, index, otpInputs) {
    const input = event.target;
    // Xóa tất cả các ký tự không phải số
    input.value = input.value.replace(/[^\d]/g, '');

    // Chuyển đến trường nhập tiếp theo khi nhập số
    if (input.value.length === 1 && index < otpInputs.length - 1) {
        otpInputs[index + 1].focus();
    }
}

// Hàm xử lý sự kiện nhấn phím trong các trường OTP
function handleKeyDown(event, index, otpInputs) {
    if (event.key === 'Backspace' && index > 0 && otpInputs[index].value.length === 0) {
        otpInputs[index - 1].focus();
    }
}

// Hàm khởi tạo các sự kiện cho các trường nhập OTP
function initializeOtpInputs() {
    const otpInputs = document.querySelectorAll('.otp-inputs input');

    otpInputs.forEach((input, index) => {
        input.addEventListener('input', (event) => handleInput(event, index, otpInputs));
        input.addEventListener('keydown', (event) => handleKeyDown(event, index, otpInputs));
    });
}

// Hàm gửi OTP qua AJAX
function submitOtp() {
    const otpInputs = document.querySelectorAll('.otp-inputs input');
    const otp = Array.from(otpInputs).map(input => input.value).join('');

    $.ajax({
        url: "http://localhost:9999/SWP391_OnlineShop_G4/OTPServlet",
        type: 'POST',
        data: {otp: otp},
        success: function (response) {
            // Xử lý phản hồi từ server
            var messageDiv = $('#message');
            if (response.success) {
                messageDiv.text(response.message)
                        .removeClass('error-message')
                        .addClass('success-message');
                 window.location.href = 'view/newPassword.jsp';
            } else {
                clearOtpFields();
                messageDiv.text(response.error)
                        .removeClass('success-message')
                        .addClass('error-message');
            }
            initializeOtpInputs();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error('Yêu cầu AJAX thất bại:', textStatus, errorThrown);
        }
    });
}

// Hàm khởi tạo đồng hồ đếm ngược
function startCountdown(durationInMinutes, elementId, modalId) {
    const countdownTime = new Date().getTime() + durationInMinutes * 60 * 1000;
    const countdownElement = document.getElementById(elementId);

    const countdownInterval = setInterval(function () {
        const now = new Date().getTime();
        const timeLeft = countdownTime - now;

        const minutes = Math.floor((timeLeft % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((timeLeft % (1000 * 60)) / 1000);

        // Đảm bảo hiển thị số phút và giây luôn có 2 chữ số
        countdownElement.innerHTML = `${minutes < 10 ? '0' + minutes : minutes}:${seconds < 10 ? '0' + seconds : seconds}`;

        if (timeLeft < 0) {
            clearInterval(countdownInterval);
            countdownElement.innerHTML = "Hết giờ!";
            if (modalId) {
                $('#' + modalId).removeClass('show');
            }
        }
    }, 1000);
}
function clearOtpFields() {
            document.getElementById('otp1').value = '';
            document.getElementById('otp2').value = '';
            document.getElementById('otp3').value = '';
            document.getElementById('otp4').value = '';
            document.getElementById('otp5').value = '';
            document.getElementById('otp6').value = '';
            
           
        }
// Khởi tạo OTP input fields và xử lý sự kiện khi trang đã sẵn sàng
$(document).ready(function () {
    initializeOtpInputs();
    $('#submitOtpBtn').on('click', function (event) {
        event.preventDefault(); // Ngăn chặn hành vi mặc định của nút submit
        submitOtp(); // Gọi hàm submitOtp
    });
});
