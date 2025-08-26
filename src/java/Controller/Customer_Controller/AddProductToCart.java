/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Customer_Controller;

import DAO.DAO_Customer.DAOCart;
import Model.Chinh.Cart;
import Model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author Dell
 */
@WebServlet(name = "AddProductToCart", urlPatterns = {"/addProductToCart"})
public class AddProductToCart extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddProductToCart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddProductToCart at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Users acc = (Users) session.getAttribute("acc");
        
        // Debug logging
        System.out.println("=== AddProductToCart Debug ===");
        System.out.println("Session ID: " + (session != null ? session.getId() : "null"));
        System.out.println("User acc: " + (acc != null ? acc.getUsername() : "null"));
        System.out.println("VariantID parameter: " + request.getParameter("variantID"));
        System.out.println("Quantity parameter: " + request.getParameter("quantity"));
        
        if (acc == null) {
            System.out.println("User not logged in - returning login redirect");
            // Trả về JSON response với thông tin redirect
            response.getWriter().write("{\"success\": false, \"message\": \"Please login to add products to cart\", \"redirect\": \"" + request.getContextPath() + "/View/Login/Login.jsp?error=Please login to add products to cart\"}");
            return;
        }
        
        try {
            // Lấy dữ liệu từ request
            int userID = acc.getUserID();
            int productVarianID = Integer.parseInt(request.getParameter("variantID"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            System.out.println("Processing cart operation - UserID: " + userID + ", VariantID: " + productVarianID + ", Quantity: " + quantity);

            // Kiểm tra giá trị hợp lệ (quantity phải lớn hơn 0)
            // Thêm vào giỏ hàng
            DAOCart ct = new DAOCart();
            boolean found = false; // Biến cờ kiểm tra
            List<Cart> carts = ct.getCartItems(userID);
            for (Cart cart : carts) {
                if (cart.getProductVariantID() == productVarianID) {
                    int quantityAdd = quantity + cart.getQuantity();
                    ct.updateCartItem(cart.getCartID(), quantityAdd);
                    found = true; // Đánh dấu là đã tìm thấy
                    break; // Thoát khỏi vòng lặp vì đã xử lý xong
                }
            }

            // Nếu không tìm thấy sản phẩm, thêm mới
            if (!found) {
                Cart c = new Cart(userID, productVarianID, quantity);
                ct.addCartItem(c);
            }
            // Trả kết quả JSON
            System.out.println("Cart operation successful");
            response.getWriter().write("{\"success\": true}");
        } catch (NumberFormatException e) {
            // Lỗi khi parse số (ví dụ: userID hoặc quantity không hợp lệ)
            System.out.println("NumberFormatException: " + e.getMessage());
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid input format\"}");
        } catch (Exception e) {
            // Lỗi khác (ví dụ: lỗi kết nối database)
            System.out.println("Exception: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Internal server error\"}");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
