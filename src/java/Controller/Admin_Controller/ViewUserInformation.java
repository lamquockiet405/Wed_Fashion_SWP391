/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin_Controller;

import DAO.DAO_Customer.DAOCustomer;
import Model.Admin;
import Model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ViewUserInformation", urlPatterns = {"/ViewUserInformation"})
public class ViewUserInformation extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            response.sendRedirect("ErrorPage.jsp");
            return;
        }
        String idParam = request.getParameter("userID");
        if (idParam == null || idParam.isEmpty()) {
            idParam = request.getParameter("userId");
        }
        int customerId;
        try {
            customerId = Integer.parseInt(idParam);
        } catch (Exception e) {
            response.sendRedirect("ManagerUserURL");
            return;
        }
        DAOCustomer daoCustomer = new DAOCustomer();
        Customer customer = daoCustomer.getCustomerById(customerId);
        if (customer == null) {
            response.sendRedirect("ManagerUserURL");
            return;
        }
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/View/AdminPage/UserDetail.jsp").forward(request, response);
    }
}
