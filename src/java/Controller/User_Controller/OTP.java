package Controller.User_Controller;

import DAO.DAO_User.DAOForgotPassword;
import DAO.DAO_User.DAOUsers;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;


/**
 * OTPServlet processes OTP verification requests.
 */
public class OTP extends HttpServlet {

    /**
     * Handles the HTTP GET method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to OTP page
        request.getRequestDispatcher("View/ForgotPassword/OTP.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP POST method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String otpEntered = request.getParameter("otp").trim();
    HttpSession session = request.getSession();
    String otpSession = (String) session.getAttribute("passGen");
    String email = (String) session.getAttribute("email");

    response.setContentType("application/json");
    PrintWriter out = response.getWriter();

    if (otpSession != null && otpSession.equals(otpEntered) && email != null) {
        DAOForgotPassword dao = new DAOForgotPassword();
        Users u = dao.getUserByEmail(email);
        
        out.println("{\"success\":true, \"redirect\":\"View/ForgotPassword/newPassword.jsp\"}");
    } else {
        out.println("{\"success\":false, \"error\":\"Invalid OTP. Please try again.\"}");
    }
    out.flush();
}


    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet for handling OTP verification";
    }

}
