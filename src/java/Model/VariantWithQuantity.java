/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author lenovo
 */
public class VariantWithQuantity {
    private ProductsVariant variant;
    private int quantity;

    public VariantWithQuantity() {
    }
    

    public VariantWithQuantity(ProductsVariant variant, int quantity) {
        this.variant = variant;
        this.quantity = quantity;
    }

    public ProductsVariant getVariant() {
        return variant;
    }

    public int getQuantity() {
        return quantity;
    }

    @Override
    public String toString() {
        return "VariantWithQuantity{" + "variant=" + variant + ", quantity=" + quantity + '}';
    }
    
}
