<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<form method="post" action="view_product">
    <main class="container border shadow" style="border-radius: 5px;">
        <div class="row p-2 border-bottom">
            <span class="col-md-1 text-center"><b>No</b></span>
            <span class="col-md-2 text-center"><b>Image</b></span>
            <span class="col-md text-center"><b>Name</b></span>
            <span class="col-md-2 text-center"><b>Category</b></span>
            <span class="col-md text-center"><b>Change Status</b></span>
            <span class="col-md-2 text-center"><b>Action</b></span>
        </div>

        <c:forEach var="p" items="${productList}" varStatus="status">
            <div class="row p-2 border-bottom align-items-center mt-3" >
                <span class="col-md-1 text-center">${status.index + 1}</span>
                <span class="col-md-2 text-center" onclick="window.location.href = 'update_product?pid=${p.productId}'" style="cursor: pointer">
                    <!-- Kiểm tra null cho hình ảnh -->
                    <c:set var="topImage" value="${imageProcess.getTop1ImageByProductID(p.productId)}" />
                    <div class="p-2 border rounded" >
                        <img src="${topImage != null ? topImage.image : 'default-image-url'}" alt="image product" class="w-100" style="object-fit: contain" />
                    </div>
                </span>
                <span class="col-md text-center" onclick="window.location.href = 'update_product?pid=${p.productId}'" style="cursor: pointer">${p.productName}</span>
                <span class="col-md-2 text-center" >${categoryProcess.getCategoryByID(p.categoryId).getCategoryName()}</span>
                <span class="col-md text-center">
                    <c:choose>
                        <c:when test="${p.status == 3}">
                            <select name="statusAction" class="form-select status-select">
                                <option value="3|${p.productId}" ${p.status == 3 ? 'selected' : ''}>Pending</option>
                            </select>
                        </c:when>
                        <c:when test="${p.status == 2}">
                            <select name="statusAction" class="form-select status-select">
                                <option value="2|${p.productId}" ${p.status == 2 ? 'selected' : ''}>Violating</option>
                            </select>
                        </c:when>
                        <c:otherwise>
                            <select name="statusAction" class="form-select status-select">
                                <option value="1|${p.productId}" ${p.status == 1 ? 'selected' : ''}>Active</option>
                                <option value="4|${p.productId}" ${p.status == 4 ? 'selected' : ''}>Inactive</option>
                            </select>
                        </c:otherwise>
                    </c:choose>
                </span>
                <span class="col-md-2 text-center"><a class="btn btn-warning" href="update_product?pid=${p.productId}">Update</a></span>
            </div>
        </c:forEach>
        <input type="hidden" value="" name="p_select" id="p_select"/>
    </main>
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

