/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin_Controller;

import DAO.DAO_Admin.DAOAdmin;
import Model.Admin;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author lenovo
 */
@WebServlet(name = "ApproveShop", urlPatterns = {"/ApproveShop"})
public class ApproveShop extends HttpServlet {

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
            HttpSession session = request.getSession();
            Admin admin = (Admin) session.getAttribute("admin");
            
            // Kiểm tra quyền Admin
            if (admin == null) {
                response.sendRedirect("ErrorPage.jsp");
                return;
            }
            
            // Lấy thông tin từ request
            int shopId = Integer.parseInt(request.getParameter("shopId"));
            String action = request.getParameter("action"); // approve hoặc reject
            String adminNotes = request.getParameter("adminNotes");
            
            DAOAdmin dao = new DAOAdmin();
            boolean success = false;
            
            if ("approve".equals(action)) {
                // Duyệt shop
                success = dao.approveShop(shopId, "Approved", adminNotes);
                
                if (success) {
                    // Lấy thông tin shop để cập nhật role user
                    // Shops shop = dao.getShopById(shopId); // This line was removed as per the new_code
                    // if (shop != null) { // This line was removed as per the new_code
                    //     dao.updateUserRoleToSeller(shop.getUserId()); // This line was removed as per the new_code
                    // } // This line was removed as per the new_code
                    request.setAttribute("message", "Shop đã được duyệt thành công!");
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra khi duyệt shop!");
                }
            } else if ("reject".equals(action)) {
                // Từ chối shop
                success = dao.approveShop(shopId, "Rejected", adminNotes);
                
                if (success) {
                    request.setAttribute("message", "Shop đã bị từ chối!");
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra khi từ chối shop!");
                }
            }
            
            // Redirect về trang quản lý shop
            response.sendRedirect("ManageShopURL");
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
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            response.sendRedirect("ErrorPage.jsp");
            return;
        }
        int shopId = Integer.parseInt(request.getParameter("shopId"));
        String action = request.getParameter("action"); // approve | reject
        String adminNotes = request.getParameter("adminNotes");

        DAOAdmin dao = new DAOAdmin();
        boolean ok;
        if ("approve".equalsIgnoreCase(action)) {
            ok = dao.approveShopWithAdmin(shopId, admin.getAdminId(), true, adminNotes);
        } else {
            ok = dao.approveShopWithAdmin(shopId, admin.getAdminId(), false, adminNotes);
        }
        response.sendRedirect("ManageShopURL");
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
