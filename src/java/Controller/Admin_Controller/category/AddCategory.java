/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Admin_Controller.category;

import DAO.DAO_Seller.category.CategoryProcess;
import Model.Admin;
import Model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AddCategory", urlPatterns = {"/add_new_category"})
public class AddCategory extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            response.sendRedirect("ErrorPage.jsp");
            return;
        }
        String categoryName = request.getParameter("categoryName");
        String status = request.getParameter("status");
        Category category = new Category();
        category.setCategoryName(categoryName.trim().replaceAll("\\s+", " "));
        category.setStatus(Integer.parseInt(status));
        try {
            CategoryProcess.INSTANCE.addCategory(category);
            response.sendRedirect(request.getContextPath() + "/ViewCategory?successAddCategory=success");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/ViewCategory?errorAddCategory=" + e.getMessage());
        }
    }
}
