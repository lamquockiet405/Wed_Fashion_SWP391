/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.User_Controller;

import DAO.DAO_Admin.DAOAdmin;
import DAO.DAO_Customer.DAOCart;
import DAO.DAO_User.DAOUsers;
import Model.Cart;
import Model.ProductsVariant;
import Model.Users;
import Model.VariantWithQuantity;
import com.google.gson.Gson;
import static com.google.gson.internal.bind.TypeAdapters.FLOAT;
import com.google.gson.reflect.TypeToken;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author lenovo
 */
@WebServlet(name = "CreateOrders", urlPatterns = {"/CreateOrders"})
public class CreateOrders extends HttpServlet {

 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

        }
    }
  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession();
    Users acc = (Users) session.getAttribute("acc");
    
    // Kiểm tra user đã đăng nhập chưa
    if (acc == null) {
        response.sendRedirect(request.getContextPath() + "/View/Login/Login.jsp?error=Please login to place order");
        return;
    }
    
    DAO.DAO_User.DAOUsers daou = new DAOUsers();
    DAO.DAO_Customer.DAOCart daoc = new DAOCart();

    String cartIDs = request.getParameter("cartIDs");

    if (cartIDs == null || cartIDs.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/View/Cart/Cart.jsp?error=No items selected");
        return;
    }

    String[] cartIdArray = cartIDs.split(",");

    List<Integer> selectedCartIds = new ArrayList<>();
    Map<Integer, Integer> cartQuantityMap = new HashMap<>();
    List<VariantWithQuantity> variantList = new ArrayList<>();
     List<Integer> variantId = new ArrayList<>();

    // Lấy danh sách cartID và quantity
    for (String item : cartIdArray) {
        String[] parts = item.split(":");
        if (parts.length == 2) {
            try {
                int cartId = Integer.parseInt(parts[0]);
                int quantity = Integer.parseInt(parts[1]);
                cartQuantityMap.put(cartId, quantity);
                selectedCartIds.add(cartId); // Thêm cartId vào danh sách
            } catch (NumberFormatException e) {
                System.out.println("Invalid cartID or quantity: " + item);
            }
        }
    }

    // Lưu danh sách cartId vào session
    session.setAttribute("selectedCartIds", selectedCartIds);

    // Duyệt danh sách cartID để lấy thông tin productVariant
    for (Map.Entry<Integer, Integer> entry : cartQuantityMap.entrySet()) {
        int cartId = entry.getKey();
        int quantity = entry.getValue();

        List<Cart> cartItems = daou.GetCartDataByCartId(cartId);
        if (cartItems != null) {
            for (Cart item : cartItems) {
                ProductsVariant variant = daou.getProductsVariantById(item.getProductVariantID());
                
                if (variant != null) {
                    variantList.add(new VariantWithQuantity(variant, quantity));
                }
            }
        }
    }

    request.setAttribute("cartQuantityMap", cartQuantityMap);
    request.setAttribute("variantList", variantList);

    // Chuyển hướng đến trang lấy dữ liệu cho thanh toán
    request.getRequestDispatcher("/GetDataForCheckout").forward(request, response);
}


    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
