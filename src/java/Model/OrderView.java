package Model;

import java.util.Date;

public class OrderView {
    private int userId, productId, productVariantId, orderId, orderItemId, statusOrderItem, quantityTotal;
    private String customerName, productName, productVariantName;
    private String customerEmail, customerPhone, customerAddress;
    private Date dateAdd;

    public OrderView() {
    }

    public OrderView(int userId, int productId, int productVariantId, int orderId, int orderItemId, int statusOrderItem, int quantityTotal, String customerName, String productName, String productVariantName, Date dateAdd) {
        this.userId = userId;
        this.productId = productId;
        this.productVariantId = productVariantId;
        this.orderId = orderId;
        this.orderItemId = orderItemId;
        this.statusOrderItem = statusOrderItem;
        this.quantityTotal = quantityTotal;
        this.customerName = customerName;
        this.productName = productName;
        this.productVariantName = productVariantName;
        this.dateAdd = dateAdd;
    }

    // Constructor mới với thông tin khách hàng đầy đủ
    public OrderView(int userId, int productId, int productVariantId, int orderId, int orderItemId, int statusOrderItem, int quantityTotal, String customerName, String productName, String productVariantName, Date dateAdd, String customerEmail, String customerPhone, String customerAddress) {
        this.userId = userId;
        this.productId = productId;
        this.productVariantId = productVariantId;
        this.orderId = orderId;
        this.orderItemId = orderItemId;
        this.statusOrderItem = statusOrderItem;
        this.quantityTotal = quantityTotal;
        this.customerName = customerName;
        this.productName = productName;
        this.productVariantName = productVariantName;
        this.dateAdd = dateAdd;
        this.customerEmail = customerEmail;
        this.customerPhone = customerPhone;
        this.customerAddress = customerAddress;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getProductVariantId() {
        return productVariantId;
    }

    public void setProductVariantId(int productVariantId) {
        this.productVariantId = productVariantId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public int getStatusOrderItem() {
        return statusOrderItem;
    }

    public void setStatusOrderItem(int statusOrderItem) {
        this.statusOrderItem = statusOrderItem;
    }

    public int getQuantityTotal() {
        return quantityTotal;
    }

    public void setQuantityTotal(int quantityTotal) {
        this.quantityTotal = quantityTotal;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductVariantName() {
        return productVariantName;
    }

    public void setProductVariantName(String productVariantName) {
        this.productVariantName = productVariantName;
    }

    public Date getDateAdd() {
        return dateAdd;
    }

    public void setDateAdd(Date dateAdd) {
        this.dateAdd = dateAdd;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }

    @Override
    public String toString() {
        return "OrderView{" + "userId=" + userId + ", productId=" + productId + ", productVariantId=" + productVariantId + ", orderId=" + orderId + ", orderItemId=" + orderItemId + ", statusOrderItem=" + statusOrderItem + ", quantityTotal=" + quantityTotal + ", customerName=" + customerName + ", productName=" + productName + ", productVariantName=" + productVariantName + ", dateAdd=" + dateAdd + ", customerEmail=" + customerEmail + ", customerPhone=" + customerPhone + ", customerAddress=" + customerAddress + '}';
    }
}
