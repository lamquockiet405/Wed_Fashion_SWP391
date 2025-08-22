/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.Chinh;

/**
 *
 * @author Dell
 */
public class MinMaxPrice {
    private int productID;
    private float priceMin;
    private float priceMax;

    public MinMaxPrice() {
    }

    public MinMaxPrice(int productID, float priceMin, float priceMax) {
        this.productID = productID;
        this.priceMin = priceMin;
        this.priceMax = priceMax;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public float getPriceMin() {
        return priceMin;
    }

    public void setPriceMin(float priceMin) {
        this.priceMin = priceMin;
    }

    public float getPriceMax() {
        return priceMax;
    }

    public void setPriceMax(float priceMax) {
        this.priceMax = priceMax;
    }

    
    
    
}
