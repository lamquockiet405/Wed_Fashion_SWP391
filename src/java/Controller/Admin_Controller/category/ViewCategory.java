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
import java.util.List;

@WebServlet(name = "ViewCategory", urlPatterns = {"/ViewCategory", "/view_category"})
public class ViewCategory extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        //CheckAdmin
        if (admin == null) {
            response.sendRedirect("ErrorPage.jsp");
            return;
        }
        String ctype = request.getParameter("ctype");
        String search = request.getParameter("search");
        String sort = request.getParameter("sort") == null ? "DESC" : request.getParameter("sort");
        int pageSize = 10;
        int page = 1;
        try { page = Integer.parseInt(request.getParameter("page")); } catch (Exception ignore) {}
        String status = null;
        if ("live".equalsIgnoreCase(ctype)) status = "1";
        else if ("unlisted".equalsIgnoreCase(ctype)) status = "0";

        int totalPages = CategoryProcess.INSTANCE.getTotalPage(pageSize, search, sort, status);
        List<Category> list = CategoryProcess.INSTANCE.getAllCategories(page, pageSize, search, sort, status);

        request.setAttribute("ctype", ctype);
        //search category
        request.setAttribute("search", search);
        request.setAttribute("sort", sort);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("listCategory", list);

        request.getRequestDispatcher("./View/AdminPage/category/view_category.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
