<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="d-md-block sidebar p-3 bg-info bg-opacity-10" style="position: sticky; top: 0; height: 100vh;">
    <h5 class="text-center p-3">Dashboard</h5>
    <hr/>
    <ul class="nav flex-column">
        <li id="information" class="nav-item mb-3 mt-3">
            <button class="btn btn-toggle dropdown-toggle" data-bs-toggle="collapse" data-bs-target="#home-collapse">
                Manager Account
            </button>
            <div class="collapse" id="home-collapse" style="margin-left: 12px;">
                <a href="${pageContext.request.contextPath}/view_information">View Information</a>
                <a href="${pageContext.request.contextPath}/changePassword">Change Password</a>
                <a href="${pageContext.request.contextPath}/GetAddress">Add Address</a>
            </div>
        </li>
        <li id="order" class="nav-item mb-3">
            <button class="btn btn-toggle dropdown-toggle" data-bs-toggle="collapse" data-bs-target="#dashboard-collapse">
                Manager Orders
            </button>
            <div class="collapse" id="dashboard-collapse" style="margin-left: 12px;">
                <a href="${pageContext.request.contextPath}/view_order_list">Order View</a>
            </div>
        </li>
    </ul>
</nav>

<script>
    let currentURL = window.location.href;
    const contextPath = "${pageContext.request.contextPath}";


    function updateActiveSidebar() {
        const sectionsLocation = ["information", "order"];
        // Xóa tất cả class active trước khi thêm mới
        document.querySelectorAll(".nav-item button").forEach(button => {
            button.classList.remove("bg-primary", "text-white");
        });

        sectionsLocation.forEach(section => {
            if (currentURL.includes(section)) {
                let sectionButton = document.querySelector("#" + section + " button");
                console.log(sectionButton);
                if (sectionButton) {
                    sectionButton.classList.add("bg-primary", "text-white");
                }
            }
        });
    }

    function updateActiveSidebarItem() {
        const menuLinks = document.querySelectorAll(".nav-item .collapse a");

        menuLinks.forEach(link => {
            link.classList.remove("active__sidebar__tiem");
        });

        menuLinks.forEach(link => {
            let href = link.getAttribute("href");
            let fullHref = href.startsWith(contextPath) ? href : contextPath + href;

            if (currentURL.includes(fullHref) || currentURL === fullHref) {
                link.classList.add("active__sidebar__tiem");

                let collapseDiv = link.closest(".collapse");
                if (collapseDiv) {
                    let collapseInstance = bootstrap.Collapse.getOrCreateInstance(collapseDiv);
                    collapseInstance.show();

                    let dropdownButton = collapseDiv.previousElementSibling;
                    if (dropdownButton) {
                        dropdownButton.setAttribute("aria-expanded", "true");
                        dropdownButton.classList.add("bg-primary", "text-white");
                    }
                }
            }
        });
    }

    // Chạy sau khi DOM và Bootstrap sẵn sàng
    document.addEventListener("DOMContentLoaded", function () {
        updateActiveSidebar();
        updateActiveSidebarItem();
    });
</script>