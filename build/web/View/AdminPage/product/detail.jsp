<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="product-detail-container">
    <div class="product-detail-header">
        <h1 class="product-detail-title">Product Detail</h1>
    </div>
    
    <div class="product-detail-content">
        <div class="row">
            <!-- Product Images -->
            <div class="col-md-6">
                <div class="product-images-section">
                    <h3 class="product-images-title">
                        <i class="fas fa-images"></i> Product Images
                    </h3>
                    <div class="product-images-grid" id="image-preview">
                        <c:forEach var="img" items="${productImages}">
                            <div class="product-image-item">
                                <img src="${img.image}" class="product-image" alt="Product Image">
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Product Information -->
            <div class="col-md-6">
                <div class="product-info-section">
                    <h3 class="product-info-title">
                        <i class="fas fa-info-circle"></i> Product Information
                    </h3>
                    
                    <div class="info-item">
                        <div class="info-label">Product Name</div>
                        <div class="info-value">${product.productName}</div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">Category</div>
                        <div class="info-value">${categoryProcess.getCategoryByID(product.categoryId).categoryName}</div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">Description</div>
                        <div class="info-description">${product.description}</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Product Variants -->
        <div class="product-variants-section">
            <h3 class="product-variants-title">
                <i class="fas fa-cubes"></i> Product Variants
            </h3>
            <div class="table-responsive">
                <table class="variants-table">
                    <thead>
                        <tr>
                            <th>Image</th>
                            <th>Model</th>
                            <th>Color</th>
                            <th>Size</th>
                            <th>Price</th>
                            <th>Stock</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="variant" items="${productVariantList}">
                            <tr>
                                <td>
                                    <img src="${variant.image}" class="variant-image" alt="Variant Image">
                                </td>
                                <td>${variant.model}</td>
                                <td>${variant.color}</td>
                                <td>${variant.size}</td>
                                <td>$${variant.price}</td>
                                <td>${variant.stockQuantity}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <c:if test="${product.status == 3}">
                <form action="view_detail_product" method="post" style="display: inline;">
                    <input type="hidden" name="pid" value="${product.productId}">
                    <input type="hidden" name="pud" value="1">
                    <button type="submit" class="action-btn btn-success">
                        <i class="fas fa-check"></i> Activate
                    </button>
                </form>
                <form action="view_detail_product" method="post" style="display: inline;">
                    <input type="hidden" name="pid" value="${product.productId}">
                    <input type="hidden" name="pud" value="2">
                    <button type="submit" class="action-btn btn-danger">
                        <i class="fas fa-ban"></i> Mark as Violating
                    </button>
                </form>
            </c:if>
            <c:if test="${product.status == 2}">
                <form action="view_detail_product" method="post" style="display: inline;">
                    <input type="hidden" name="pid" value="${product.productId}">
                    <input type="hidden" name="pud" value="1">
                    <button type="submit" class="action-btn btn-success">
                        <i class="fas fa-check"></i> Change to Active
                    </button>
                </form>
            </c:if>
            <c:if test="${product.status == 1}">
                <form action="view_detail_product" method="post" style="display: inline;">
                    <input type="hidden" name="pid" value="${product.productId}">
                    <input type="hidden" name="pud" value="2">
                    <button type="submit" class="action-btn btn-danger">
                        <i class="fas fa-ban"></i> Change to Violating
                    </button>
                </form>
            </c:if>
            <a href="mange_product" class="action-btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to List
            </a>
        </div>
    </div>
</div>
