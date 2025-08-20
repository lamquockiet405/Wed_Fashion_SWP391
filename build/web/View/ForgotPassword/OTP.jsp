<%-- 
    Document   : OTP
    Created on : Jul 20, 2024, 9:52:04 PM
    Author     : ViQuan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Enter OTP</title>
        <link rel="stylesheet" href="assets_login/css/fogotPassword.css">
    </head>
    <body>
        <div class="full-page"> 
            <div class="containerOTP">
                <div id="countdown" class="countdown">0:59</div>
                <h1>Enter OTP</h1>
                <p>Please enter the OTP that has been sent to your email.</p>
                <form id="otp-form" action="${pageContext.request.contextPath}/Otp" method="post">
                    <div class="otp-inputs">
                        <input type="text" id="otp1" maxlength="1" inputmode="numeric" autocomplete="one-time-code">
                        <input type="text" id="otp2" maxlength="1" inputmode="numeric" autocomplete="one-time-code">
                        <input type="text" id="otp3" maxlength="1" inputmode="numeric" autocomplete="one-time-code">
                        <input type="text" id="otp4" maxlength="1" inputmode="numeric" autocomplete="one-time-code">
                        <input type="text" id="otp5" maxlength="1" inputmode="numeric" autocomplete="one-time-code">
                        <input type="text" id="otp6" maxlength="1" inputmode="numeric" autocomplete="one-time-code">
                    </div>
                    <!-- Input ẩn để gửi OTP hợp nhất -->
                    <input type="hidden" id="otp-hidden" name="otp">
                    <div id="message" class="message"></div>
                    <button type="submit">Confirm</button>
                </form>
            </div>
        </div>
        
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {
                // Auto-focus first input
                $('#otp1').focus();
                
                // Auto-advance to next input
                $('.otp-inputs input').on('input', function() {
                    var currentInput = $(this);
                    var currentIndex = currentInput.index();
                    var value = currentInput.val();
                    
                    // Only allow numbers
                    if (!/^\d*$/.test(value)) {
                        currentInput.val('');
                        return;
                    }
                    
                    // If input has value, move to next
                    if (value.length === 1 && currentIndex < 5) {
                        $('.otp-inputs input').eq(currentIndex + 1).focus();
                    }
                });
                
                // Handle backspace
                $('.otp-inputs input').on('keydown', function(e) {
                    var currentInput = $(this);
                    var currentIndex = currentInput.index();
                    
                    if (e.key === 'Backspace' && currentInput.val() === '' && currentIndex > 0) {
                        $('.otp-inputs input').eq(currentIndex - 1).focus();
                    }
                });
                
                // Handle paste
                $('.otp-inputs input').on('paste', function(e) {
                    e.preventDefault();
                    var pastedData = (e.originalEvent.clipboardData || window.clipboardData).getData('text');
                    var numbers = pastedData.replace(/\D/g, '').split('').slice(0, 6);
                    
                    $('.otp-inputs input').each(function(index) {
                        if (numbers[index]) {
                            $(this).val(numbers[index]);
                        }
                    });
                    
                    // Focus last filled input or first empty one
                    var lastFilledIndex = numbers.length - 1;
                    if (lastFilledIndex < 5) {
                        $('.otp-inputs input').eq(lastFilledIndex + 1).focus();
                    }
                });
                
                // Form submission
                $('#otp-form').submit(function (event) {
                    event.preventDefault();

                    let otpValue = '';
                    for (let i = 1; i <= 6; i++) {
                        otpValue += $('#otp' + i).val();
                    }
                    
                    // Validate OTP length
                    if (otpValue.length !== 6) {
                        $('#message').text('Please enter a complete 6-digit OTP.').addClass('error');
                        return;
                    }

                    // Show loading state
                    var submitBtn = $(this).find('button[type="submit"]');
                    var originalText = submitBtn.text();
                    submitBtn.text('Verifying...').prop('disabled', true);

                    $.ajax({
                        url: '${pageContext.request.contextPath}/Otp',
                        type: 'POST',
                        data: { otp: otpValue },
                        dataType: 'json',
                        success: function (response) {
                            if (response.success) {
                                $('#message').text('OTP verified successfully!').removeClass('error').addClass('success');
                                setTimeout(function() {
                                    window.location.href = response.redirect;
                                }, 1000);
                            } else {
                                $('#message').text(response.error || 'Invalid OTP. Please try again.').removeClass('success').addClass('error');
                                // Clear inputs for retry
                                $('.otp-inputs input').val('');
                                $('#otp1').focus();
                            }
                        },
                        error: function () {
                            $('#message').text('An error occurred. Please try again.').removeClass('success').addClass('error');
                        },
                        complete: function () {
                            submitBtn.text(originalText).prop('disabled', false);
                        }
                    });
                });
            });
        </script>
    </body>
</html>