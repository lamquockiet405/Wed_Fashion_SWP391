/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.User_Controller;

import DAO.DAO_User.DAOUserChangePassword;
import Model.Forgotpassword.MaHoa;
import Model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author lenovo
 */
@WebServlet(name = "change-pass-information", value = "/change-pass-information")
public class ChangePassInformation extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("View/UserPage/user/profile/ChangePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users acc = (Users) session.getAttribute("acc");
        int userId = acc.getUserID();
        MaHoa ma = new MaHoa();
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        // Kiểm tra mật khẩu hiện tại và thực hiện thay đổi mật khẩu
        DAOUserChangePassword uDAO = new DAOUserChangePassword();

        if (uDAO.checkCurrentPassword(userId, ma.toSHA1(currentPassword))) {
            uDAO.changePassword(ma.toSHA1(newPassword), userId);
            request.setAttribute("errorMessage", "You have changed your password successfully!");
            request.getRequestDispatcher("View/UserPage/user/profile/ChangePassword.jsp").forward(request, response);

        } else {
            request.setAttribute("errorMessage", "Current password is incorrect!.");
            request.getRequestDispatcher("View/UserPage/user/profile/ChangePassword.jsp").forward(request, response);

        }
    }
}
