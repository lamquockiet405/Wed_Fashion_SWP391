/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Admin_Controller.product;

import DAO.DAO_Seller.category.CategoryProcess;
import DAO.DAO_Seller.image.ImageProcess;
import DAO.DAO_Seller.product.ProductProcess;
import DAO.DAO_Seller.shop.ShopProcess;
import Model.Admin;
import Model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "manager_product", urlPatterns = "/mange_product")
public class ViewListProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/LogOutController");
            return;
        }
        try {
            int pageSize = 10;
            int page = getCurrentPage(request);

            String ptype = request.getParameter("ptype") == null ? "review" : request.getParameter("ptype");
            String status = ptype.equals("live") ? "1" : ptype.equals("violation") ? "2" : ptype.equals("review") ? "3" : ptype.equals("unlisted") ? "4" : null;
            String search = request.getParameter("search") != null ? request.getParameter("search").trim().replaceAll("\\s+", " ") : request.getParameter("search");
            String sort = request.getParameter("sort") == null ? "DESC" : request.getParameter("sort");
            int totalPage = ProductProcess.INSTANCE.getTotalProducts(pageSize, status, search, sort);
            List<Product> products = ProductProcess.INSTANCE.getProductsByPage(page, pageSize, status, search, sort);

            request.setAttribute("sort", sort);
            request.setAttribute("ptype", ptype);
            request.setAttribute("search", search);
            request.setAttribute("productList", products);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPage);
            request.setAttribute("categoryProcess", CategoryProcess.INSTANCE);
            request.setAttribute("imageProcess", ImageProcess.INSTANCE);
            request.setAttribute("shopProcess", ShopProcess.INSTANCE);
        } catch (Exception e) {
            request.setAttribute("error", "The server is busy! Plese try again.");
        }
        request.getRequestDispatcher("/View/AdminPage/product/ViewListProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/LogOutController");
            return;
        }
        try {
            String statusAction = request.getParameter("p_select");
            String[] splitData = statusAction.split("\\|");
            ProductProcess.INSTANCE.UpdateToDisable(splitData[0], splitData[1]);
            request.setAttribute("successUpdateProduct", "Change status product is successfully!");
        } catch (Exception e) {
            request.setAttribute("errorUpdateProduct", e.getMessage());
        }
        doGet(request, response);
    }

    private int getCurrentPage(HttpServletRequest request) {
        String pageParam = request.getParameter("page");
        int page = 1;
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        return page;
    }
}
