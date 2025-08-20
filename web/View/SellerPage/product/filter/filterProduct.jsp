<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
    <c:set var="url" value="view_product" />
    <form action="view_product" method="get" >
        <div class="d-flex justify-content-between">
            <div id="ptype" class="product-type-container mt-3">
                <a href="${url}?ptype=all&sort=${sort}&search=${search}" class="product_type">All</a>
                <a href="${url}?ptype=live&sort=${sort}&search=${search}" class="product_type">Active</a> 
                <a href="${url}?ptype=violation&sort=${sort}&search=${search}" class="product_type">Violating</a>
                <a href="${url}?ptype=review&sort=${sort}&search=${search}" class="product_type">Pending</a>
                <a href="${url}?ptype=unlisted&sort=${sort}&search=${search}" class="product_type">Inactive</a>
            </div>
            <div class="d-flex justify-content-center align-items-center">
                <a href="./add_new_product" class="btn btn-success" >
                    Add new product
                </a>
            </div>
        </div>
        <div class="d-flex justify-content-between">
            <div class="d-flex">
                <input class="form-control me-2 shadow" name="search" type="search" placeholder="Search by name" aria-label="Search" value="${search}"/>
                <input type="hidden" name="ptype" value="${ptype}"/>
                <input type="hidden" name="sort" value="${sort}"/>
                <button class="btn btn-outline-secondary shadow" type="submit">Search</button>
            </div>
            <div class="filter-sort__list-filter d-flex">
                <a class="btn shadow d-flex justify-content-center align-items-center me-2 ${sort.equalsIgnoreCase("DESC") ? "bg-warning " : ""}" 
                   href="./view_product?sort=DESC&ptype=${ptype}&search=${search}" 
                   style="background-color: #f0efef; padding-top: 0; padding-bottom: 0">
                    <div class="icon d-flex justify-content-center align-items-center">
                        <svg height="15" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                            <path d="M416 288h-95.1c-17.67 0-32 14.33-32 32s14.33 32 32 32H416c17.67 0 32-14.33 32-32S433.7 288 416 288zM544 32h-223.1c-17.67 0-32 14.33-32 32s14.33 32 32 32H544c17.67 0 32-14.33 32-32S561.7 32 544 32zM352 416h-32c-17.67 0-32 14.33-32 32s14.33 32 32 32h32c17.67 0 31.1-14.33 31.1-32S369.7 416 352 416zM480 160h-159.1c-17.67 0-32 14.33-32 32s14.33 32 32 32H480c17.67 0 32-14.33 32-32S497.7 160 480 160zM192.4 330.7L160 366.1V64.03C160 46.33 145.7 32 128 32S96 46.33 96 64.03v302L63.6 330.7c-6.312-6.883-14.94-10.38-23.61-10.38c-7.719 0-15.47 2.781-21.61 8.414c-13.03 11.95-13.9 32.22-1.969 45.27l87.1 96.09c12.12 13.26 35.06 13.26 47.19 0l87.1-96.09c11.94-13.05 11.06-33.31-1.969-45.27C224.6 316.8 204.4 317.7 192.4 330.7z"></path>
                        </svg>
                    </div>
                    &nbsp;Date add new - old
                </a>
                <a class="btn shadow d-flex justify-content-center align-items-center ${sort.equalsIgnoreCase("ASC") ? "bg-warning " : ""}" 
                   href="./view_product?sort=ASC&ptype=${ptype}&search=${search}" 
                   style="background-color: #f0efef; margin-right: 10px; padding-top: 0; padding-bottom: 0">
                    <div class="icon d-flex justify-content-center align-items-center">
                        <svg height="15" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                            <path d="M320 224H416c17.67 0 32-14.33 32-32s-14.33-32-32-32h-95.1c-17.67 0-32 14.33-32 32S302.3 224 320 224zM320 352H480c17.67 0 32-14.33 32-32s-14.33-32-32-32h-159.1c-17.67 0-32 14.33-32 32S302.3 352 320 352zM320 96h32c17.67 0 31.1-14.33 31.1-32s-14.33-32-31.1-32h-32c-17.67 0-32 14.33-32 32S302.3 96 320 96zM544 416h-223.1c-17.67 0-32 14.33-32 32s14.33 32 32 32H544c17.67 0 32-14.33 32-32S561.7 416 544 416zM192.4 330.7L160 366.1V64.03C160 46.33 145.7 32 128 32S96 46.33 96 64.03v302L63.6 330.7c-6.312-6.883-14.94-10.38-23.61-10.38c-7.719 0-15.47 2.781-21.61 8.414c-13.03 11.95-13.9 32.22-1.969 45.27l87.1 96.09c12.12 13.26 35.06 13.26 47.19 0l87.1-96.09c11.94-13.05 11.06-33.31-1.969-45.27C224.6 316.8 204.4 317.7 192.4 330.7z"></path>
                        </svg>
                    </div>
                    &nbsp;Date add old-new
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
            ptypeLinks[0].classList.add("active_ptype");
        }
    }

    document.addEventListener("DOMContentLoaded", function () {
        updateProductType();
    });
</script>