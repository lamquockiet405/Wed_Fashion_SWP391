<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Personal Information</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                background-color: #f0f2f5;
                font-family: 'Arial', sans-serif;
            }
            .info-container {
                max-width: 700px;
                margin: 50px auto;
                background: #fff;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
            }
            .profile-header {
                display: flex;
                align-items: center;
                gap: 15px;
                border-bottom: 1px solid #ddd;
                padding-bottom: 15px;
                margin-bottom: 15px;
            }
            .profile-header img {
                width: 90px;
                height: 90px;
                padding: 2px;
                border-radius: 50%;
                object-fit: cover;
                border: 1px solid #333;
            }
            .profile-header h2 {
                margin: 0;
                color: #333;
            }
            .table th {
                background-color: #f8f9fa;
                text-align: left;
                width: 30%;
            }
            .table td {
                text-align: left;
            }
            .btn-container {
                display: flex;
                justify-content: space-between;
            }
            .btn-primary {
                background-color: #1877f2;
                border: none;
            }
            .btn-primary:hover {
                background-color: #1558c5;
            }
            .btn-secondary {
                background-color: #42b72a;
                border: none;
            }
            .btn-secondary:hover {
                background-color: #369924;
            }
        </style>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                background-color: #6c757d;
            }
            .sidebar {
                height: 100vh;
                background-color: #6c757d;
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
                <jsp:include page="./../main_view_infor.jsp" />
            </div>
        </div>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</html>
