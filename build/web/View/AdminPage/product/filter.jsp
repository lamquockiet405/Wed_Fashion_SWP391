<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="filter-section">
    <c:set var="url" value="mange_product" />
    <form action="mange_product" method="get">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div id="ptype" class="product-type-container">
                <a href="${url}?ptype=all&sort=${sort}&search=${search}" class="product_type">All</a>
                <a href="${url}?ptype=live&sort=${sort}&search=${search}" class="product_type">Active</a> 
                <a href="${url}?ptype=violation&sort=${sort}&search=${search}" class="product_type">Violating</a>
                <a href="${url}?ptype=review&sort=${sort}&search=${search}" class="product_type">Pending</a>
                <a href="${url}?ptype=unlisted&sort=${sort}&search=${search}" class="product_type">Inactive</a>
            </div>
        </div>
        <div class="d-flex justify-content-between align-items-center">
            <div class="search-box">
                <input class="form-control" name="search" type="search" placeholder="Search by name" aria-label="Search" value="${search}"/>
                <input type="hidden" name="ptype" value="${ptype}"/>
                <input type="hidden" name="sort" value="${sort}"/>
                <button class="btn" type="submit">
                    <i class="fas fa-search"></i> Search
                </button>
            </div>
            <div class="sort-buttons">
                <a class="sort-btn ${sort.equalsIgnoreCase("DESC") ? "active" : ""}" 
                   href="./${url}?sort=DESC&ptype=${ptype}&search=${search}">
                    <i class="fas fa-sort-amount-down"></i>
                    Date add new - old
                </a>
                <a class="sort-btn ${sort.equalsIgnoreCase("ASC") ? "active" : ""}" 
                   href="./${url}?sort=ASC&ptype=${ptype}&search=${search}">
                    <i class="fas fa-sort-amount-up"></i>
                    Date add old-new
                </a>
            </div>
        </div>
    </form>
</div>

<script>
    function updateProductType() {
        let currentLocation = window.location.href;
        const ptypeLinks = document.querySelectorAll("#ptype a");

        ptypeLinks.forEach(link => {
            link.classList.remove("active_ptype");
        });
        if (currentLocation.includes("ptype=all")) {
            ptypeLinks[0].classList.add("active_ptype");
        } else if (currentLocation.includes("ptype=live")) {
            ptypeLinks[1].classList.add("active_ptype");
        } else if (currentLocation.includes("ptype=violation")) {
            ptypeLinks[2].classList.add("active_ptype");
        } else if (currentLocation.includes("ptype=review")) {
            ptypeLinks[3].classList.add("active_ptype");
        } else if (currentLocation.includes("ptype=unlisted")) {
            ptypeLinks[4].classList.add("active_ptype");
        } else {
            ptypeLinks[3].classList.add("active_ptype");
        }
    }
    document.addEventListener("DOMContentLoaded", function () {
        updateProductType();
    });
</script>