/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Admin_Controller.product;

import DAO.DAO_Seller.category.CategoryProcess;
import DAO.DAO_Seller.image.ImageProcess;
import DAO.DAO_Seller.product.ProductProcess;
import DAO.DAO_Seller.productvariant.ProductVariantProcess;
import Model.Admin;
import Model.Image;
import Model.Product;
import Model.ProductVariant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "view_detail_product", urlPatterns = "/view_detail_product")
public class ViewDetailProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/LogOutController");
            return;
        }
        try {
            String pid = request.getParameter("pid") == null ? (String) request.getAttribute("pid") : request.getParameter("pid");
            Product product = ProductProcess.INSTANCE.getProductById(pid);
            List<Image> imageList = ImageProcess.INSTANCE.getAllImagesByProductID(product.getProductId());
            List<ProductVariant> productVariantListRead = ProductVariantProcess.INSTANCE.read(pid);

            request.setAttribute("categoryProcess", CategoryProcess.INSTANCE);
            request.setAttribute("product", product);
            request.setAttribute("productImages", imageList);
            request.setAttribute("productVariantList", productVariantListRead);
        } catch (Exception e) {
            request.setAttribute("error", "The system error!");
        }
        request.getRequestDispatcher("/View/AdminPage/product/ViewDetailProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/LogOutController");
            return;
        }
        try {
            String pid = request.getParameter("pid");
            String pud = request.getParameter("pud");

            if (pid != null && pud != null && !pid.isBlank() && !pud.isBlank()) {
                ProductProcess.INSTANCE.UpdateToDisable(pud, pid);
                request.setAttribute("pid", pid);
                request.setAttribute("success", "Update product successfully!");
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        doGet(request, response);
    }
}
