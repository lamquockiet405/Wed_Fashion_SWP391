package Controller.Customer_Controller;

import DAO.DAO_Customer.DAOCart;
import DAO.DAO_Customer.DAOProduct;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import Model.Chinh.Cart;
import Model.Chinh.Products;
import Model.Chinh.ProductsVariant;
import Model.Users;

@WebServlet(name = "Cart", urlPatterns = {"/cart"})
public class CartPage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Phương thức này chỉ dùng làm fallback (nếu cần)
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Cart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Cart at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy userID từ query string, nếu không có chuyển hướng đến trang login
        HttpSession session = request.getSession();
        Users acc = (Users) session.getAttribute("acc");
        int cartCount = 0;
        if (acc == null) {
            session.removeAttribute("cartCount");
            response.sendRedirect("View/Login/Login.jsp");
        } else {
            // Lưu userID vào session (với kiểu Integer)
            int userID = acc.getUserID();
            request.getSession().setAttribute("userID", userID);
            DAOCart ct = new DAOCart();
            DAOProduct pd = new DAOProduct();
            List<Products> product_List = pd.getAllProducts();
            List<ProductsVariant> variant_List = pd.getAllVariants();
            List<Cart> carts = ct.getCartItems(userID);
            cartCount = ct.countCartItems(userID);
            session.setAttribute("cartCount", cartCount);
            request.setAttribute("Carts", carts);
            request.setAttribute("Products", product_List);
            request.setAttribute("variant", variant_List);
            request.getRequestDispatcher("View/Cart/Cart.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users acc = (Users) session.getAttribute("acc");
        
        // Debug logging
        System.out.println("=== CartPage doPost Debug ===");
        System.out.println("Session ID: " + (session != null ? session.getId() : "null"));
        System.out.println("User acc: " + (acc != null ? acc.getUsername() : "null"));
        System.out.println("Action parameter: " + request.getParameter("action"));
        System.out.println("CartID parameter: " + request.getParameter("cartID"));
        System.out.println("Quantity parameter: " + request.getParameter("quantity"));
        System.out.println("CartIDs parameter: " + request.getParameterValues("cartIDs"));
        
        if (acc == null) {
            System.out.println("User not logged in - returning login redirect");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"message\": \"Please login to manage cart\", \"redirect\": \"" + request.getContextPath() + "/View/Login/Login.jsp?error=Please login to manage cart\"}");
            return;
        }
        
        // Set response content type cho tất cả actions
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        DAOCart ct = new DAOCart();
        try {
              if ("update".equals(action)) {
                System.out.println("Processing UPDATE action");
                int cartID = Integer.parseInt(request.getParameter("cartID"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                System.out.println("Updating cartID: " + cartID + " with quantity: " + quantity);
                ct.updateCartItem(cartID, quantity);
                System.out.println("Update successful");
                response.getWriter().write("{\"success\": true}");
            } else if ("delete".equals(action)) {
                System.out.println("Processing DELETE action");
                int cartID = Integer.parseInt(request.getParameter("cartID"));
                System.out.println("Deleting cartID: " + cartID);
                ct.deleteCartItem(cartID);
                System.out.println("Delete successful");
                response.getWriter().write("{\"success\": true}");
            } else if ("deleteMultiple".equals(action)) {
                System.out.println("Processing DELETE MULTIPLE action");
                String[] cartIDs = request.getParameterValues("cartIDs");
                System.out.println("Deleting cartIDs: " + java.util.Arrays.toString(cartIDs));
                for (String id : cartIDs) {
                    int cartID = Integer.parseInt(id);
                    System.out.println("Deleting cartID: " + cartID);
                    ct.deleteCartItem(cartID);
                }
                System.out.println("Delete multiple successful");
                response.getWriter().write("{\"success\": true}");
            } else {
                System.out.println("Unknown action: " + action);
                response.getWriter().write("{\"success\": false, \"message\": \"Unknown action: " + action + "\"}");
            }
        } catch (Exception e) {
            System.out.println("Exception occurred: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"An error occurred. Please try again!\"}");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
