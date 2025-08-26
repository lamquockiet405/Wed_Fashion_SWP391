/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.User_Controller;

import DAO.DAO_Customer.DAOOrder_c;
import Model.Bill;
import Model.BillDetail;
import Model.Orders;
import Model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 *
 * @author Dell
 */
@WebServlet(name = "ViewOrderList", urlPatterns = {"/view_order_list"})
public class ViewOrderList extends HttpServlet {

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
            out.println("<title>Servlet ViewOrderList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewOrderList at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        DAOOrder_c oc = new DAOOrder_c();

        String priceFilter = request.getParameter("priceFilter");
        String search = request.getParameter("search");

        if (priceFilter == null || (!priceFilter.equals("min") && !priceFilter.equals("max"))) {
            priceFilter = "";
        }
        Users acc = (Users) session.getAttribute("acc");
        if (acc == null) {
            response.sendRedirect("View/Login/Login.jsp");
            
        }
        int userId = acc.getUserID();
        int pageSize = 4; // Số bill mỗi trang
        int page = 1; // Mặc định là trang 1

        // Lấy tham số page từ request nếu có
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
        }
        if (search != null && !search.isEmpty()) {
            
            List<Bill> bills = oc.getBillsSelectFilter(userId, page, pageSize, priceFilter, search);
            List<BillDetail> bd = oc.getAllBillDetails();
            int totalBills = oc.getTotalBillsFilterByUserId(userId);
            int totalPages = (int) Math.ceil((double) totalBills / pageSize);

            request.setAttribute("bills", bills);
            request.setAttribute("BillDetail", bd);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("View/UserPage/user/profile/ViewOrderList.jsp").forward(request, response);
        } else {
            request.getSession().removeAttribute("search");
            List<Bill> bills = oc.getBillsSelectFilter(userId, page, pageSize, priceFilter);
            List<BillDetail> bd = oc.getAllBillDetails();
            int totalBills = oc.getTotalBillsFilterByUserId(userId);
            int totalPages = (int) Math.ceil((double) totalBills / pageSize);

            request.setAttribute("bills", bills);
            request.setAttribute("BillDetail", bd);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("View/UserPage/user/profile/ViewOrderList.jsp").forward(request, response);
        }

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
        processRequest(request, response);
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
