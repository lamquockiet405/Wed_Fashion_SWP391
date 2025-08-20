<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCategoryModalLabel">Add New Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="add_new_category" method="post" id="addCategoryForm" novalidate>
                    <div class="mb-3">
                        <label for="categoryName" class="form-label">Category Name</label>
                        <input type="text" 
                               class="form-control" 
                               id="categoryName" 
                               name="categoryName" 
                               required 
                               maxlength="50"
                               oninput="validateCategoryName()">
                        <div class="invalid-feedback" id="categoryNameFeedback">
                            Please enter a category name (maximum 100 characters).
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="status" class="form-label">Status</label>
                        <select class="form-select" id="status" name="status">
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Save</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
    // Client-side validation
    function validateCategoryName() {
        const input = document.getElementById('categoryName');
        const feedback = document.getElementById('categoryNameFeedback');
        
        if (!input.value) {
            input.classList.add('is-invalid');
            feedback.textContent = 'Category name cannot be empty.';
        } else if (input.value.length > 50 || input.value.length < 2) {
            input.classList.add('is-invalid');
            feedback.textContent = 'Please enter a category name (minimum 2 characters, maximum 50 characters)';
        } else {
            input.classList.remove('is-invalid');
            input.classList.add('is-valid');
        }
    }

    // Form submission validation
    document.getElementById('addCategoryForm').addEventListener('submit', function(event) {
        const input = document.getElementById('categoryName');
        
        if (!input.value || input.value.length > 50 || input.value.length < 2) {
            event.preventDefault();
            validateCategoryName();
        }
    });
</script>