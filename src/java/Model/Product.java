/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

public class Product {
    private int productId;
    private String productName, description;
    private int status, categoryId, shopId;
    private Date createdAt;

    public Product() {
    }

    public Product(int productId, String productName, String description, int status, int categoryId, int shopId, Date createdAt) {
        this.productId = productId;
        this.productName = productName;
        this.description = description;
        this.status = status;
        this.categoryId = categoryId;
        this.shopId = shopId;
        this.createdAt = createdAt;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setShopId(int shopId) {
        this.shopId = shopId;
    }

    public int getShopId() {
        return shopId;
    }
    
    public int getStatus() {
        return status;
    }
    
    public int getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public String getDescription() {
        return description;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    @Override
    public String toString() {
        return "Product{" + "productId=" + productId + ", productName=" + productName + ", description=" + description + ", categoryId=" + categoryId + ", createdAt=" + createdAt + '}';
    }
    
}
