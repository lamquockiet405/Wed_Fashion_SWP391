<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="pagination d-flex justify-content-center">
    <!-- Tính startPage và endPage -->
    <c:set var="startPage" value="${currentPage - 2}"/>
    <c:set var="endPage" value="${currentPage + 2}"/>

    <!-- Điều chỉnh startPage và endPage để không vượt quá giới hạn -->
    <c:if test="${startPage < 1}">
        <c:set var="endPage" value="${endPage + (1 - startPage)}"/>
        <c:set var="startPage" value="1"/>
    </c:if>
    <c:if test="${endPage > totalPages}">
        <c:set var="startPage" value="${startPage - (endPage - totalPages)}"/>
        <c:set var="endPage" value="${totalPages}"/>
    </c:if>
    <c:if test="${startPage < 1}">
        <c:set var="startPage" value="1"/>
    </c:if>

    <!-- Nút "Trước" -->
    <c:if test="${currentPage > 1}">
        <a href="view_product?page=${currentPage - 1}&ptype=${ptype}&sort=${sort}&search=${search}">&laquo; pre</a>
    </c:if>

    <!-- Hiển thị "1 ..." nếu startPage > 1 -->
    <c:if test="${startPage > 1}">
        <a href="view_product?page=1&ptype=${ptype}&sort=${sort}&search=${search}">1</a>
        <span>...</span>
    </c:if>

    <!-- Các số trang từ startPage đến endPage -->
    <c:forEach var="i" begin="${startPage}" end="${endPage}">
        <c:choose>
            <c:when test="${i == currentPage}">
                <span class="current">${i}</span>
            </c:when>
            <c:otherwise>
                <a href="view_product?page=${i}&ptype=${ptype}&sort=${sort}&search=${search}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <!-- Hiển thị "... totalPages" nếu endPage < totalPages -->
    <c:if test="${endPage < totalPages}">
        <span>...</span>
        <a href="view_product?page=${totalPages}&ptype=${ptype}&sort=${sort}&search=${search}">${totalPages}</a>
    </c:if>

    <!-- Nút "Sau" -->
    <c:if test="${currentPage < totalPages}">
        <a href="view_product?page=${currentPage + 1}&ptype=${ptype}&sort=${sort}&search=${search}">post &raquo;</a>
    </c:if>
</div>