<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<main class="container">
    <div class="info-container">
        <c:if test="${not empty error}">
            <div class="alert alert-danger d-flex justify-content-between align-items-center" role="alert">
                <span>${error}</span>
                <a href="LoginController" class="btn btn-danger">Login</a>
            </div>
        </c:if>
        <c:if test="${empty error}">
            <div class="profile-header">
                <c:choose>
                    <c:when test="${not empty user.image}">
                        <img src="${user.image}" alt="Avatar" class="profile-img">
                    </c:when>
                    <c:otherwise>
                        <img src="images/avtdf.jpg" alt="Avatar" class="profile-img">
                    </c:otherwise>
                </c:choose>                        
                <h2 id="fullName">${user.firstName} ${user.lastName}</h2>
            </div>
            <table class="table">
                <tr>
                    <th>Username</th>
                    <td id="username">${user.username}</td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td id="email">${user.email}</td>
                </tr>
                <tr>
                    <th>Phone Number</th>
                    <td id="phoneNumber">${user.phoneNumber}</td>
                </tr>
                <tr>
                    <th>Address</th>
                    <td id="address">${user.address}</td>
                </tr>
                <tr>
                    <th>Gender</th>
                    <td id="gender">${user.gender == true ? "Male" : "Female"}</td>
                </tr>
                <tr>
                    <th>Date of birth</th>
                    <td id="dateOfBirth">${user.dateOfBirth}</td>
                </tr>
                
            </table>
        </c:if>
        <div class="btn-container mt-3">
            <c:if test="${empty error}">
                <a href="edit_information" class="btn btn-primary" style="padding: 8px 32px">Edit</a>
            </c:if>
            <a href="${pageContext.request.contextPath}/homePage" class="btn btn-secondary text-end" style="padding: 8px 32px">Back</a>
        </div>
    </div>
</main>