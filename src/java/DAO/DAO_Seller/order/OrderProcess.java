/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.DAO_Seller.order;

import Model.Orders;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderProcess extends DAO.DAO {

    public static OrderProcess INSTANCE = new OrderProcess();

    private OrderProcess() {
    }
    private int index = 1;

    public int getTotalPage(int pageSize, String status, String search, String sort) {
        int totalPages = 0;
        int totalRecords;
        StringBuilder countQuery = new StringBuilder("SELECT COUNT(*) FROM [Orders] WHERE 1 = 1");

        if (status != null) {
            countQuery.append(" AND [status] = ?");
        }
        if (search != null) {
            countQuery.append(" AND ProductName LIKE ?");
        }

        try {
            PreparedStatement countStmt = this.conn.prepareStatement(countQuery.toString());
            index = 1;

            if (status != null) {
                countStmt.setString(index++, status);
            }
            if (search != null) {
                countStmt.setString(index++, "%" + search + "%");
            }
            index = 1;

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

    public List<Orders> getOrdersByPage(int page, int pageSize, String status, String search, String sort) {
        List<Orders> orderList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT [OrderID], [UserID], [OrderDate], [TotalAmount], [Status], [ShipingAddress], [PaymentMethod] FROM [Orders] WHERE 1 = 1 ");

        if (status != null) {
            sql.append(" AND [Status] = ?");
        }
        if (search != null) {
            sql.append(" AND [ShipingAddress] LIKE ?");
        }

        sql.append(" ORDER BY OrderDate ").append(sort);
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try {
            int index = 1;
            PreparedStatement stmt = this.conn.prepareStatement(sql.toString());
            if (status != null) {
                stmt.setString(index++, status);
            }
            if (search != null) {
                stmt.setString(index++, "%" + search + "%");
            }
            stmt.setInt(index++, (page - 1) * pageSize);
            stmt.setInt(index++, pageSize);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Orders order = new Orders();
                order.setOrderID(rs.getInt("OrderID"));
                order.setUserID(rs.getInt("UserID"));
                order.setOrderDate(rs.getDate("OrderDate"));
                order.setTotalAmount(rs.getFloat("TotalAmount"));
                order.setStatus(rs.getString("Status"));
                order.setShippingAddress(rs.getString("ShipingAddress"));
                order.setPaymentMethod(rs.getString("PaymentMethod"));

                orderList.add(order);
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return orderList;
    }

    public int create(int userID, double totalAmount, String status, String shippingAddress, int paymentID) {
        int newOrderId = -1;
        String sql = "INSERT INTO [Orders] ([UserID], [OrderDate], [TotalAmount], [Status], [ShipingAddress], [PaymentID]) VALUES (?, GETDATE(), ?, ?, ?, ?)";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS);
            int i = 1;
            ps.setInt(i++, userID);
            ps.setBigDecimal(i++, java.math.BigDecimal.valueOf(totalAmount));
            ps.setString(i++, status);
            ps.setString(i++, shippingAddress);
            ps.setInt(i++, paymentID);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    newOrderId = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            this.status = e.getMessage();
        }
        return newOrderId;
    }
}
