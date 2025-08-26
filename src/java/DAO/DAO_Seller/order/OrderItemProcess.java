package DAO.DAO_Seller.order;

import DAO.DAO_Seller.productvariant.ProductVariantProcess;
import Model.OrderItems;
import Model.OrderView;
import Model.Orders;
import Model.Product;
import Model.ProductVariant;
import Model.Shop;
import Model.User;
import java.math.BigDecimal;
import java.sql.*;

import java.util.ArrayList;
import java.util.List;

public class OrderItemProcess extends DAO.DAO {

    public static OrderItemProcess INSTANCE = new OrderItemProcess();

    private OrderItemProcess() {
    }

    private int index = 1;

    public int getTotalPage(int pageSize, String status, String search, String sort, int userId) {
        int totalPages = 0;
        int totalRecords = 0;
        StringBuilder countQuery = new StringBuilder(
                "SELECT COUNT(*) "
                        + "FROM [OrderItems] oi "
                        + "JOIN [Orders] o ON oi.OrderID = o.OrderID "
                        + "JOIN [ProductsVariant] pv ON oi.ProductVariantID = pv.ProductVariantID "
                        + "JOIN [Products] p ON pv.ProductID = p.ProductID "
                        + "JOIN [Shops] s ON p.ShopId = s.id "
                        + "JOIN [Customers] c ON o.UserID = c.CustomerID "
                        + "LEFT JOIN [ShippingAddresses] sa ON c.CustomerID = sa.userId AND sa.status = 1 "
                        + "WHERE s.userId = ?");

        if (status != null) {
            countQuery.append(" AND oi.[status] = ?");
        }
        if (search != null) {
            countQuery.append(" AND (CONCAT(c.FirstName, ' ', c.LastName) LIKE ? "
                    + "OR p.ProductName LIKE ? "
                    + "OR CAST(oi.OrderID AS varchar) LIKE ? "
                    + "OR CONVERT(varchar, o.OrderDate, 23) LIKE ? "
                    + "OR c.Email LIKE ? "
                    + "OR c.PhoneNumber LIKE ? "
                    + "OR COALESCE(sa.address, c.Address) LIKE ?)");
        }

        try {
            PreparedStatement countStmt = this.conn.prepareStatement(countQuery.toString());
            int index = 1;

            countStmt.setInt(index++, userId);
            if (status != null) {
                countStmt.setString(index++, status);
            }
            if (search != null) {
                countStmt.setString(index++, "%" + search + "%");
                countStmt.setString(index++, "%" + search + "%");
                countStmt.setString(index++, "%" + search + "%");
                countStmt.setString(index++, "%" + search + "%");
                countStmt.setString(index++, "%" + search + "%");
                countStmt.setString(index++, "%" + search + "%");
                countStmt.setString(index++, "%" + search + "%");
            }

            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalRecords = countRs.getInt(1);
                totalPages = (int) Math.ceil((double) totalRecords / pageSize);
            }

        } catch (SQLException e) {
            this.status = e.getMessage();
        }

        return totalPages;
    }

    public List<OrderView> getOrderItemByPage(int page, int pageSize, String status, String search, String sort, int userId) {
        List<OrderView> orderViewList = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT "
                        + "c.CustomerID AS userId, "
                        + "p.ProductID AS productId, "
                        + "pv.ProductVariantID AS productVariantId, "
                        + "o.OrderID AS orderId, "
                        + "oi.OrderItemID AS orderItemId, "
                        + "oi.status AS statusOrderItem, "
                        + "oi.Quantity AS quantityTotal, "
                        + "CONCAT(c.FirstName, ' ', c.LastName) AS customerName, "
                        + "p.ProductName AS productName, "
                        + "pv.ProductVariantName AS productVariantName, "
                        + "o.OrderDate AS dateAdd, "
                        + "c.Email AS customerEmail, "
                        + "c.PhoneNumber AS customerPhone, "
                        + "COALESCE(sa.address, c.Address) AS customerAddress "
                        + "FROM [OrderItems] oi "
                        + "JOIN [Orders] o ON oi.OrderID = o.OrderID "
                        + "JOIN [ProductsVariant] pv ON oi.ProductVariantID = pv.ProductVariantID "
                        + "JOIN [Products] p ON pv.ProductID = p.ProductID "
                        + "JOIN [Shops] s ON p.ShopId = s.id "
                        + "JOIN [Customers] c ON o.UserID = c.CustomerID "
                        + "LEFT JOIN [ShippingAddresses] sa ON c.CustomerID = sa.userId AND sa.status = 1 "
                        + "WHERE s.userId = ?");

        if (status != null) {
            sql.append(" AND oi.status = ?");
        }
        if (search != null) {
            sql.append(" AND (CONCAT(c.FirstName, ' ', c.LastName) LIKE ? "
                    + "OR p.ProductName LIKE ? OR CAST(oi.OrderID AS varchar) LIKE ? "
                    + "OR CONVERT(varchar, o.OrderDate, 23) LIKE ? "
                    + "OR c.Email LIKE ? "
                    + "OR c.PhoneNumber LIKE ? "
                    + "OR COALESCE(sa.address, c.Address) LIKE ?)");
        }

        sql.append(" ORDER BY oi.OrderItemID ").append(sort);
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try {
            PreparedStatement stmt = this.conn.prepareStatement(sql.toString());
            int index = 1;

            stmt.setInt(index++, userId);
            if (status != null) {
                stmt.setString(index++, status);
            }
            if (search != null) {
                stmt.setString(index++, "%" + search + "%");
                stmt.setString(index++, "%" + search + "%");
                stmt.setString(index++, "%" + search + "%");
                stmt.setString(index++, "%" + search + "%");
                stmt.setString(index++, "%" + search + "%");
                stmt.setString(index++, "%" + search + "%");
                stmt.setString(index++, "%" + search + "%");
            }
            stmt.setInt(index++, (page - 1) * pageSize);
            stmt.setInt(index++, pageSize);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OrderView orderView = new OrderView();
                orderView.setUserId(rs.getInt("userId"));
                orderView.setProductId(rs.getInt("productId"));
                orderView.setProductVariantId(rs.getInt("productVariantId"));
                orderView.setOrderId(rs.getInt("orderId"));
                orderView.setOrderItemId(rs.getInt("orderItemId"));
                orderView.setStatusOrderItem(rs.getInt("statusOrderItem"));
                orderView.setQuantityTotal(rs.getInt("quantityTotal"));
                orderView.setCustomerName(rs.getString("customerName"));
                orderView.setProductName(rs.getString("productName"));
                orderView.setProductVariantName(rs.getString("productVariantName"));
                orderView.setDateAdd(rs.getDate("dateAdd"));
                orderView.setCustomerEmail(rs.getString("customerEmail"));
                orderView.setCustomerPhone(rs.getString("customerPhone"));
                orderView.setCustomerAddress(rs.getString("customerAddress"));

                orderViewList.add(orderView);
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }

        return orderViewList;
    }

    public OrderView getOrderViewByOrderItemId(String orderItemId, int sellerUserId) {
        OrderView orderView = null;
        String sql = "SELECT "
                + "c.CustomerID AS userId, "
                + "p.ProductID AS productId, "
                + "pv.ProductVariantID AS productVariantId, "
                + "o.OrderID AS orderId, "
                + "oi.OrderItemID AS orderItemId, "
                + "oi.status AS statusOrderItem, "
                + "oi.Quantity AS quantityTotal, "
                + "CONCAT(c.FirstName, ' ', c.LastName) AS customerName, "
                + "p.ProductName AS productName, "
                + "pv.ProductVariantName AS productVariantName, "
                + "o.OrderDate AS dateAdd, "
                + "c.Email AS customerEmail, "
                + "c.PhoneNumber AS customerPhone, "
                + "COALESCE(sa.address, c.Address) AS customerAddress "
                + "FROM [OrderItems] oi "
                + "JOIN [Orders] o ON oi.OrderID = o.OrderID "
                + "JOIN [Customers] c ON o.UserID = c.CustomerID "
                + "JOIN [ProductsVariant] pv ON oi.ProductVariantID = pv.ProductVariantID "
                + "JOIN [Products] p ON pv.ProductID = p.ProductID "
                + "JOIN [Shops] s ON p.ShopId = s.id "
                + "LEFT JOIN [ShippingAddresses] sa ON c.CustomerID = sa.userId AND sa.status = 1 "
                + "WHERE s.userId = ? AND oi.OrderItemID = ?";

        try {
            PreparedStatement stmt = this.conn.prepareStatement(sql);
            stmt.setInt(1, sellerUserId);
            stmt.setString(2, orderItemId);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                orderView = new OrderView();
                orderView.setUserId(rs.getInt("userId"));
                orderView.setProductId(rs.getInt("productId"));
                orderView.setProductVariantId(rs.getInt("productVariantId"));
                orderView.setOrderId(rs.getInt("orderId"));
                orderView.setOrderItemId(rs.getInt("orderItemId"));
                orderView.setStatusOrderItem(rs.getInt("statusOrderItem"));
                orderView.setQuantityTotal(rs.getInt("quantityTotal"));
                orderView.setCustomerName(rs.getString("customerName"));
                orderView.setProductName(rs.getString("productName"));
                orderView.setProductVariantName(rs.getString("productVariantName"));
                orderView.setDateAdd(rs.getDate("dateAdd"));
                orderView.setCustomerEmail(rs.getString("customerEmail"));
                orderView.setCustomerPhone(rs.getString("customerPhone"));
                orderView.setCustomerAddress(rs.getString("customerAddress"));
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }

        return orderView;
    }

    /**
     * Method debug để kiểm tra dữ liệu cơ bản
     * @param orderItemId ID của order item
     * @return OrderView object với thông tin cơ bản
     */
    public OrderView getOrderViewDebug(String orderItemId) {
        OrderView orderView = null;
        String sql = "SELECT "
                + "oi.OrderItemID AS orderItemId, "
                + "oi.status AS statusOrderItem, "
                + "oi.Quantity AS quantityTotal, "
                + "o.OrderID AS orderId, "
                + "o.UserID AS customerUserId, "
                + "o.OrderDate AS dateAdd, "
                + "CONCAT(u.FirstName, ' ', u.LastName) AS customerName, "
                + "u.Email AS customerEmail, "
                + "u.PhoneNumber AS customerPhone, "
                + "COALESCE(sa.address, u.Address) AS customerAddress "
                + "FROM [OrderItems] oi "
                + "JOIN [Orders] o ON oi.OrderID = o.OrderID "
                + "JOIN [Users] u ON o.UserID = u.UserID "
                + "LEFT JOIN [ShippingAddresses] sa ON u.UserID = sa.userId AND sa.status = 1 "
                + "WHERE oi.OrderItemID = ?";

        try {
            PreparedStatement stmt = this.conn.prepareStatement(sql);
            stmt.setString(1, orderItemId);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                orderView = new OrderView();
                orderView.setOrderItemId(rs.getInt("orderItemId"));
                orderView.setStatusOrderItem(rs.getInt("statusOrderItem"));
                orderView.setQuantityTotal(rs.getInt("quantityTotal"));
                orderView.setOrderId(rs.getInt("orderId"));
                orderView.setUserId(rs.getInt("customerUserId"));
                orderView.setDateAdd(rs.getDate("dateAdd"));
                
                // Lấy thông tin khách hàng thực từ database
                orderView.setCustomerName(rs.getString("customerName"));
                orderView.setCustomerEmail(rs.getString("customerEmail"));
                orderView.setCustomerPhone(rs.getString("customerPhone"));
                orderView.setCustomerAddress(rs.getString("customerAddress"));
                
                // Set các giá trị mặc định cho các trường khác
                orderView.setProductId(0);
                orderView.setProductVariantId(0);
                orderView.setProductName("N/A");
                orderView.setProductVariantName("N/A");
                
                System.out.println("Debug: Found order item - OrderItemID: " + rs.getInt("orderItemId") 
                    + ", OrderID: " + rs.getInt("orderId") 
                    + ", CustomerUserID: " + rs.getInt("customerUserId")
                    + ", CustomerName: " + rs.getString("customerName"));
            } else {
                System.out.println("Debug: No order item found with OrderItemID: " + orderItemId);
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
            System.out.println("SQL Error in getOrderViewDebug: " + e.getMessage());
        }

        return orderView;
    }

    /**
     * Method test đơn giản để kiểm tra việc lấy tên khách hàng
     * @param orderItemId ID của order item
     * @return OrderView object với thông tin cơ bản
     */
    public OrderView getCustomerNameSimple(String orderItemId) {
        OrderView orderView = null;
        String sql = "SELECT "
                + "oi.OrderItemID AS orderItemId, "
                + "o.UserID AS customerUserId, "
                + "CONCAT(u.FirstName, ' ', u.LastName) AS customerName, "
                + "u.Email AS customerEmail, "
                + "u.PhoneNumber AS customerPhone, "
                + "u.Address AS customerAddress "
                + "FROM [OrderItems] oi "
                + "JOIN [Orders] o ON oi.OrderID = o.OrderID "
                + "JOIN [Users] u ON o.UserID = u.UserID "
                + "WHERE oi.OrderItemID = ?";

        try {
            PreparedStatement stmt = this.conn.prepareStatement(sql);
            stmt.setString(1, orderItemId);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                orderView = new OrderView();
                orderView.setOrderItemId(rs.getInt("orderItemId"));
                orderView.setUserId(rs.getInt("customerUserId"));
                orderView.setCustomerName(rs.getString("customerName"));
                orderView.setCustomerEmail(rs.getString("customerEmail"));
                orderView.setCustomerPhone(rs.getString("customerPhone"));
                orderView.setCustomerAddress(rs.getString("customerAddress"));
                
                // Set các giá trị mặc định
                orderView.setProductId(0);
                orderView.setProductVariantId(0);
                orderView.setOrderId(0);
                orderView.setStatusOrderItem(0);
                orderView.setQuantityTotal(0);
                orderView.setProductName("N/A");
                orderView.setProductVariantName("N/A");
                orderView.setDateAdd(new java.util.Date());
                
                System.out.println("Simple method: Customer found - Name: " + rs.getString("customerName") 
                    + ", Email: " + rs.getString("customerEmail")
                    + ", Phone: " + rs.getString("customerPhone"));
            } else {
                System.out.println("Simple method: No customer found for OrderItemID: " + orderItemId);
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
            System.out.println("SQL Error in getCustomerNameSimple: " + e.getMessage());
        }

        return orderView;
    }

    public static void main(String[] args) {
        for (OrderView ov : OrderItemProcess.INSTANCE.getOrderItemByPage(1, 10, null, null, "asc", 1)) {
            System.out.println(ov.toString());
        }
    }

    /**
     * change status product, if status product is 0 => change to reject status
     * product is 1 => check quantity product variant after change status order
     * item and subtraction quantity product variant
     *
     * @param status status order item 0 is non-accept, 1 is accept and 2 is
     * waiting
     * @param orderItemId order item need to change
     */
    public void changeStatus(String status, String orderItemId) {
        OrderItems orderItems = getOrderItemById(orderItemId);
        orderItems.setStatus(Integer.parseInt(status));
        // update to reject
        if (status.equals("0")) {
            if (!updateStatusProduct(orderItems)) {
                throw new IllegalArgumentException("The system error.");
            }
        } else if (status.equals("1")) { // accept and sub product variant 
            try {
                accept(orderItems);
            } catch (SQLException sql) {
                throw new IllegalArgumentException(sql.getMessage());
            }
        }
    }

    public OrderItems getOrderItemById(String orderItemId) {
        OrderItems orderItems = null;
        String sql = "select * from [OrderItems] where [OrderItemID] = ?";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setString(1, orderItemId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orderItems = new OrderItems();
                orderItems.setOrderItemID(rs.getInt("OrderItemID"));
                orderItems.setOrderID(rs.getInt("OrderID"));
                orderItems.setProductVariantID(rs.getInt("ProductVariantID"));
                orderItems.setQuantity(rs.getInt("Quantity"));
                orderItems.setPrice(rs.getFloat("Price"));
                orderItems.setStatus(rs.getInt("status"));
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return orderItems;
    }

    private boolean updateStatusProduct(OrderItems orderItems) {
        boolean isUpdate = false;
        if (orderItems == null) {
            return isUpdate;
        }
        String sql = "update [OrderItems] set [status] = ? where OrderItemID = ?";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, orderItems.getStatus());
            ps.setInt(2, orderItems.getOrderItemID());
            int rowUpdate = ps.executeUpdate();
            if (rowUpdate > 0) {
                isUpdate = true;
            }
            ps.close();
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return isUpdate;
    }

    private void accept(OrderItems orderItems) throws SQLException {
        ProductVariant pv = ProductVariantProcess.INSTANCE.getProductVariantById(orderItems.getProductVariantID());
        if (pv == null) {
            throw new IllegalArgumentException("The system error! Cannot find product variant.");
        }
        if (pv.getStockQuantity() < orderItems.getQuantity()) {
            throw new IllegalArgumentException("Insufficient inventory quantity to accept.");
        }
        int quantity = pv.getStockQuantity() - orderItems.getQuantity();
        try {
            this.conn.setAutoCommit(false);
            if (!updateStatusProduct(orderItems)) {
                throw new SQLException();
            }

            if (!ProductVariantProcess.INSTANCE.updateStockQuantity(quantity, pv.getProductVariantId())) {
                throw new SQLException();
            }
            this.conn.commit();
        } catch (SQLException e) {
            this.status = e.getMessage();
            try {
                this.conn.rollback();
            } catch (SQLException rollbackEx) {
                this.status += "; Rollback failed: " + rollbackEx.getMessage();
            }
            throw e;
        } finally {
            this.conn.setAutoCommit(true);
        }
    }

    public List<Integer> create(int newOrderId, List<String> pvIdList, List<String> quantityList, List<String> priceList, int status) {
        List<Integer> orderItemIdList = new ArrayList<>();
        String sql = "INSERT INTO [OrderItems] ([OrderID], [ProductVariantID], [Quantity], [Price], [status]) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = this.conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            for (int i = 0; i < pvIdList.size(); i++) {
                int idx = 1;
                ps.setInt(idx++, newOrderId);
                ps.setInt(idx++, Integer.parseInt(pvIdList.get(i)));
                ps.setInt(idx++, Integer.parseInt(quantityList.get(i)));
                ps.setBigDecimal(idx++, new BigDecimal(priceList.get(i)));
                ps.setInt(idx++, status);

                ps.executeUpdate();
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderItemIdList.add(rs.getInt(1));
                    }
                }
            }
        } catch (Exception e) {
            this.status = e.getMessage();
            System.out.println("Error: " + e.getMessage());
        }

        return orderItemIdList;
    }
}
