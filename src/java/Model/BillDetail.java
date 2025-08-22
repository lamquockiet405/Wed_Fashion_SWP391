/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author lenovo
 */
public class BillDetail {
    int BillDetailsID;
    String ProductVariantName;
    String ProductVariantImage;
    int Quantity;
    float Price;
    int BillID;
    int status;
    int orderItemId;

    public BillDetail() {
    }

    public BillDetail(int BillDetailsID, String ProductVariantName, String ProductVariantImage, int Quantity, float Price, int BillID) {
        this.BillDetailsID = BillDetailsID;
        this.ProductVariantName = ProductVariantName;
        this.ProductVariantImage = ProductVariantImage;
        this.Quantity = Quantity;
        this.Price = Price;
        this.BillID = BillID;
    }

    public BillDetail(int BillDetailsID, String ProductVariantName, String ProductVariantImage, int Quantity, float Price, int BillID, int status, int orderItemId) {
        this.BillDetailsID = BillDetailsID;
        this.ProductVariantName = ProductVariantName;
        this.ProductVariantImage = ProductVariantImage;
        this.Quantity = Quantity;
        this.Price = Price;
        this.BillID = BillID;
        this.status = status;
        this.orderItemId = orderItemId;
    }
    
    

    public int getBillDetailsID() {
        return BillDetailsID;
    }

    public void setBillDetailsID(int BillDetailsID) {
        this.BillDetailsID = BillDetailsID;
    }

    public String getProductVariantName() {
        return ProductVariantName;
    }

    public void setProductVariantName(String ProductVariantName) {
        this.ProductVariantName = ProductVariantName;
    }

    public String getProductVariantImage() {
        return ProductVariantImage;
    }

    public void setProductVariantImage(String ProductVariantImage) {
        this.ProductVariantImage = ProductVariantImage;
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

    public int getBillID() {
        return BillID;
    }

    public void setBillID(int BillID) {
        this.BillID = BillID;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    @Override
    public String toString() {
        return "BillDetail{" + "BillDetailsID=" + BillDetailsID + ", ProductVariantName=" + ProductVariantName + ", ProductVariantImage=" + ProductVariantImage + ", Quantity=" + Quantity + ", Price=" + Price + ", BillID=" + BillID + ", status=" + status + ", orderItemId=" + orderItemId + '}';
    }

    
    
}
