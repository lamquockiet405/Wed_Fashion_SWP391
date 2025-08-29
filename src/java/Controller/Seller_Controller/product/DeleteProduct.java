/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Seller_Controller.product;

import DAO.DAO_Seller.product.ProductProcess;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DeleteProduct", urlPatterns = {"/delete_product"})
public class DeleteProduct extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("acc");
        if (user == null || !user.getUserRole().equalsIgnoreCase("seller")) {
            response.sendRedirect(request.getContextPath() + "/LogOutController");
            return;
        }

        String pid = request.getParameter("pid");
        try {
            // Force delete: removes order items, variants, images, then product
            ProductProcess.INSTANCE.deleteProductForce(pid);
            request.getSession().setAttribute("successUpdateProduct", "Product deleted successfully");
        } catch (Exception e) {
            request.getSession().setAttribute("errorUpdateProduct", e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/view_product");
    }
}


