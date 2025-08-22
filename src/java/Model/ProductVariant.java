/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

public class ProductVariant {
    private int productVariantId;
    private String productVariantName;
    private int productId;
    private float price;
    private int stockQuantity;
    private String image;
    private int status;
    
    public ProductVariant() {
    }

    public ProductVariant(int productVariantId, String productVariantName, int productId, float price, int stockQuantity, String image, int status) {
        this.productVariantId = productVariantId;
        this.productVariantName = productVariantName;
        this.productId = productId;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.image = image;
        this.status = status;
    }
    
    public ProductVariant(int productVariantId, String productVariantName, int productId, float price, int stockQuantity, String image) {
        this.productVariantId = productVariantId;
        this.productVariantName = productVariantName;
        this.productId = productId;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.image = image;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    public int getProductVariantId() {
        return productVariantId;
    }

    public void setProductVariantId(int productVariantId) {
        this.productVariantId = productVariantId;
    }

    public String getProductVariantName() {
        return productVariantName;
    }

    public void setProductVariantName(String productVariantName) {
        this.productVariantName = productVariantName;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }



    @Override
    public String toString() {
        return "ProductVariant{" + "productVariantId=" + productVariantId + ", productVariantName=" + productVariantName + ", productId=" + productId + ", price=" + price + ", stockQuantity=" + stockQuantity + ", image=" + image + '}';
    }
}
