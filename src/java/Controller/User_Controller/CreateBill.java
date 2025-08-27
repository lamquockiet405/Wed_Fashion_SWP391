/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.User_Controller;

import DAO.DAO_Customer.DAOCart;
import DAO.DAO_Seller.order.OrderItemProcess;
import DAO.DAO_Seller.order.OrderProcess;
import DAO.DAO_User.DAOUsers;
import DAO.DAO_User.PaymentProcess;
import Model.Payment;
import Model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author lenovo
 */
@WebServlet(name = "CreateBill", urlPatterns = {"/CreateBill"})
public class CreateBill extends HttpServlet {

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
            HttpSession session = request.getSession();
            Users acc = (Users) session.getAttribute("acc");
            
            // Kiểm tra user đã đăng nhập chưa
            if (acc == null) {
                response.sendRedirect(request.getContextPath() + "/View/Login/Login.jsp?error=Please login to place order");
                return;
            }
            
            DAO.DAO_Customer.DAOCart daoc = new DAOCart();
            String username = request.getParameter("username");
            String shippingAddress = request.getParameter("shippingAddress");
            String paymentMethod = request.getParameter("paymentMethod");
            String[] productVariantNames = request.getParameterValues("pvName");
            String[] productVariantImages = request.getParameterValues("pvImage");
            String[] quantities = request.getParameterValues("quantity");
            String[] prices = request.getParameterValues("price");
            String totalAmount = request.getParameter("totalAmount");

            if ( shippingAddress == null) {
                response.sendRedirect(request.getContextPath()+"/GetAddress?error=Please Create Your Shipping Address First!");
                return;
            }
             if (paymentMethod == null) {
                response.sendRedirect(request.getContextPath()+"/GetDataForCheckout?error=missing payment method");
                return;
            }

            DAO.DAO_User.DAOUsers daou = new DAOUsers();

            // create order
            Payment payment = PaymentProcess.INSTACNCE.getPaymentByName(paymentMethod);
            int newOrderId = OrderProcess.INSTANCE.create(acc.getUserID(), Double.parseDouble(totalAmount), "Pending", shippingAddress, payment.getPaymentID());
            // create orderitem

            String[] pvId = request.getParameterValues("pvId");
            List<String> pvIdList = new ArrayList<>();
            pvIdList.addAll(Arrays.asList(pvId));

            List<String> quatityList = new ArrayList<>();
            quatityList.addAll(Arrays.asList(quantities));

            List<String> priceList = new ArrayList<>();
            priceList.addAll(Arrays.asList(prices));
            
            List<Integer> newOrderItemIdList = OrderItemProcess.INSTANCE.create(newOrderId, pvIdList, quatityList, priceList, 2);
            // Tạo Bill mới
            int billId = daou.CreateBill(username, shippingAddress, paymentMethod, Double.parseDouble(totalAmount), acc.getUserID(), newOrderId);
            if (billId == -1) {
                response.sendRedirect(request.getContextPath()+"/GetDataForCheckout?error=insertFail");
                return;
            }
           

            // Thêm thông tin sản phẩm vào BillDetails
            for (int i = 0; i < productVariantNames.length; i++) {
                daou.addBillDetails(billId, productVariantNames[i], productVariantImages[i], Integer.parseInt(quantities[i]), 
                        Double.parseDouble(prices[i]), 2,newOrderItemIdList.get(i));
            }

            List<Integer> selectedCartIds = (List<Integer>) session.getAttribute("selectedCartIds");
            for (Integer id : selectedCartIds) {
                daoc.deleteCartItem(id);
            }
            
            response.sendRedirect(request.getContextPath()+"/homePage?messcreatebill=Checkout Product Successfully");
        } catch (SQLException ex) {
            Logger.getLogger(CreateBill.class.getName()).log(Level.SEVERE, null, ex);
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
