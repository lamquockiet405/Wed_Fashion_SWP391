<%-- 
        Document   : forgotPassword
    Created on : May 24, 2024, 7:49:50 AM
    Author     : Dell
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>     
        <title>Forgot Password - EZShop</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- External CSS libraries -->
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/View/ForgotPassword/assets_lg/css/bootstrap.min.css">
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/View/ForgotPassword/assets_lg/fonts/font-awesome/css/font-awesome.min.css">
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/View/ForgotPassword/assets_lg/fonts/flaticon/font/flaticon.css">
        <!-- CSS OTP -->
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/View/ForgotPassword/assets_login/css/fogotPassword.css">
        <!-- Google fonts -->
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800%7CPoppins:400,500,700,800,900%7CRoboto:100,300,400,400i,500,700">
        <!-- Custom Stylesheet -->
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/View/ForgotPassword/assets_lg/css/style.css">
        <link rel="stylesheet" type="text/css" id="style_sheet" href="${pageContext.request.contextPath}/View/ForgotPassword/assets_lg/css/skins/default.css">
        <link href="${pageContext.request.contextPath}/View/ForgotPassword/assets_h/css/style.css" rel="stylesheet">

        <style>
            .loading-screen {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(26, 28, 30, 0.3);
                display: flex;
                align-items: center;
                justify-content: center;
                color: #fff;
                font-size: 1.5em;
                z-index: 1000;
                display: none;
                overflow: hidden;
            }

            .loading-screen.show {
                display: flex;
            }
            
            /* Modal Overlay */
            .modal {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.6);
                display: none;
                align-items: center;
                justify-content: center;
                z-index: 1000;
                transition: opacity 0.3s ease, visibility 0.3s ease;
            }

            /* Show Modal */
            .modal.show {
                display: flex;
                opacity: 1;
                visibility: visible;
            }

            /* Modal Content */
            .modal-content {
                background-color: #ffffff;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                position: relative;
                width: 90%;
                max-width: 450px;
                padding: 30px 20px;
                box-sizing: border-box;
                text-align: center;
            }

            /* Close Button */
            .close-btn {
                position: absolute;
                top: 15px;
                right: 15px;
                background: none;
                border: none;
                font-size: 24px;
                color: #333;
                cursor: pointer;
                z-index: 1001;
                padding: 0;
            }

            .close-btn:hover {
                color: #000;
            }

            /* OTP Overlay */
            #otp-overlay {
                padding: 20px;
            }

            /* Ensure input field is functional */
            .input-text {
                pointer-events: auto !important;
                cursor: text !important;
                user-select: text !important;
                -webkit-user-select: text !important;
                -moz-user-select: text !important;
                -ms-user-select: text !important;
            }

            .form-box i {
                pointer-events: none !important;
            }
        </style>
    </head>
    <body id="top">
        <div class="page_loader"></div>

        <div class="login-11">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-6 col-md-12">
                        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
                             class="img-fluid" alt="Sample image">
                    </div>
                    <div class="col-lg-6 col-md-12 bg-color-13">
                        <div class="form-section">
                            <div class="logo clearfix">
                                <a href="${pageContext.request.contextPath}/index.html">
                                    <img src="${pageContext.request.contextPath}/images/logo.png" alt="logo">
                                </a>
                            </div>
                            <h3>Recover Your Password</h3>
                            <div class="login-inner-form">
                                <div class="form-group form-box">
                                    <input type="email" name="email" id="emailInput" class="input-text" placeholder="Email Address" required>
                                    <i class="flaticon-mail-2"></i>
                                </div>
                                <div class="form-group mb-0">
                                    <button id="sendEmailBtn" class="btn-md btn-theme btn-block">Send Me Email</button>
                                </div>
                                <div class="form-group mb-0" id="mess"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="loadingScreen" class="loading-screen">Loading...</div>

        <div class="modal" id="otpModal">
            <div class="modal-content">
                <button class="close-btn" id="closeOtpOverlay">&times;</button>
                <div id="otp-overlay">
                    <jsp:include page="OTP.jsp"></jsp:include>
                </div>
            </div>
        </div>

        <!-- Include jQuery before your custom scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="${pageContext.request.contextPath}/View/ForgotPassword/assets_login/js/fogotPassword.js"></script>
        
        <script>
            // Ensure input field is functional
            $(document).ready(function() {
                // Make sure input field is clickable and functional
                $('#emailInput').on('click focus', function() {
                    console.log('Input field clicked/focused');
                });
                
                // Remove any potential event blockers
                $('.form-box i').off('click mousedown mouseup');
                $('.form-box i').css('pointer-events', 'none');
                
                // Ensure input field is properly styled
                $('#emailInput').css({
                    'pointer-events': 'auto',
                    'cursor': 'text',
                    'user-select': 'text',
                    '-webkit-user-select': 'text',
                    '-moz-user-select': 'text',
                    '-ms-user-select': 'text'
                });
            });

            $('#sendEmailBtn').on('click', function (event) {
                event.preventDefault();

                var email = $('#emailInput').val();

                if (!email) {
                    $('#mess').text('Please enter your email address.').css('color', 'red');
                    return;
                }

                $('#sendEmailBtn').prop('disabled', true);
                $('#loadingScreen').addClass('show');

                $.ajax({
                    url: '${pageContext.request.contextPath}/forgotPassword',
                    type: 'POST',
                    data: {email: email},
                    dataType: 'json',
                    success: function (response) {
                        $('#mess').text(response.mess).css('color', 'green');
                        if (response.mess && response.mess.trim().toLowerCase() === "success") {
                            $('#otpModal').addClass("show");
                            startCountdown(1, 'countdown', 'otpModal');
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('Error:', error);
                        $('#mess').text('An error occurred. Please try again later.').css('color', 'red');
                    },
                    complete: function () {
                        $('#loadingScreen').removeClass('show');
                        $('#sendEmailBtn').prop('disabled', false);
                    }
                });
            });

            // Close modal functionality
            $('#closeOtpOverlay').on('click', function() {
                $('#otpModal').removeClass('show');
            });

            // Close modal when clicking outside
            $('#otpModal').on('click', function(e) {
                if (e.target === this) {
                    $(this).removeClass('show');
                }
            });
        </script>
        
        <script>
            var countdownInterval;

            function startCountdown(minutes, countdownElementId, modalId) {
                clearInterval(countdownInterval);

                var seconds = minutes * 60;
                var countdownElement = document.getElementById(countdownElementId);

                function updateCountdown() {
                    var mins = Math.floor(seconds / 60);
                    var secs = seconds % 60;
                    countdownElement.textContent = mins + ":" + (secs < 10 ? "0" : "") + secs;

                    if (seconds > 0) {
                        seconds--;
                    } else {
                        clearInterval(countdownInterval);
                        document.getElementById(modalId).classList.remove("show");
                    }
                }

                updateCountdown();
                countdownInterval = setInterval(updateCountdown, 1000);
            }
        </script>
    </body>
</html>
