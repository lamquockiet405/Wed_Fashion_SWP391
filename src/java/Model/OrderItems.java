/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author lenovo
 */
public class OrderItems {
     int OrderItemID;
    int OrderID;
    int ProductVariantID;
    int Quantity;
    float Price;
    int status;
    public OrderItems() {
    }

    public OrderItems(int OrderItemID, int OrderID, int ProductVariantID, int Quantity, float Price, int status) {
        this.OrderItemID = OrderItemID;
        this.OrderID = OrderID;
        this.ProductVariantID = ProductVariantID;
        this.Quantity = Quantity;
        this.Price = Price;
        this.status = status;
    }

    public int getOrderItemID() {
        return OrderItemID;
    }

    public void setOrderItemID(int OrderItemID) {
        this.OrderItemID = OrderItemID;
    }

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public int getProductVariantID() {
        return ProductVariantID;
    }

    public void setProductVariantID(int ProductVariantID) {
        this.ProductVariantID = ProductVariantID;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public float getPrice() {
        return Price;
    }

    public void setPrice(float Price) {
        this.Price = Price;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "OrderItems{" + "OrderItemID=" + OrderItemID + ", OrderID=" + OrderID + ", ProductVariantID=" + ProductVariantID + ", Quantity=" + Quantity + ", Price=" + Price + ", status=" + status + '}';
    }

   
    
}
