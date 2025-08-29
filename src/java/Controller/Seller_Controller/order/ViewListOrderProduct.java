/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Seller_Controller.order;

import DAO.DAO_Seller.order.OrderItemProcess;
import DAO.DAO_User.DAOUsers;
import Model.OrderView;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ViewListOrderProduct", urlPatterns = {"/manager_view_list_order"})
public class ViewListOrderProduct extends HttpServlet {

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //check loggin
        Users user = (Users) request.getSession().getAttribute("acc");
        if (user == null || !user.getUserRole().equalsIgnoreCase("seller")) {
            response.sendRedirect(request.getContextPath() + "/LogOutController");
            return;
        }
        Integer sellerId = (Integer) request.getSession().getAttribute("sellerId");
        if (sellerId == null) {
            // Fallback: derive sellerId from email
            DAOUsers daoUsers = new DAOUsers();
            sellerId = daoUsers.getSellerIdByEmail(user.getEmail());
            if (sellerId == null) {
                request.setAttribute("error", "Cannot determine seller account. Please re-login as seller.");
                request.getRequestDispatcher("/View/SellerPage/order/viewListOrder.jsp").forward(request, response);
                return;
            }
            request.getSession().setAttribute("sellerId", sellerId);
        }

        int pageSize = 10;
        int page = getCurrentPage(request);

        String otype = request.getParameter("otype") == null ? "wait" : request.getParameter("otype");
        String status = otype.equals("accept") ? "1" : otype.equals("non-accept") ? "0" : otype.equals("wait") ? "2" : null;
        String search = request.getParameter("search") != null ? request.getParameter("search").trim().replaceAll("\\s+", " ") : request.getParameter("search");
        String sort = request.getParameter("sort") == null ? "ASC" : request.getParameter("sort");

        int totalPage = OrderItemProcess.INSTANCE.getTotalPage(pageSize, status, search, sort, sellerId);
        List<OrderView> orderItemList = OrderItemProcess.INSTANCE.getOrderItemByPage(page, pageSize, status, search, sort, sellerId);

        request.setAttribute("sort", sort);
        request.setAttribute("otype", otype);
        request.setAttribute("search", search);
        request.setAttribute("totalPages", totalPage);
        request.setAttribute("orderItemList", orderItemList);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("View/SellerPage/order/viewListOrder.jsp").forward(request, response);
    }
}
