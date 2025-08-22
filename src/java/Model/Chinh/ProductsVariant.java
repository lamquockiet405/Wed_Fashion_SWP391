/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.Chinh;

/**
 *
 * @author Dell
 */
public class ProductsVariant {
    private int ProductVariantID;
    private String ProductVariantName;
    private int ProductID;
    private float Price;
    private int StockQuantity;
    private String Image;

    public ProductsVariant() {
    }

    public ProductsVariant(int ProductVariantID, String ProductVariantName, int ProductID, float Price, int StockQuantity, String Image) {
        this.ProductVariantID = ProductVariantID;
        this.ProductVariantName = ProductVariantName;
        this.ProductID = ProductID;
        this.Price = Price;
        this.StockQuantity = StockQuantity;
        this.Image = Image;
    }

    public int getProductVariantID() {
        return ProductVariantID;
    }

    public void setProductVariantID(int ProductVariantID) {
        this.ProductVariantID = ProductVariantID;
    }

    public String getProductVariantName() {
        return ProductVariantName;
    }

    public void setProductVariantName(String ProductVariantName) {
        this.ProductVariantName = ProductVariantName;
    }

    public int getProductID() {
        return ProductID;
    }

    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    public float getPrice() {
        return Price;
    }

    public void setPrice(float Price) {
        this.Price = Price;
    }

    public int getStockQuantity() {
        return StockQuantity;
    }

    public void setStockQuantity(int StockQuantity) {
        this.StockQuantity = StockQuantity;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    
    
}
