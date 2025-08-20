<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="url" value="view_category" />
<form method="post" action="${url}">
    <main class="container border shadow" style="border-radius: 5px; background: white">
        <div class="row p-2 border-bottom">
            <span class="col-md-1 text-center"><b>No</b></span>
            <span class="col-md text-center"><b>Name</b></span>
            <span class="col-md-2 text-center"><b>Change Status</b></span>
            <span class="col-md-3 text-center"><b>Action</b></span>
        </div>

        <c:forEach var="c" items="${listCategory}" varStatus="status">
            <div class="row p-2 border-bottom align-items-center mt-3">
                <span class="col-md-1 text-center">${status.index + 1}</span>
                <span class="col-md text-center">${c.categoryName}</span>
                <span class="col-md-2 text-center">
                    <select name="statusAction" class="form-select status-select">
                        <option value="1|${c.categoryId}" ${c.status == 1 ? 'selected' : ''}>Active</option>
                        <option value="0|${c.categoryId}" ${c.status == 0 ? 'selected' : ''}>Inactive</option>
                    </select>
                </span>
                <span class="col-md-3 text-center">
                    <a class="btn btn-warning" 
                       href="#" 
                       data-bs-toggle="modal" 
                       data-bs-target="#updateCategoryModal-${c.categoryId}">
                        Update
                    </a>
                </span>
            </div>
        </c:forEach>
        <input type="hidden" value="" name="c_select" id="c_select"/>
    </main>
</form>

<script>
    // Script for status select
    document.addEventListener('DOMContentLoaded', function () {
        let selects = document.querySelectorAll('.status-select');
        selects.forEach(function (select) {
            select.addEventListener('change', function () {
                document.getElementById("c_select").value = select.value;
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