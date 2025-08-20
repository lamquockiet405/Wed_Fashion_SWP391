<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<main class="container border p-3 rounded shadow my-4">

    <!-- Customer Information Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">
                        <i class="fas fa-user-circle me-2"></i> Customer Information
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold text-primary">
                                    <i class="fas fa-user me-2"></i>Customer Name
                                </label>
                                <p class="form-control-plaintext border rounded p-2 bg-light">
                                    <c:choose>
                                        <c:when test="${not empty orderView.customerName}">
                                            ${orderView.customerName}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">
                                                <i class="fas fa-exclamation-triangle me-1"></i>Customer name not available
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold text-primary">
                                    <i class="fas fa-envelope me-2"></i>Email Address
                                </label>
                                <p class="form-control-plaintext border rounded p-2 bg-light">
                                    <c:choose>
                                        <c:when test="${not empty orderView.customerEmail}">
                                            ${orderView.customerEmail}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">
                                                <i class="fas fa-exclamation-triangle me-1"></i>Email not available
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold text-primary">
                                    <i class="fas fa-phone me-2"></i>Phone Number
                                </label>
                                <p class="form-control-plaintext border rounded p-2 bg-light">
                                    <c:choose>
                                        <c:when test="${not empty orderView.customerPhone}">
                                            ${orderView.customerPhone}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">
                                                <i class="fas fa-exclamation-triangle me-1"></i>Phone not available
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold text-primary">
                                    <i class="fas fa-map-marker-alt me-2"></i>Shipping Address
                                </label>
                                <p class="form-control-plaintext border rounded p-2 bg-light">
                                    <c:choose>
                                        <c:when test="${not empty orderView.customerAddress}">
                                            ${orderView.customerAddress}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">
                                                <i class="fas fa-info-circle me-1"></i>No shipping address provided
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Order Information Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0">
                        <i class="fas fa-shopping-cart me-2"></i> Order Information
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold text-info">
                                    <i class="fas fa-hashtag me-2"></i>Order ID
                                </label>
                                <p class="form-control-plaintext border rounded p-2 bg-light">
                                    #${orderView.orderId}
                                </p>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold text-info">
                                    <i class="fas fa-calendar me-2"></i>Order Date
                                </label>
                                <p class="form-control-plaintext border rounded p-2 bg-light">
                                    <fmt:formatDate value="${orderView.dateAdd}" pattern="dd/MM/yyyy HH:mm"/>
                                </p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold text-info">
                                    <i class="fas fa-boxes me-2"></i>Quantity
                                </label>
                                <p class="form-control-plaintext border rounded p-2 bg-light">
                                    ${orderView.quantityTotal} items
                                </p>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold text-info">
                                    <i class="fas fa-info-circle me-2"></i>Status
                                </label>
                                <p class="form-control-plaintext border rounded p-2">
                                    <c:choose>
                                        <c:when test="${orderView.statusOrderItem == 0}">
                                            <span class="badge bg-danger fs-6">
                                                <i class="fas fa-times-circle me-1"></i>Cancelled
                                            </span>
                                        </c:when>
                                        <c:when test="${orderView.statusOrderItem == 1}">
                                            <span class="badge bg-success fs-6">
                                                <i class="fas fa-check-circle me-1"></i>Delivered
                                            </span>
                                        </c:when>
                                        <c:when test="${orderView.statusOrderItem == 2}">
                                            <span class="badge bg-warning fs-6">
                                                <i class="fas fa-clock me-1"></i>Waiting
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary fs-6">
                                                <i class="fas fa-question-circle me-1"></i>Unknown
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Product Images -->
        <div class="col-md-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">
                        <i class="fas fa-images me-2"></i> Product Images
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row" id="image-preview">
                        <c:forEach var="img" items="${productImages}">
                            <div class="col-3 mb-3 d-flex justify-content-center align-items-center">
                                <img src="${img.image}" class="product-image border rounded p-1 shadow-sm" 
                                     style="max-width: 100%; height: auto; object-fit: cover;" alt="Product Image">
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <!-- Product Information -->
        <div class="col-md-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-warning text-dark">
                    <h5 class="mb-0">
                        <i class="fas fa-box me-2"></i> Product Information
                    </h5>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label class="form-label fw-bold text-warning">
                            <i class="fas fa-tag me-2"></i>Product Name
                        </label>
                        <p class="form-control-plaintext border rounded p-2 bg-light">
                            ${product.productName}
                        </p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold text-warning">
                            <i class="fas fa-list me-2"></i>Category
                        </label>
                        <p class="form-control-plaintext border rounded p-2 bg-light">
                            ${categoryProcess.getCategoryByID(product.categoryId).categoryName}
                        </p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold text-warning">
                            <i class="fas fa-align-left me-2"></i>Description
                        </label>
                        <div class="form-control-plaintext border rounded p-2 bg-light" 
                             style="min-height: 100px; white-space: pre-wrap; overflow-y: auto;">
                            ${product.description}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Product Variants -->
    <div class="mt-4">
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-secondary text-white">
                <h5 class="mb-0">
                    <i class="fas fa-cube me-2"></i> Product Variants
                </h5>
            </div>
            <div class="card-body">
                <table class="table table-bordered variant-table">
                    <thead class="table-light">
                        <tr class="text-center">
                            <th><i class="fas fa-image me-2"></i>Variant Image</th>
                            <th><i class="fas fa-tag me-2"></i>Variant Name</th>
                            <th><i class="fas fa-dollar-sign me-2"></i>Price</th>
                            <th><i class="fas fa-boxes me-2"></i>Stock Quantity</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="text-center align-middle">
                            <td>
                                <img src="${productVariant.image}" style="max-height: 100px; object-fit: contain;" 
                                     class="border rounded p-1 shadow-sm" alt="Variant Image">
                            </td>
                            <td class="fw-bold">${productVariant.productVariantName}</td>
                            <td class="text-success fw-bold">$${productVariant.price}</td>
                            <td class="text-info fw-bold">${productVariant.stockQuantity}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Action Buttons -->
    <div class="d-flex justify-content-center mt-4">
        <c:if test="${oist == 2}">
            <form action="manager-view-detail-order" method="post" style="display: inline;">
                <input type="hidden" name="oiid" value="${oiid}">
                <input type="hidden" name="oist" value="1">
                <button type="submit" class="btn btn-success btn-lg me-3">
                    <i class="fas fa-check me-2"></i>Mark as Delivered
                </button>
            </form>
            <form action="manager-view-detail-order" method="post" style="display: inline;">
                <input type="hidden" name="oiid" value="${oiid}">
                <input type="hidden" name="oist" value="0">
                <button type="submit" class="btn btn-danger btn-lg me-3">
                    <i class="fas fa-times me-2"></i>Cancel Order
                </button>
            </form>
        </c:if>
        
        <a href="manager_view_list_order" class="btn btn-secondary btn-lg">
            <i class="fas fa-arrow-left me-2"></i>Back to List
        </a>
    </div>
</main>

<style>
    .card {
        transition: transform 0.2s ease-in-out;
    }
    
    .card:hover {
        transform: translateY(-2px);
    }
    
    .card-header {
        border-bottom: none;
    }
    
    .form-control-plaintext {
        background-color: #f8f9fa !important;
        border: 1px solid #dee2e6 !important;
    }
    
    .product-image {
        transition: transform 0.2s ease-in-out;
    }
    
    .product-image:hover {
        transform: scale(1.05);
    }
    
    .variant-table th {
        background: linear-gradient(135deg, #f8f9fa, #e9ecef);
        border-color: #dee2e6;
    }
    
    .btn-lg {
        padding: 12px 24px;
        font-size: 16px;
        border-radius: 8px;
        transition: all 0.3s ease;
    }
    
    .btn-lg:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
        .card-body {
            padding: 15px;
        }
        
        .btn-lg {
            padding: 10px 20px;
            font-size: 14px;
        }
        
        .d-flex.justify-content-center {
            flex-direction: column;
            align-items: center;
        }
        
        .d-flex.justify-content-center .btn {
            margin-bottom: 10px;
            width: 100%;
            max-width: 300px;
        }
    }
</style>
