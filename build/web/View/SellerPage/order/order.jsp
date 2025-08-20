<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="order-table-container">
    <table class="order-table">
        <thead>
            <tr>
                <th>No.</th>
                <th>Customer Information</th>
                <th>Product Details</th>
                <th>Quantity</th>
                <th>Order Date</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:set var="id" value="0" />
            <c:forEach var="oi" items="${orderItemList}" varStatus="status">
                <c:set var="id" value="${status.count}"/>
                <tr>
                    <td class="order-id">${id}</td>
                    <td>
                        <div class="customer-info">
                            <div class="customer-name">
                                <i class="fas fa-user"></i> ${oi.customerName}
                            </div>
                            <div class="customer-details">
                                <small><i class="fas fa-envelope"></i> ${oi.customerEmail}</small><br>
                                <small><i class="fas fa-phone"></i> ${oi.customerPhone}</small><br>
                                <small>
                                    <i class="fas fa-map-marker-alt"></i> 
                                    <c:choose>
                                        <c:when test="${not empty oi.customerAddress}">
                                            ${oi.customerAddress}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">No address</span>
                                        </c:otherwise>
                                    </c:choose>
                                </small>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div class="product-info">
                            <div class="product-name">${oi.productName}</div>
                            <div class="product-variant">
                                <small class="text-muted">Variant: ${oi.productVariantName}</small>
                            </div>
                        </div>
                    </td>
                    <td class="order-total">${oi.quantityTotal}</td>
                    <td class="order-date">
                        <fmt:formatDate value="${oi.dateAdd}" pattern="dd/MM/yyyy HH:mm"/>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${oi.statusOrderItem == 0}">
                                <span class="status-badge status-cancelled">Cancelled</span>
                            </c:when>
                            <c:when test="${oi.statusOrderItem == 1}">
                                <span class="status-badge status-delivered">Delivered</span>
                            </c:when>
                            <c:when test="${oi.statusOrderItem == 2}">
                                <span class="status-badge status-pending">Waiting</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge status-cancelled">Unknown</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="manager-view-detail-order?pid=${oi.productId}&pvid=${oi.productVariantId}&oiid=${oi.orderItemId}" 
                           class="action-btn btn-view">
                            <i class="fas fa-eye"></i> Detail
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<style>
    .customer-info {
        line-height: 1.4;
    }
    
    .customer-name {
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 5px;
    }
    
    .customer-details {
        color: #6c757d;
        font-size: 12px;
    }
    
    .customer-details small {
        display: block;
        margin-bottom: 2px;
    }
    
    .product-info {
        line-height: 1.4;
    }
    
    .product-name {
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 5px;
    }
    
    .product-variant {
        color: #6c757d;
        font-size: 12px;
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
        .order-table thead th,
        .order-table tbody td {
            padding: 12px 15px;
            font-size: 13px;
        }
        
        .customer-details small {
            font-size: 11px;
        }
        
        .action-btn {
            padding: 6px 12px;
            font-size: 12px;
        }
    }
</style>