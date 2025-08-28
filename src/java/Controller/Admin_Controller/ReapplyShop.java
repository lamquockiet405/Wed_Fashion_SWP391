package Controller.Admin_Controller;

import DAO.DAO_User.DAOUsers;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ReapplyShop", urlPatterns = {"/reapply_shop"})
public class ReapplyShop extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users acc = (Users) session.getAttribute("acc");
        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String shopIdStr = request.getParameter("shopId");
        try {
            int shopId = Integer.parseInt(shopIdStr);
            boolean ok = new DAOUsers().resubmitRejectedShop(shopId);
            if (ok) {
                request.setAttribute("message", "Your shop request has been resubmitted and is pending review.");
            } else {
                request.setAttribute("message", "Could not resubmit your shop request. Please contact support.");
            }
        } catch (Exception e) {
            request.setAttribute("message", "Invalid request. Please try again later.");
        }
        request.getRequestDispatcher("/View/ShopRejected.jsp").forward(request, response);
    }
}


