package Controller;

import DAO.DAO_Admin.DAOAdmin;
import DAO.DAO_Customer.DAOCustomer;
import DAO.DAO_User.DAOUsers;
import Model.Forgotpassword.MaHoa;
import Model.Admin;
import Model.Customer;
import Model.CustomerAdapter;
import Model.Orders;
import Model.Shops;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

public class LoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        MaHoa ma = new MaHoa();
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        String password = request.getParameter("pass");
        
        DAOCustomer daoCustomer = new DAOCustomer();
        DAOUsers daoUsers = new DAOUsers();
        DAOAdmin daoa = new DAOAdmin();

        // Try customer login first
        Customer customer = daoCustomer.login(email, ma.toSHA1(password));
        Users acc = null;
        
        if (customer != null) {
            acc = new CustomerAdapter(customer);
            session.setAttribute("acc", acc);
            // If email has approved shop, go to seller dashboard
            Shops approvedShop = daoUsers.getApprovedShopByEmail(email);
            if (approvedShop != null) {
                // elevate session role to Seller for gating on seller pages
                acc.setUserRole("Seller");
                session.setAttribute("acc", acc);
                session.setAttribute("sellerId", approvedShop.getUserId());
                session.setAttribute("shop", approvedShop);
                response.sendRedirect(request.getContextPath() + "/view_product");
                return;
            }
        } else {
            // Try admin login
            Admin admin = daoa.loginAdmin(email, ma.toSHA1(password));
            if (admin != null) {
                if (admin.getStatus() != null && (admin.getStatus().equalsIgnoreCase("banned"))) {
                    request.setAttribute("message", "Your Account Has Been Banned");
                    request.getRequestDispatcher("/View/Login/Login.jsp").forward(request, response);
                    return;
                }
                session.setAttribute("admin", admin);
                int totalUsers = daoa.GetTotalUsers();
                int totalOrders = daoa.GetTotalOrder();
                int totalProducts = daoa.GetTotalProducts();
                List<Orders> orderList = daoa.GetOrderList();
                request.setAttribute("totalUsers", totalUsers);
                request.setAttribute("totalOrders", totalOrders);
                request.setAttribute("totalProducts", totalProducts);
                request.setAttribute("orderList", orderList);
                request.getRequestDispatcher("./View/AdminPage/AdminHome.jsp").forward(request, response);
                return;
            }
        }

        if (session.getAttribute("acc") == null && session.getAttribute("admin") == null) {
            request.setAttribute("message", "Wrong User Or Password");
            request.getRequestDispatcher("/View/Login/Login.jsp").forward(request, response);
            return;
        }

        // Customer fallback (no approved shop)
        if (session.getAttribute("acc") != null) {
            acc = (Users) session.getAttribute("acc");
            if (acc.getStatus().equalsIgnoreCase("banned")) {
                request.setAttribute("message", "Your Account Has Been Banned");
                request.getRequestDispatcher("/View/Login/Login.jsp").forward(request, response);
                return;
            }
            session.setAttribute("acc", acc);
            response.sendRedirect(request.getContextPath() + "/homePage");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
