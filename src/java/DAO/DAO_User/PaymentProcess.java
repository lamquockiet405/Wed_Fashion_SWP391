/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.DAO_User;

import DAO.DAO;
import Model.Payment;
import java.sql.*;

/**
 *
 * @author lenovo
 */
public class PaymentProcess extends DAO{
    public static PaymentProcess INSTACNCE = new PaymentProcess();
    private PaymentProcess() {}

    public Payment getPaymentByName(String paymentMethod) {
        Payment payment = null;
        if (paymentMethod != null && !paymentMethod.isBlank()) {
            String sql = "select * from [Payment] where [PaymentMethod] = ?";
            try {
                PreparedStatement ps = this.conn.prepareStatement(sql);
                ps.setString(1, paymentMethod);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    payment = new Payment();
                    payment.setPaymentID(rs.getInt("PaymentID"));
                    payment.setPaymentMethod(rs.getString("PaymentMethod"));
                    payment.setStatus(rs.getInt("status"));
                }
            } catch (Exception e) {
                this.status = e.getMessage();
            }
        }
        return payment;
    }
    public static void main(String[] args) {
        System.out.println(PaymentProcess.INSTACNCE.getPaymentByName("123"));
    }
}
