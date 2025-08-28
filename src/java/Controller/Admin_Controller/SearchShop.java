/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin_Controller;

import DAO.DAO_Admin.DAOAdmin;
import Model.Admin;
import Model.Shops;
import Model.Users;
import java.io.IOException;
import java.util.List;
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
@WebServlet(name = "SearchShop", urlPatterns = {"/SearchShop"})
public class SearchShop extends HttpServlet {

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
            String email = request.getParameter("email");
           HttpSession session = request.getSession();
            Users acc = (Users) session.getAttribute("acc");
             if(acc.getUserRole().equals("Admin") && acc != null){
            // Lấy danh sách user từ DAO
            DAO.DAO_Admin.DAOAdmin dao = new DAOAdmin();
            List<Shops> shop = dao.GetShopListByEmail(email);            
            List<Users> user = dao.GetUserList();
           
            request.setAttribute("UserList", user);
            
            request.setAttribute("ShopList", shop);

            // Forward đến trang JSP
            request.getRequestDispatcher("./View/AdminPage/ManageShop.jsp").forward(request, response);
             }
             else{
                 response.sendRedirect("ErrorPage.jsp");
             }
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
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            response.sendRedirect("ErrorPage.jsp");
            return;
        }
        String email = request.getParameter("email");
        DAOAdmin dao = new DAOAdmin();
        List<Shops> shops = dao.GetShopListByEmail(email);
        List<Users> users = dao.GetUserListByEmail(email);
        request.setAttribute("ShopList", shops);
        request.setAttribute("UserList", users);
        request.getRequestDispatcher("./View/AdminPage/ManageShop.jsp").forward(request, response);
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
