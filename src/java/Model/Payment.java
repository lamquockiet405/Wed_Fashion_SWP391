/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author lenovo
 */
public class Payment {
    int PaymentID;
    String PaymentMethod;
    int status;

    public Payment() {
    }

    public Payment(int PaymentID, String PaymentMethod, int status) {
        this.PaymentID = PaymentID;
        this.PaymentMethod = PaymentMethod;
        this.status = status;
    }

    public int getPaymentID() {
        return PaymentID;
    }

    public void setPaymentID(int PaymentID) {
        this.PaymentID = PaymentID;
    }

    public String getPaymentMethod() {
        return PaymentMethod;
    }

    public void setPaymentMethod(String PaymentMethod) {
        this.PaymentMethod = PaymentMethod;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Payment{" + "PaymentID=" + PaymentID + ", PaymentMethod=" + PaymentMethod + ", status=" + status + '}';
    }
    
    
}
