<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="c" items="${listCategory}">
    <!-- Modal Update -->
    <div class="modal fade" id="updateCategoryModal-${c.categoryId}" tabindex="-1" aria-labelledby="updateCategoryModalLabel-${c.categoryId}" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateCategoryModalLabel-${c.categoryId}">Update Category</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="update_category" method="post" class="update-category-form" novalidate>
                        <input type="hidden" name="categoryId" value="${c.categoryId}">
                        <div class="mb-3">
                            <label for="categoryName-${c.categoryId}" class="form-label">Category Name</label>
                            <input type="text" 
                                   class="form-control" 
                                   id="categoryName-${c.categoryId}" 
                                   name="categoryName" 
                                   value="${c.categoryName}" 
                                   required>
                            <div class="invalid-feedback">
                                Please enter a category name (minimum 2 characters, maximum 50 characters)
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="status-${c.categoryId}" class="form-label">Status</label>
                            <select class="form-select" id="status-${c.categoryId}" name="status" required>
                                <option value="1" ${c.status == 1 ? 'selected' : ''}>Active</option>
                                <option value="0" ${c.status == 0 ? 'selected' : ''}>Inactive</option>
                            </select>
                            <div class="invalid-feedback">
                                Please select a status
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Save changes</button>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Lấy tất cả các form trong modal
        const forms = document.querySelectorAll('.update-category-form');

        forms.forEach(form => {
            form.addEventListener('submit', function (e) {
                let isValid = true;

                // Validate category name
                const categoryNameInput = form.querySelector('input[name="categoryName"]');
                const categoryName = categoryNameInput.value.trim();
                
                // Reset validation state
                categoryNameInput.classList.remove('is-invalid', 'is-valid');
                
                if (categoryName === '' || categoryName.length < 2 || categoryName.length > 50) {
                    categoryNameInput.classList.add('is-invalid');
                    isValid = false;
                } else {
                    categoryNameInput.classList.add('is-valid');
                }

                // Validate status
                const statusSelect = form.querySelector('select[name="status"]');
                const statusValue = statusSelect.value;
                
                // Reset validation state
                statusSelect.classList.remove('is-invalid', 'is-valid');
                
                if (statusValue !== '1' && statusValue !== '0') {
                    statusSelect.classList.add('is-invalid');
                    isValid = false;
                } else {
                    statusSelect.classList.add('is-valid');
                }

                // Nếu không valid thì ngăn submit
                if (!isValid) {
                    e.preventDefault();
                    e.stopPropagation();
                }
            });

            // Real-time validation cho category name
            const categoryNameInput = form.querySelector('input[name="categoryName"]');
            categoryNameInput.addEventListener('input', function () {
                const value = this.value.trim();
                this.classList.remove('is-invalid', 'is-valid');
                
                if (value === '' || value.length < 2 || value.length > 50) {
                    this.classList.add('is-invalid');
                } else {
                    this.classList.add('is-valid');
                }
            });

            // Real-time validation cho status
            const statusSelect = form.querySelector('select[name="status"]');
            statusSelect.addEventListener('change', function () {
                const value = this.value;
                this.classList.remove('is-invalid', 'is-valid');
                
                if (value !== '1' && value !== '0') {
                    this.classList.add('is-invalid');
                } else {
                    this.classList.add('is-valid');
                }
            });
        });
    });
</script>