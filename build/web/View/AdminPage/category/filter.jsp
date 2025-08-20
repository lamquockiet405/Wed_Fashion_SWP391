<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="filter-section">
    <c:set var="url" value="view_category" />
    <form action="${url}" method="get" class="filter-form">
        <div class="filter-container">
            <div class="filter-left">
                <!-- Category Type Filter -->
                <div class="category-type-container">
                    <a href="${url}?ctype=all&sort=${sort}&search=${search}" 
                       class="category-type ${ctype == 'all' || ctype == null ? 'active' : ''}">
                        <i class="fas fa-list"></i> All
                    </a>
                    <a href="${url}?ctype=live&sort=${sort}&search=${search}" 
                       class="category-type ${ctype == 'live' ? 'active' : ''}">
                        <i class="fas fa-check-circle"></i> Active
                    </a> 
                    <a href="${url}?ctype=unlisted&sort=${sort}&search=${search}" 
                       class="category-type ${ctype == 'unlisted' ? 'active' : ''}">
                        <i class="fas fa-times-circle"></i> Inactive
                    </a>
                </div>

                <!-- Search Box -->
                <div class="search-container">
                    <input class="search-input" 
                           name="search" 
                           type="search" 
                           placeholder="Search by category name..." 
                           value="${search}"
                           aria-label="Search">
                    <input type="hidden" name="ctype" value="${ctype}"/>
                    <input type="hidden" name="sort" value="${sort}"/>
                    <button class="search-btn" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>

            <div class="filter-right">
                <!-- Sort Options -->
                <div class="sort-container">
                    <a class="sort-btn ${sort == 'DESC' || sort == null ? 'active' : ''}" 
                       href="${url}?sort=DESC&ctype=${ctype}&search=${search}">
                        <i class="fas fa-sort-alpha-down"></i> Z-A
                    </a>
                    <a class="sort-btn ${sort == 'ASC' ? 'active' : ''}" 
                       href="${url}?sort=ASC&ctype=${ctype}&search=${search}">
                        <i class="fas fa-sort-alpha-up"></i> A-Z
                    </a>
                </div>

                <!-- Add Category Button -->
                <a href="#" class="add-category-btn" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                    <i class="fas fa-plus"></i> Add Category
                </a>
            </div>
        </div>
    </form>
</div>

<script>
    // Update active states for category types
    function updateCategoryType() {
        const urlParams = new URLSearchParams(window.location.search);
        const ctype = urlParams.get('ctype');
        const categoryTypeLinks = document.querySelectorAll('.category-type');

        categoryTypeLinks.forEach(link => {
            link.classList.remove('active');
        });

        if (ctype === 'live') {
            categoryTypeLinks[1].classList.add('active');
        } else if (ctype === 'unlisted') {
            categoryTypeLinks[2].classList.add('active');
        } else {
            categoryTypeLinks[0].classList.add('active');
        }
    }

    // Update active states for sort buttons
    function updateSortButtons() {
        const urlParams = new URLSearchParams(window.location.search);
        const sort = urlParams.get('sort');
        const sortButtons = document.querySelectorAll('.sort-btn');

        sortButtons.forEach(btn => {
            btn.classList.remove('active');
        });

        if (sort === 'ASC') {
            sortButtons[1].classList.add('active');
        } else {
            sortButtons[0].classList.add('active');
        }
    }

    // Initialize on page load
    document.addEventListener('DOMContentLoaded', function() {
        updateCategoryType();
        updateSortButtons();
    });

    // Handle search form submission
    document.querySelector('.filter-form').addEventListener('submit', function(e) {
        const searchInput = document.querySelector('.search-input');
        if (searchInput.value.trim() === '') {
            // If search is empty, remove search parameter from URL
            const url = new URL(window.location);
            url.searchParams.delete('search');
            window.location.href = url.toString();
            e.preventDefault();
        }
    });
</script>