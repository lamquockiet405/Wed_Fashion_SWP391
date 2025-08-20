<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<main class="container border shadow" style="border-radius: 5px; width: 700px">
    <div class="p-4" style="">
        <div class="text-center mb-4">
            <img src="${shop.logo}" alt="Shop Logo" class="profile-img img-fluid rounded-circle border" 
                 style="width: 150px; height: 150px; object-fit: contain;">
        </div>
        <div class="card">
            <div class="card-body">
                <div class="mb-3">
                    <label class="form-label fw-bold">Shop Name:</label>
                    <span class="form-control-plaintext">${shop.name}</span>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Tax Code:</label>
                    <span class="form-control-plaintext">${shop.tax}</span>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Description:</label>
                    <span class="form-control-plaintext">${shop.describe}</span>
                </div>
            </div>
        </div>

        <div class="mt-4 text-center">
            <a href="manager-edit-shop?id=${shop.id}" class="btn btn-primary">Edit Shop</a>
        </div>
    </div>
</main>