/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.Chinh;

/**
 *
 * @author Dell
 */
public class Cart {
    private int CartID;
    private int UserID;
    private int ProductVariantID;
    private int Quantity;

    public Cart() {
    }

    public Cart( int UserID, int ProductVariantID, int Quantity) {
        this.UserID = UserID;
        this.ProductVariantID = ProductVariantID;
        this.Quantity = Quantity;
    }

    public Cart(int CartID, int UserID, int ProductVariantID, int Quantity) {
        this.CartID = CartID;
        this.UserID = UserID;
        this.ProductVariantID = ProductVariantID;
        this.Quantity = Quantity;
    }

    public int getCartID() {
        return CartID;
    }

    public void setCartID(int CartID) {
        this.CartID = CartID;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
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
    
    
}
