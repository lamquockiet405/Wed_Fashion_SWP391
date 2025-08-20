<%-- 
    Document   : Footer
    Created on : Feb 21, 2025, 12:12:31 PM
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
    <title>EZShop - Modern E-commerce Platform</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="author" content="">
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/vendor.css">
    <link rel="stylesheet" type="text/css" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&family=Open+Sans:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">

    <style>
        /* Modern Footer Styles */
        .modern-footer {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px 0 15px;
            position: relative;
            overflow: hidden;
            font-family: 'Nunito', sans-serif;
            margin-top: auto; /* Đẩy footer xuống dưới cùng */
        }

        /* Đảm bảo footer luôn ở dưới cùng */
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            margin: 0;
            padding: 0;
        }

        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .footer-wrapper {
            margin-top: auto; /* Đẩy footer xuống dưới cùng */
        }

        .modern-footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="50" cy="50" r="1" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            opacity: 0.3;
        }

        .footer-content {
            position: relative;
            z-index: 2;
        }

        /* Logo Section */
        .footer-logo {
            margin-bottom: 20px;
        }

        .footer-logo img {
            height: 80px;
            filter: drop-shadow(0 4px 8px rgba(0,0,0,0.3));
            transition: transform 0.3s ease;
        }

        .footer-logo img:hover {
            transform: scale(1.05);
        }

        .footer-logo h3 {
            font-family: 'Nunito', sans-serif;
            font-weight: 700;
            font-size: 28px;
            margin: 15px 0 0 0;
            background: linear-gradient(45deg, #ffd700, #ff6b6b);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .footer-logo p {
            color: rgba(255,255,255,0.8);
            margin-top: 10px;
            font-size: 14px;
            line-height: 1.6;
        }

        /* Social Links */
        .social-links {
            margin-top: 15px;
        }

        .social-links ul {
            display: flex;
            gap: 15px;
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .social-links a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 45px;
            height: 45px;
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .social-links a:hover {
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.4);
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
        }

        .social-links i {
            font-size: 18px;
        }

        /* Footer Sections */
        .footer-section {
            margin-bottom: 20px;
        }

        .footer-section h5 {
            font-family: 'Nunito', sans-serif;
            font-weight: 700;
            font-size: 20px;
            margin-bottom: 15px;
            color: #ffd700;
            position: relative;
            padding-bottom: 8px;
        }

        .footer-section h5::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 3px;
            background: linear-gradient(45deg, #ffd700, #ff6b6b);
            border-radius: 2px;
        }

        /* Footer Links */
        .footer-links {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .footer-links li {
            margin-bottom: 8px;
        }

        .footer-links a {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-block;
            position: relative;
            padding: 8px 0;
        }

        .footer-links a::before {
            content: '→';
            position: absolute;
            left: -20px;
            opacity: 0;
            transition: all 0.3s ease;
            color: #ffd700;
        }

        .footer-links a:hover {
            color: #ffd700;
            transform: translateX(20px);
        }

        .footer-links a:hover::before {
            opacity: 1;
        }

        /* Footer Bottom */
        .footer-bottom {
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            text-align: center;
        }

        .footer-bottom p {
            color: rgba(255, 255, 255, 0.7);
            margin: 0;
            font-size: 14px;
        }

        .footer-bottom a {
            color: #ffd700;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .footer-bottom a:hover {
            color: #ff6b6b;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .modern-footer {
                padding: 40px 0 20px;
            }

            .footer-logo {
                text-align: center;
                margin-bottom: 25px;
            }

            .footer-section {
                text-align: center;
                margin-bottom: 25px;
            }

            .footer-section h5::after {
                left: 50%;
                transform: translateX(-50%);
            }

            .social-links ul {
                justify-content: center;
            }

            .footer-links a:hover {
                transform: none;
            }

            .footer-links a::before {
                display: none;
            }
        }

        @media (max-width: 576px) {
            .modern-footer {
                padding: 30px 0 15px;
            }

            .footer-logo img {
                height: 60px;
            }

            .footer-logo h3 {
                font-size: 24px;
            }

            .social-links a {
                width: 40px;
                height: 40px;
            }

            .social-links i {
                font-size: 16px;
            }

            .footer-section h5 {
                font-size: 18px;
            }

            .footer-links a {
                font-size: 14px;
            }
        }

        /* Animation */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .footer-section {
            animation: fadeInUp 0.6s ease-out;
        }

        .footer-section:nth-child(1) { animation-delay: 0.1s; }
        .footer-section:nth-child(2) { animation-delay: 0.2s; }
        .footer-section:nth-child(3) { animation-delay: 0.3s; }
        .footer-section:nth-child(4) { animation-delay: 0.4s; }

        /* Hover Effects */
        .footer-section:hover {
            transform: translateY(-2px);
            transition: transform 0.3s ease;
        }

        /* Additional Styling */
        .footer-links a:active {
            transform: scale(0.95);
        }

        .social-links a:active {
            transform: scale(0.9);
        }
    </style>
  </head>
  <body>
     <div class="main-content">
        <footer class="modern-footer footer-wrapper">
          <div class="container footer-content">
            <div class="row">
              <!-- Logo and Social Media Section -->
              <div class="col-lg-3 col-md-6 col-sm-6">
                <div class="footer-section footer-logo">
                    <img src="./logo.png" alt="EZShop Logo">
                    <h3>EZShop</h3>
                    <p style="color: rgba(255,255,255,0.8); margin-top: 10px; font-size: 14px;">
                        Your trusted online shopping destination
                    </p>
                    <div class="social-links">
                        <ul>
                            <li>
                                <a href="#" title="Facebook">
                                    <i class="fab fa-facebook-f"></i>
                                </a>
                            </li>
                            <li>
                                <a href="#" title="Twitter">
                                    <i class="fab fa-twitter"></i>
                                </a>
                            </li>
                            <li>
                                <a href="#" title="YouTube">
                                    <i class="fab fa-youtube"></i>
                                </a>
                            </li>
                            <li>
                                <a href="#" title="Instagram">
                                    <i class="fab fa-instagram"></i>
                                </a>
                            </li>
                            <li>
                                <a href="#" title="LinkedIn">
                                    <i class="fab fa-linkedin-in"></i>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
              </div>

              <!-- Ultras Section -->
              <div class="col-md-3 col-sm-6">
                <div class="footer-section">
                  <h5>Ultras</h5>
                  <ul class="footer-links">
                    <li><a href="#">About us</a></li>
                    <li><a href="#">Conditions</a></li>
                    <li><a href="#">Our Journals</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Partnership</a></li>
                  </ul>
                </div>
              </div>

              <!-- Customer Service Section -->
              <div class="col-md-3 col-sm-6">
                <div class="footer-section">
                  <h5>Customer Service</h5>
                  <ul class="footer-links">
                    <li><a href="#">FAQ</a></li>
                    <li><a href="#">Contact</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Returns & Refunds</a></li>
                    <li><a href="#">Shipping Info</a></li>
                  </ul>
                </div>
              </div>

              <!-- Support Section -->
              <div class="col-md-3 col-sm-6">
                <div class="footer-section">
                  <h5>Support</h5>
                  <ul class="footer-links">
                    <li><a href="#">Help Center</a></li>
                    <li><a href="#">Live Chat</a></li>
                    <li><a href="#">Email Support</a></li>
                    <li><a href="#">Order Tracking</a></li>
                    <li><a href="#">Size Guide</a></li>
                  </ul>
                </div>
              </div>
            </div>

            <!-- Footer Bottom -->
            <div class="footer-bottom">
                <p>&copy; 2025 <a href="#">EZShop</a>. All rights reserved. | 
                   <a href="#">Terms of Service</a> | 
                   <a href="#">Privacy Policy</a>
                </p>
            </div>
          </div>
        </footer>
     </div>
  </body>
</html>
