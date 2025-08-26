/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.User_Controller;

import DAO.DAO_User.DAOForgotPassword;
import com.google.gson.Gson;
import DAO.DAO_User.DAOUsers;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.Random;
import java.util.concurrent.TimeUnit;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import Model.Forgotpassword.SessionManager;

/**
 *
 * @author Dell
 */
public class ForgotPassword extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("View/ForgotPassword/forgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String mess= "Success" ;
            HttpSession otp = request.getSession(); 
            request.getSession().removeAttribute("otp");
            otp.removeAttribute("otp");
            otp.setMaxInactiveInterval(60);
            DAOForgotPassword dao = new DAOForgotPassword();
            if (email != null && !email.equals("")) {
                if (!dao.checkUserbyEmail(email)) {
                    mess = "Account does not exist";
                } else {
                    mess = "Success";
                    // Gửi email
                    String passGen = generateRandomPassword(6);
                    String subject = "Hello!";
                    String body = "Your OTP is: " + passGen + "\nNote: The OTP is valid for only  1 minute and 30 seconds.";

                    try {
                        sendEmail(email, subject, body);
                        otp.setAttribute("passGen", passGen);
                        otp.setAttribute("email", email);
                        SessionManager.scheduleSessionExpiry(otp, 1, TimeUnit.MINUTES);

                    } catch (MessagingException e) {
                        mess = "Failed to send email";
                    }
                }

            }

            // Thiết lập loại nội dung và mã hóa
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            // Tạo đối tượng PrintWriter sau khi thiết lập loại nội dung và mã hóa
            PrintWriter out = response.getWriter();

            // Viết phản hồi JSON cho client
            String jsonResponse = String.format("{\"mess\":\"%s\"}", mess);
            out.write(jsonResponse);

            // Đảm bảo đóng PrintWriter
            out.flush();
            out.close();

        
    }

    private String generateRandomPassword(int length) {
        String characters = "0123456789";
        Random rand = new Random();
        StringBuilder password = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            password.append(characters.charAt(rand.nextInt(characters.length())));
        }
        return password.toString();
    }

    public static void sendEmail(String to, String subject, String body) throws MessagingException {
        final String from = "chinhdqhe171746@fpt.edu.vn"; // Địa chỉ email người gửi
        final String password = "kmep pyan qact mlqv"; // Mật khẩu email người gửi

        // Cấu hình các thuộc tính của mail server
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");

        // Tạo phiên làm việc với thông tin xác thực
        Session session = Session.getDefaultInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        // Tạo đối tượng MimeMessage để gửi email
        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject(subject);
        message.setText(body);

        // Gửi email
        try (Transport transport = session.getTransport("smtp")) {
            transport.connect();
            transport.sendMessage(message, message.getAllRecipients());
        }
    }
}
