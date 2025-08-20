<!DOCTYPE html>
<html lang="en">
    <head>
        <title>FoodMart - Free eCommerce Grocery Store HTML Website Template</title>
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

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&family=Open+Sans:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700&display=swap" rel="stylesheet">
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <style>
            /* Modern Home Page Styling */
            .modern-home {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
                position: relative;
                overflow-x: hidden;
            }

            .modern-home::before {
                content: '';
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="0.5" fill="%23667eea" opacity="0.03"/><circle cx="75" cy="75" r="0.5" fill="%23764ba2" opacity="0.03"/><circle cx="50" cy="10" r="0.3" fill="%23f093fb" opacity="0.02"/><circle cx="10" cy="60" r="0.3" fill="%234facfe" opacity="0.02"/><circle cx="90" cy="40" r="0.3" fill="%2343e97b" opacity="0.02"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
                pointer-events: none;
                z-index: -1;
            }

            /* Hero Banner Section */
            .hero-banner {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                position: relative;
                overflow: hidden;
                padding: 80px 0;
                margin-bottom: 60px;
            }

            .hero-banner::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="hero-pattern" width="50" height="50" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="10" cy="10" r="1" fill="rgba(255,255,255,0.05)"/><circle cx="40" cy="40" r="1" fill="rgba(255,255,255,0.05)"/></pattern></defs><rect width="100" height="100" fill="url(%23hero-pattern)"/></svg>');
                animation: float 20s ease-in-out infinite;
            }

            @keyframes float {
                0%, 100% { transform: translateY(0px) rotate(0deg); }
                50% { transform: translateY(-20px) rotate(180deg); }
            }

            .banner-content {
                position: relative;
                z-index: 2;
                color: white;
            }

            .banner-title {
                font-size: 3.5rem;
                font-weight: 800;
                margin-bottom: 20px;
                background: linear-gradient(135deg, #fff, #f0f0f0);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                text-shadow: 0 4px 20px rgba(0,0,0,0.1);
            }

            .banner-subtitle {
                font-size: 1.2rem;
                margin-bottom: 30px;
                opacity: 0.9;
                line-height: 1.6;
            }

            .banner-btn {
                background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                color: white;
                padding: 15px 40px;
                border-radius: 50px;
                text-decoration: none;
                font-weight: 600;
                font-size: 1.1rem;
                transition: all 0.3s ease;
                box-shadow: 0 8px 25px rgba(79, 172, 254, 0.3);
                border: none;
                position: relative;
                overflow: hidden;
            }

            .banner-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                transition: left 0.5s;
            }

            .banner-btn:hover::before {
                left: 100%;
            }

            .banner-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 12px 35px rgba(79, 172, 254, 0.4);
                color: white;
                text-decoration: none;
            }

            /* Category Section */
            .category-section {
                padding: 80px 0;
                background: rgba(255, 255, 255, 0.8);
                backdrop-filter: blur(20px);
                border-radius: 30px;
                margin: 40px 0;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            }

            .section-title {
                font-size: 2.5rem;
                font-weight: 800;
                text-align: center;
                margin-bottom: 50px;
                background: linear-gradient(135deg, #667eea, #764ba2);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                position: relative;
            }

            .section-title::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 4px;
                background: linear-gradient(135deg, #667eea, #764ba2);
                border-radius: 2px;
            }

            .category-item {
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
                padding: 30px 20px;
                border-radius: 20px;
                text-decoration: none;
                text-align: center;
                transition: all 0.3s ease;
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.2);
                position: relative;
                overflow: hidden;
                margin: 10px;
                min-height: 120px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .category-item::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                transition: left 0.5s;
            }

            .category-item:hover::before {
                left: 100%;
            }

            .category-item:hover {
                transform: translateY(-10px) scale(1.05);
                box-shadow: 0 15px 40px rgba(102, 126, 234, 0.3);
                color: white;
                text-decoration: none;
            }

            .category-title {
                font-size: 1.3rem;
                font-weight: 700;
                margin: 0;
                position: relative;
                z-index: 2;
            }

            /* Product Section */
            .product-section {
                padding: 80px 0;
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(20px);
                border-radius: 30px;
                margin: 40px 0;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            }

            .product-item {
                background: white;
                border-radius: 20px;
                padding: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
                margin-bottom: 30px;
                min-height: 300px;
                display: flex;
                flex-direction: column;
            }

            .product-item::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(135deg, #667eea, #764ba2);
                transform: scaleX(0);
                transition: transform 0.3s ease;
            }

            .product-item:hover::before {
                transform: scaleX(1);
            }

            .product-item:hover {
                transform: translateY(-10px);
                box-shadow: 0 20px 50px rgba(0, 0, 0, 0.15);
            }

            .product-item figure {
                position: relative;
                overflow: hidden;
                border-radius: 15px;
                margin-bottom: 15px;
            }

            .product-item img {
                width: 100%;
                height: 200px;
                object-fit: cover;
                transition: all 0.3s ease;
            }

            .product-item:hover img {
                transform: scale(1.1);
            }

            .product-item h5 {
                font-size: 1.1rem;
                font-weight: 600;
                color: #2d3748;
                margin-bottom: 10px;
                line-height: 1.4;
                min-height: 50px;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .product-price {
                font-size: 1.5rem;
                font-weight: 800;
                color: #667eea;
                margin-top: auto;
                text-align: center;
                background: linear-gradient(135deg, #667eea, #764ba2);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                text-shadow: 0 2px 10px rgba(102, 126, 234, 0.2);
                transition: all 0.3s ease;
            }

            .product-item:hover .product-price {
                transform: scale(1.1);
            }

            /* Promotional Banners */
            .promo-section {
                padding: 80px 0;
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                position: relative;
                overflow: hidden;
            }

            .promo-section::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="promo-bg-pattern" width="50" height="50" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="%23667eea" opacity="0.05"/><circle cx="10" cy="10" r="0.5" fill="%23764ba2" opacity="0.03"/><circle cx="40" cy="40" r="0.5" fill="%23f093fb" opacity="0.03"/></pattern></defs><rect width="100" height="100" fill="url(%23promo-bg-pattern)"/></svg>');
                animation: float 20s ease-in-out infinite;
            }

            .promo-banner {
                background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
                border-radius: 30px;
                padding: 50px 40px;
                color: white;
                position: relative;
                overflow: hidden;
                box-shadow: 0 20px 60px rgba(250, 112, 154, 0.3);
                transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                margin-bottom: 30px;
                min-height: 280px;
                display: flex;
                align-items: center;
            }

            .promo-banner:nth-child(2) {
                background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                box-shadow: 0 20px 60px rgba(79, 172, 254, 0.3);
            }

            .promo-banner::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="promo-pattern" width="40" height="40" patternUnits="userSpaceOnUse"><circle cx="20" cy="20" r="1.5" fill="rgba(255,255,255,0.15)"/><circle cx="5" cy="5" r="0.8" fill="rgba(255,255,255,0.1)"/><circle cx="35" cy="35" r="0.8" fill="rgba(255,255,255,0.1)"/><circle cx="20" cy="5" r="0.5" fill="rgba(255,255,255,0.08)"/><circle cx="5" cy="35" r="0.5" fill="rgba(255,255,255,0.08)"/></pattern></defs><rect width="100" height="100" fill="url(%23promo-pattern)"/></svg>');
                animation: float 18s ease-in-out infinite;
                opacity: 0.8;
            }

            .promo-banner::after {
                content: '';
                position: absolute;
                top: -50%;
                right: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
                animation: rotate 20s linear infinite;
            }

            @keyframes rotate {
                from { transform: rotate(0deg); }
                to { transform: rotate(360deg); }
            }

            .promo-banner:hover {
                transform: translateY(-10px) scale(1.02);
                box-shadow: 0 30px 80px rgba(250, 112, 154, 0.4);
            }

            .promo-banner:nth-child(2):hover {
                box-shadow: 0 30px 80px rgba(79, 172, 254, 0.4);
            }

            .promo-content {
                position: relative;
                z-index: 3;
                width: 100%;
            }

            .promo-badge {
                display: inline-block;
                background: rgba(255, 255, 255, 0.2);
                color: white;
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 0.9rem;
                font-weight: 600;
                margin-bottom: 20px;
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.3);
                animation: pulse 2s ease-in-out infinite;
            }

            @keyframes pulse {
                0%, 100% { transform: scale(1); }
                50% { transform: scale(1.05); }
            }

            .promo-title {
                font-size: 2.5rem;
                font-weight: 900;
                margin-bottom: 20px;
                text-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                background: linear-gradient(135deg, #fff, #f0f0f0);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                line-height: 1.2;
            }

            .promo-subtitle {
                font-size: 1.2rem;
                margin-bottom: 30px;
                opacity: 0.95;
                line-height: 1.6;
                font-weight: 500;
                text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .promo-btn {
                background: linear-gradient(135deg, rgba(255, 255, 255, 0.25), rgba(255, 255, 255, 0.15));
                color: white;
                padding: 15px 35px;
                border-radius: 30px;
                text-decoration: none;
                font-weight: 700;
                font-size: 1.1rem;
                border: 2px solid rgba(255, 255, 255, 0.4);
                transition: all 0.3s ease;
                backdrop-filter: blur(15px);
                position: relative;
                overflow: hidden;
                display: inline-block;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            }

            .promo-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
                transition: left 0.5s;
            }

            .promo-btn:hover::before {
                left: 100%;
            }

            .promo-btn:hover {
                background: linear-gradient(135deg, rgba(255, 255, 255, 0.35), rgba(255, 255, 255, 0.25));
                border-color: rgba(255, 255, 255, 0.6);
                transform: translateY(-3px);
                color: white;
                text-decoration: none;
                box-shadow: 0 12px 35px rgba(0, 0, 0, 0.2);
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .banner-title {
                    font-size: 2.5rem;
                }
                
                .section-title {
                    font-size: 2rem;
                }
                
                .category-item {
                    margin: 5px;
                    padding: 20px 15px;
                }
                
                .product-item {
                    margin-bottom: 20px;
                }
                
                .promo-section {
                    padding: 40px 0;
                }
                
                .promo-banner {
                    padding: 30px 25px;
                    min-height: 220px;
                    margin-bottom: 20px;
                }
                
                .promo-title {
                    font-size: 2rem;
                    margin-bottom: 15px;
                }
                
                .promo-subtitle {
                    font-size: 1rem;
                    margin-bottom: 20px;
                }
                
                .promo-btn {
                    padding: 12px 25px;
                    font-size: 1rem;
                }
                
                .promo-badge {
                    font-size: 0.8rem;
                    padding: 6px 12px;
                    margin-bottom: 15px;
                }
            }

            /* Animation for page elements */
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

            .hero-banner,
            .category-section,
            .product-section,
            .promo-section {
                animation: fadeInUp 0.8s ease forwards;
            }

            .category-section { animation-delay: 0.2s; }
            .product-section { animation-delay: 0.4s; }
            .promo-section { animation-delay: 0.6s; }
        </style>
    </head>
    <body class="modern-home">

        <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
        <defs>
    <symbol xmlns="http://www.w3.org/2000/svg" id="link" viewBox="0 0 24 24">
        <path fill="currentColor" d="M12 19a1 1 0 1 0-1-1a1 1 0 0 0 1 1Zm5 0a1 1 0 1 0-1-1a1 1 0 0 0 1 1Zm0-4a1 1 0 1 0-1-1a1 1 0 0 0 1 1Zm-5 0a1 1 0 1 0-1-1a1 1 0 0 0 1 1Zm7-12h-1V2a1 1 0 0 0-2 0v1H8V2a1 1 0 0 0-2 0v1H5a3 3 0 0 0-3 3v14a3 3 0 0 0 3 3h14a3 3 0 0 0 3-3V6a3 3 0 0 0-3-3Zm1 17a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1v-9h16Zm0-11H4V6a1 1 0 0 1 1-1h1v1a1 1 0 0 0 2 0V5h8v1a1 1 0 0 0 2 0V5h1a1 1 0 0 1 1 1ZM7 15a1 1 0 1 0-1-1a1 1 0 0 0 1 1Zm0 4a1 1 0 1 0-1-1a1 1 0 0 0 1 1Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="arrow-right" viewBox="0 0 24 24">
        <path fill="currentColor" d="M17.92 11.62a1 1 0 0 0-.21-.33l-5-5a1 1 0 0 0-1.42 1.42l3.3 3.29H7a1 1 0 0 0 0 2h7.59l-3.3 3.29a1 1 0 0 0 0 1.42a1 1 0 0 0 1.42 0l5-5a1 1 0 0 0 .21-.33a1 1 0 0 0 0-.76Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="category" viewBox="0 0 24 24">
        <path fill="currentColor" d="M19 5.5h-6.28l-.32-1a3 3 0 0 0-2.84-2H5a3 3 0 0 0-3 3v13a3 3 0 0 0 3 3h14a3 3 0 0 0 3-3v-10a3 3 0 0 0-3-3Zm1 13a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1v-13a1 1 0 0 1 1-1h4.56a1 1 0 0 1 .95.68l.54 1.64a1 1 0 0 0 .95.68h7a1 1 0 0 1 1 1Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="calendar" viewBox="0 0 24 24">
        <path fill="currentColor" d="M19 4h-2V3a1 1 0 0 0-2 0v1H9V3a1 1 0 0 0-2 0v1H5a3 3 0 0 0-3 3v12a3 3 0 0 0 3 3h14a3 3 0 0 0 3-3V7a3 3 0 0 0-3-3Zm1 15a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1v-7h16Zm0-9H4V7a1 1 0 0 1 1-1h2v1a1 1 0 0 0 2 0V6h6v1a1 1 0 0 0 2 0V6h2a1 1 0 0 1 1 1Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="heart" viewBox="0 0 24 24">
        <path fill="currentColor" d="M20.16 4.61A6.27 6.27 0 0 0 12 4a6.27 6.27 0 0 0-8.16 9.48l7.45 7.45a1 1 0 0 0 1.42 0l7.45-7.45a6.27 6.27 0 0 0 0-8.87Zm-1.41 7.46L12 18.81l-6.75-6.74a4.28 4.28 0 0 1 3-7.3a4.25 4.25 0 0 1 3 1.25a1 1 0 0 0 1.42 0a4.27 4.27 0 0 1 6 6.05Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="plus" viewBox="0 0 24 24">
        <path fill="currentColor" d="M19 11h-6V5a1 1 0 0 0-2 0v6H5a1 1 0 0 0 0 2h6v6a1 1 0 0 0 2 0v-6h6a1 1 0 0 0 0-2Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="minus" viewBox="0 0 24 24">
        <path fill="currentColor" d="M19 11H5a1 1 0 0 0 0 2h14a1 1 0 0 0 0-2Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="cart" viewBox="0 0 24 24">
        <path fill="currentColor" d="M8.5 19a1.5 1.5 0 1 0 1.5 1.5A1.5 1.5 0 0 0 8.5 19ZM19 16H7a1 1 0 0 1 0-2h8.491a3.013 3.013 0 0 0 2.885-2.176l1.585-5.55A1 1 0 0 0 19 5H6.74a3.007 3.007 0 0 0-2.82-2H3a1 1 0 0 0 0 2h.921a1.005 1.005 0 0 1 .962.725l.155.545v.005l1.641 5.742A3 3 0 0 0 7 18h12a1 1 0 0 0 0-2Zm-1.326-9l-1.22 4.274a1.005 1.005 0 0 1-.963.726H8.754l-.255-.892L7.326 7ZM16.5 19a1.5 1.5 0 1 0 1.5 1.5a1.5 1.5 0 0 0-1.5-1.5Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="check" viewBox="0 0 24 24">
        <path fill="currentColor" d="M18.71 7.21a1 1 0 0 0-1.42 0l-7.45 7.46l-3.13-3.14A1 1 0 1 0 5.29 13l3.84 3.84a1 1 0 0 0 1.42 0l8.16-8.16a1 1 0 0 0 0-1.47Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="trash" viewBox="0 0 24 24">
        <path fill="currentColor" d="M10 18a1 1 0 0 0 1-1v-6a1 1 0 0 0-2 0v6a1 1 0 0 0 1 1ZM20 6h-4V5a3 3 0 0 0-3-3h-2a3 3 0 0 0-3 3v1H4a1 1 0 0 0 0 2h1v11a3 3 0 0 0 3 3h8a3 3 0 0 0 3-3V8h1a1 1 0 0 0 0-2ZM10 5a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v1h-4Zm7 14a1 1 0 0 1-1 1H8a1 1 0 0 1-1-1V8h10Zm-3-1a1 1 0 0 0 1-1v-6a1 1 0 0 0-2 0v6a1 1 0 0 0 1 1Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="star-outline" viewBox="0 0 15 15">
        <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M7.5 9.804L5.337 11l.413-2.533L4 6.674l2.418-.37L7.5 4l1.082 2.304l2.418.37l-1.75 1.793L9.663 11L7.5 9.804Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="star-solid" viewBox="0 0 15 15">
        <path fill="currentColor" d="M7.953 3.788a.5.5 0 0 0-.906 0L6.08 5.85l-2.154.33a.5.5 0 0 0-.283.843l1.574 1.613l-.373 2.284a.5.5 0 0 0 .736.518l1.92-1.063l1.921 1.063a.5.5 0 0 0 .736-.519l-.373-2.283l1.574-1.613a.5.5 0 0 0-.283-.844L8.921 5.85l-.968-2.062Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="search" viewBox="0 0 24 24">
        <path fill="currentColor" d="M21.71 20.29L18 16.61A9 9 0 1 0 16.61 18l3.68 3.68a1 1 0 0 0 1.42 0a1 1 0 0 0 0-1.39ZM11 18a7 7 0 1 1 7-7a7 7 0 0 1-7 7Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="user" viewBox="0 0 24 24">
        <path fill="currentColor" d="M15.71 12.71a6 6 0 1 0-7.42 0a10 10 0 0 0-6.22 8.18a1 1 0 0 0 2 .22a8 8 0 0 1 15.9 0a1 1 0 0 0 1 .89h.11a1 1 0 0 0 .88-1.1a10 10 0 0 0-6.25-8.19ZM12 12a4 4 0 1 1 4-4a4 4 0 0 1-4 4Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="close" viewBox="0 0 15 15">
        <path fill="currentColor" d="M7.953 3.788a.5.5 0 0 0-.906 0L6.08 5.85l-2.154.33a.5.5 0 0 0-.283.843l1.574 1.613l-.373 2.284a.5.5 0 0 0 .736.518l1.92-1.063l1.921 1.063a.5.5 0 0 0 .736-.519l-.373-2.283l1.574-1.613a.5.5 0 0 0-.283-.844L8.921 5.85l-.968-2.062Z"/>
    </symbol>
    </defs>
    </svg>

    <div class="offcanvas offcanvas-end" data-bs-scroll="true" tabindex="-1" id="offcanvasSearch" aria-labelledby="Search">
        <div class="offcanvas-header justify-content-center">
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">
            <div class="order-md-last">
                <h4 class="d-flex justify-content-between align-items-center mb-3">
                    <span class="text-primary">Search</span>
                </h4>
                <form role="search" action="index.html" method="get" class="d-flex mt-3 gap-0">
                    <input class="form-control rounded-start rounded-0 bg-light" type="email" placeholder="What are you looking for?" aria-label="What are you looking for?">
                    <button class="btn btn-dark rounded-end rounded-0" type="submit">Search</button>
                </form>
            </div>
        </div>
    </div>

    <div id="Header"></div>

    <!-- Hero Banner Section -->
    <section class="hero-banner">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="banner-content text-center">
                        <h1 class="banner-title">Welcome to FoodMart</h1>
                        <p class="banner-subtitle">Discover amazing products and enjoy the best shopping experience</p>
                        <a href="#products" class="banner-btn">Start Shopping Now</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Category Section -->
    <section class="category-section">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <h2 class="section-title">Shop by Category</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="category-carousel swiper">
                        <div class="swiper-wrapper">
                            <c:forEach var="ct" items="${requestScope.ListCategories}">
                                <a href="productList?&categoryID=${ct.categoryID}" class="category-item swiper-slide">
                                    <h3 class="category-title">${ct.categoryName}</h3>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Product Section -->
    <section class="product-section" id="products">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <h2 class="section-title">Featured Products</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="product-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5">
                        <c:forEach var="product" items="${requestScope.MenuChose}">
                            <div class="col">
                                <div class="product-item">
                                    <figure>
                                        <c:forEach var="img" items="${requestScope.Listimage}">
                                            <c:if test="${img.productID == product.productID}">
                                                <a href="product_detail?productID=${product.productID}" title="Product Title">
                                                    <img src="${img.image}" class="tab-image">
                                                </a>
                                            </c:if>
                                        </c:forEach>
                                    </figure>
                                    <h5>${product.productName}</h5>
                                    <c:forEach var="price" items="${requestScope.Listprice}">
                                        <c:if test="${price.productID == product.productID}">
                                            <span class="product-price" data-price="${price.priceMin}">$${price.priceMin}</span>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Promotional Banners -->
    <section class="promo-section">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <div class="promo-banner">
                        <div class="promo-content">
                            <div class="promo-badge">🔥 Limited Time</div>
                            <div class="promo-title">Up to 25% Off</div>
                            <div class="promo-subtitle">Luxa Dark Chocolate - Very tasty & creamy vanilla flavour</div>
                            <a href="#" class="promo-btn">🛒 Shop Now</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="promo-banner">
                        <div class="promo-content">
                            <div class="promo-badge">⭐ Special Offer</div>
                            <div class="promo-title">Fresh & Delicious</div>
                            <div class="promo-subtitle">Creamy Muffins - Very tasty & creamy vanilla flavour</div>
                            <a href="#" class="promo-btn">🛒 Shop Now</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div id="Footer"></div>

    <script src="js/jquery-1.11.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <script src="js/plugins.js"></script>
    <script src="js/script.js"></script>
    <script>
        async function loadComponent(id, file) {
            const response = await fetch(file);
            const content = await response.text();
            document.getElementById(id).innerHTML = content;
        }

        loadComponent("Header", "./View/Header/Header.jsp");
        loadComponent("Footer", "./View/Footer/Footer.jsp");
    </script>
    <script>
        const urlParams = new URLSearchParams(window.location.search);
        const message = urlParams.get("messcreatebill");
        if (message) {
            alert(message);
        }
    </script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            function formatPrice(number) {
                return number.toLocaleString("en-US");
            }

            function animatePrice(element, value) {
                let start = 0;
                let duration = 1000;
                let step = (value - start) / (duration / 10);

                let interval = setInterval(() => {
                    start += step;
                    if (start >= value) {
                        start = value;
                        clearInterval(interval);
                    }
                    element.innerText = "$" + formatPrice(Math.floor(start));
                }, 10);
            }

            document.querySelectorAll(".product-price").forEach(priceElement => {
                let priceMin = parseFloat(priceElement.dataset.price);
                if (!isNaN(priceMin)) {
                    animatePrice(priceElement, priceMin);
                }
            });
        });
    </script>
</body>
</html>