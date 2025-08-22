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
public class Bill {
    int BillID;
    String username;
    Date OrderDate;
    String ShippingAddress;
    int status;
    String PaymentMethod;
    float TotalAmount;
    int userId;
    int orderId;

    public Bill() {
    }

    public Bill(int BillID, String username, Date OrderDate, String ShippingAddress, int status, String PaymentMethod, float TotalAmount, int userId) {
        this.BillID = BillID;
        this.username = username;
        this.OrderDate = OrderDate;
        this.ShippingAddress = ShippingAddress;
        this.status = status;
        this.PaymentMethod = PaymentMethod;
        this.TotalAmount = TotalAmount;
        this.userId = userId;
    }

    public Bill(int BillID, String username, Date OrderDate, String ShippingAddress, int status, String PaymentMethod, float TotalAmount, int userId, int orderId) {
        this.BillID = BillID;
        this.username = username;
        this.OrderDate = OrderDate;
        this.ShippingAddress = ShippingAddress;
        this.status = status;
        this.PaymentMethod = PaymentMethod;
        this.TotalAmount = TotalAmount;
        this.userId = userId;
        this.orderId = orderId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    

    public int getBillID() {
        return BillID;
    }

    public void setBillID(int BillID) {
        this.BillID = BillID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Date getOrderDate() {
        return OrderDate;
    }

    public void setOrderDate(Date OrderDate) {
        this.OrderDate = OrderDate;
    }

    public String getShippingAddress() {
        return ShippingAddress;
    }

    public void setShippingAddress(String ShippingAddress) {
        this.ShippingAddress = ShippingAddress;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getPaymentMethod() {
        return PaymentMethod;
    }

    public void setPaymentMethod(String PaymentMethod) {
        this.PaymentMethod = PaymentMethod;
    }

    public float getTotalAmount() {
        return TotalAmount;
    }

    public void setTotalAmount(float TotalAmount) {
        this.TotalAmount = TotalAmount;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "Bill{" + "BillID=" + BillID + ", username=" + username + ", OrderDate=" + OrderDate + ", ShippingAddress=" + ShippingAddress + ", status=" + status + ", PaymentMethod=" + PaymentMethod + ", TotalAmount=" + TotalAmount + ", userId=" + userId + ", orderId=" + orderId + '}';
    }

    

   
  
}
