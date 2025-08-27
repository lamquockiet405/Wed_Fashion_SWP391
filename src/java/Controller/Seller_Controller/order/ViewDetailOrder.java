/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Seller_Controller.order;

import DAO.DAO_Seller.category.CategoryProcess;
import DAO.DAO_Seller.image.ImageProcess;
import DAO.DAO_Seller.order.OrderItemProcess;
import DAO.DAO_Seller.product.ProductProcess;
import DAO.DAO_Seller.productvariant.ProductVariantProcess;
import DAO.DAO_User.DAOUsers;
import Model.Image;
import Model.OrderItems;
import Model.Product;
import Model.ProductVariant;
import Model.Users;
import Model.OrderView;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "manager-view-detail-order", urlPatterns = "/manager-view-detail-order")
public class ViewDetailOrder extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("acc");
        if (user == null || !user.getUserRole().equalsIgnoreCase("seller")) {
            response.sendRedirect(request.getContextPath() + "/LogOutController");
            return;
        }

        try {
            String pid = request.getParameter("pid");
            String pvid = request.getParameter("pvid");
            String oiid = request.getParameter("oiid");

            OrderItems orderItem = OrderItemProcess.INSTANCE.getOrderItemById(oiid);

            Product product = ProductProcess.INSTANCE.getProductById(pid);
            List<Image> imageList = ImageProcess.INSTANCE.getAllImagesByProductID(product.getProductId());
            ProductVariant productVariant = ProductVariantProcess.INSTANCE.getProductVariantById(pvid);

            // Lấy thông tin orderView để hiển thị thông tin khách hàng
            OrderView orderView = OrderItemProcess.INSTANCE.getOrderViewByOrderItemId(oiid, user.getUserID());
            
            // Debug: Nếu không lấy được thông tin, thử method debug
            if (orderView == null) {
                System.out.println("Debug: getOrderViewByOrderItemId returned null, trying debug method...");
                orderView = OrderItemProcess.INSTANCE.getOrderViewDebug(oiid);
                if (orderView != null) {
                    System.out.println("Debug: getOrderViewDebug succeeded");
                } else {
                    System.out.println("Debug: getOrderViewDebug also failed, trying simple method...");
                    // Thử method đơn giản nhất
                    orderView = OrderItemProcess.INSTANCE.getCustomerNameSimple(oiid);
                    if (orderView != null) {
                        System.out.println("Debug: getCustomerNameSimple succeeded");
                    } else {
                        System.out.println("Debug: All methods failed");
                    }
                }
            } else {
                System.out.println("Debug: getOrderViewByOrderItemId succeeded - Customer: " + orderView.getCustomerName());
            }

            request.setAttribute("oiid", oiid);
            request.setAttribute("oist", orderItem.getStatus());
            request.setAttribute("categoryProcess", CategoryProcess.INSTANCE);
            request.setAttribute("product", product);
            request.setAttribute("productImages", imageList);
            request.setAttribute("productVariant", productVariant);
            request.setAttribute("orderView", orderView);
        } catch (Exception e) {
            request.setAttribute("error", "The system error!");
        }
        request.getRequestDispatcher("/View/SellerPage/order/order-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("acc");
        if (user == null || !user.getUserRole().equalsIgnoreCase("seller")) {
            response.sendRedirect(request.getContextPath() + "/LogOutController");
            return;
        }

        String oiid = request.getParameter("oiid");
        String oist = request.getParameter("oist");

        if (oiid == null || oist == null || oiid.isBlank() || oist.isBlank()) {
            request.setAttribute("error", "The system error! Data null.");
        } else {
            try {
                DAO.DAO_User.DAOUsers daou = new DAOUsers();
                
                OrderItemProcess.INSTANCE.changeStatus(oist, oiid); // at index 0 is status, index 1 is orderItemId
                daou.updateStatusBillDetail(oist, oiid);
                request.setAttribute("success", "Change status product successfull.");
            } catch (Exception e) {
                request.setAttribute("error", e.getMessage());
            }
        }

        request.getRequestDispatcher("/View/SellerPage/order/order-detail.jsp").forward(request, response);
    }
}
