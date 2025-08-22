/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author lenovo
 */
public class TotalOrderItemsByProduct {
    private int ProductID;
    private String ProductName;
    private int quantity;
    
    public TotalOrderItemsByProduct() {
}

    public TotalOrderItemsByProduct(int ProductID, String ProductName, int quantity) {
        this.ProductID = ProductID;
        this.ProductName = ProductName;
        this.quantity = quantity;
    }

    public int getProductID() {
        return ProductID;
    }

    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    public String getProductName() {
        return ProductName;
    }

    public void setProductName(String ProductName) {
        this.ProductName = ProductName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "TotalOrderItemsByProduct{" + "ProductID=" + ProductID + ", ProductName=" + ProductName + ", quantity=" + quantity + '}';
    }
    
    
}
