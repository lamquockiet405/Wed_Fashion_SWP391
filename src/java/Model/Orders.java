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
public class Orders {
    int OrderID;
    int UserID;
    Date OrderDate;
    float TotalAmount;
    String Status;
    String ShippingAddress;
    String PaymentMethod;

    public Orders() {
    }

    public Orders(int OrderID, int UserID, Date OrderDate, float TotalAmount, String Status, String ShippingAddress, String PaymentMethod) {
        this.OrderID = OrderID;
        this.UserID = UserID;
        this.OrderDate = OrderDate;
        this.TotalAmount = TotalAmount;
        this.Status = Status;
        this.ShippingAddress = ShippingAddress;
        this.PaymentMethod = PaymentMethod;
    }

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
    }

    public Date getOrderDate() {
        return OrderDate;
    }

    public void setOrderDate(Date OrderDate) {
        this.OrderDate = OrderDate;
    }

    public float getTotalAmount() {
        return TotalAmount;
    }

    public void setTotalAmount(float TotalAmount) {
        this.TotalAmount = TotalAmount;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public String getShippingAddress() {
        return ShippingAddress;
    }

    public void setShippingAddress(String ShippingAddress) {
        this.ShippingAddress = ShippingAddress;
    }

    public String getPaymentMethod() {
        return PaymentMethod;
    }

    public void setPaymentMethod(String PaymentMethod) {
        this.PaymentMethod = PaymentMethod;
    }

    @Override
    public String toString() {
        return "Orders{" + "OrderID=" + OrderID + ", UserID=" + UserID + ", OrderDate=" + OrderDate + ", TotalAmount=" + TotalAmount + ", Status=" + Status + ", ShippingAddress=" + ShippingAddress + ", PaymentMethod=" + PaymentMethod + '}';
    }
    
}
