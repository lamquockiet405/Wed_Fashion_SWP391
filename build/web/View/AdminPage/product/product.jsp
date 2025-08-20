<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<form method="post" action="mange_product">
    <div class="product-table-container">
        <table class="product-table">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Shop</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Change Status</th>
                    <th>Date Added</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="url" value="view_detail_product" />
                <c:forEach var="p" items="${productList}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${shopProcess.getShopById(p.shopId).getName()}</td>
                        <td>
                            <span class="product-name" onclick="window.location.href = '${url}?pid=${p.productId}'">
                                ${p.productName}
                            </span>
                        </td>
                        <td>${categoryProcess.getCategoryByID(p.categoryId).getCategoryName()}</td>
                        <td>
                            <c:choose>
                                <c:when test="${p.status == 1}">
                                    <select name="statusAction" class="status-select">
                                        <option value="1|${p.productId}" ${p.status == 1 ? 'selected' : ''}>Active</option>
                                        <option value="2|${p.productId}" ${p.status == 2 ? 'selected' : ''}>Violating</option>
                                    </select>
                                </c:when>
                                <c:when test="${p.status == 2}">
                                    <select name="statusAction" class="status-select">
                                        <option value="2|${p.productId}" ${p.status == 2 ? 'selected' : ''}>Violating</option>
                                        <option value="1|${p.productId}" ${p.status == 1 ? 'selected' : ''}>Active</option>
                                    </select>
                                </c:when>
                                <c:when test="${p.status == 3}">
                                    <select name="statusAction" class="status-select">
                                        <option value="3|${p.productId}" ${p.status == 3 ? 'selected' : ''}>Pending</option>
                                        <option value="1|${p.productId}" ${p.status == 1 ? 'selected' : ''}>Active</option>
                                        <option value="2|${p.productId}" ${p.status == 2 ? 'selected' : ''}>Violating</option>
                                    </select>
                                </c:when>
                                <c:otherwise>
                                    <select name="statusAction" class="status-select">
                                        <option value="4|${p.productId}" ${p.status == 4 ? 'selected' : ''}>Inactive</option>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${p.createdAt}</td>
                        <td>
                            <a class="detail-btn" href="${url}?pid=${p.productId}">
                                <i class="fas fa-eye"></i> Detail
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <input type="hidden" value="" name="p_select" id="p_select"/>
</form>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        let selects = document.querySelectorAll('.status-select');

        selects.forEach(function (select) {
            select.addEventListener('change', function () {
                console.log(select.value);
                document.getElementById("p_select").value = select.value;
                if (confirm("Are you sure you want to change the status?")) {
                    select.form.submit();
                } else {
                    select.value = select.dataset.previousValue;
                }
            });
            select.dataset.previousValue = select.value;
        });
    });
</script>

