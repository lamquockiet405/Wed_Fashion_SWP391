/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.DAO_Customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import DAO.DBcontext;
import Model.Bill;
import Model.BillDetail;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Dell
 */
public class DAOOrder_c extends DBcontext {

    public List<BillDetail> getAllBillDetails() {
        // Initialize an empty List to store objects of type BillDetail.
        List<BillDetail> bills = new ArrayList<>();
        String sql = "SELECT * FROM OrderHistoryDetail";
        try (Connection conn = new DBcontext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                BillDetail bill = new BillDetail(
                        rs.getInt("BillDetailsID"),
                        rs.getString("ProductVariantName"),
                        rs.getString("ProductVariantImage"),
                        rs.getInt("Quantity"),
                        rs.getFloat("Price"),
                        rs.getInt("BillID"),
                        rs.getInt("status"),
                        rs.getInt("orderItemId")
                );
                bills.add(bill);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }

    public List<BillDetail> getBillDetailsByProductName(String keyword) {
        List<BillDetail> bills = new ArrayList<>();
        String sql = "SELECT * FROM OrderHistoryDetail WHERE ProductVariantName LIKE ?";
        try (Connection conn = new DBcontext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bills.add(new BillDetail(
                            rs.getInt("BillDetailsID"),
                            rs.getString("ProductVariantName"),
                            rs.getString("ProductVariantImage"),
                            rs.getInt("Quantity"),
                            rs.getFloat("Price"),
                            rs.getInt("BillID")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }

    private Date parseOrderDate(String orderDateStr) {
        try {
            long millis = Long.parseLong(orderDateStr);
            return new Date(millis);
        } catch (Exception e) {
            return null;
        }
    }

    public List<Bill> getBillsSelect(int userId, int page, int pageSize) {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM OrderHistory WHERE userId = ? ORDER BY BillID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill(
                        rs.getInt("BillID"),
                        rs.getString("username"),
                        parseOrderDate(rs.getString("OrderDate")),
                        rs.getString("ShippingAddress"),
                        rs.getInt("status"),
                        rs.getString("PaymentMethod"),
                        rs.getFloat("TotalAmount"),
                        rs.getInt("userId")
                );
                bills.add(bill);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }

    public int getTotalBillsByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM OrderHistory WHERE userId = ?";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalBillsFilterByUserId(int userId) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM OrderHistory WHERE userId = ?");
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Bill> getBillsSelectFilter(int userId, int page, int pageSize, String priceFilter, String search) {
        List<Bill> bills = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT DISTINCT b.* FROM OrderHistory b "
                        + "JOIN OrderHistoryDetail bd ON b.BillID = bd.BillID "
                        + "WHERE b.userId = ?");
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND bd.ProductVariantName LIKE ?");
        }
        if ("min".equalsIgnoreCase(priceFilter)) {
            sql.append(" ORDER BY b.TotalAmount ASC");
        } else if ("max".equalsIgnoreCase(priceFilter)) {
            sql.append(" ORDER BY b.TotalAmount DESC");
        } else {
            sql.append(" ORDER BY b.BillID");
        }
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, userId);
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%");
            }
            int offset = Math.max(0, (page - 1) * pageSize);
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill(
                        rs.getInt("BillID"),
                        rs.getString("username"),
                        parseOrderDate(rs.getString("OrderDate")),
                        rs.getString("ShippingAddress"),
                        rs.getInt("status"),
                        rs.getString("PaymentMethod"),
                        rs.getFloat("TotalAmount"),
                        rs.getInt("userId")
                );
                bills.add(bill);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }

    public List<Bill> getBillsSelectFilter(int userId, int page, int pageSize, String priceFilter) {
        List<Bill> bills = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM OrderHistory WHERE userId = ?");
        if ("min".equalsIgnoreCase(priceFilter)) {
            sql.append(" ORDER BY TotalAmount ASC");
        } else if ("max".equalsIgnoreCase(priceFilter)) {
            sql.append(" ORDER BY TotalAmount DESC");
        } else {
            sql.append(" ORDER BY BillID");
        }
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, userId);
            int offset = Math.max(0, (page - 1) * pageSize);
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill(
                        rs.getInt("BillID"),
                        rs.getString("username"),
                        parseOrderDate(rs.getString("OrderDate")),
                        rs.getString("ShippingAddress"),
                        rs.getInt("status"),
                        rs.getString("PaymentMethod"),
                        rs.getFloat("TotalAmount"),
                        rs.getInt("userId")
                );
                bills.add(bill);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }

    public static void main(String[] args) {
        // Giả sử bạn có một class chứa phương thức getBillsSelectFilter
        
        DAOOrder_c oc = new DAOOrder_c();

        // Các tham số kiểm tra
        int userId = 1;  // ID của người dùng cần lấy hóa đơn
        int page = 1;     // Trang đầu tiên
        int pageSize = 10; // Số hóa đơn trên mỗi trang
        String priceFilter = "max"; // Sắp xếp theo giá cao nhất
        String search = "Laptop";   // Tìm kiếm hóa đơn có sản phẩm chứa "Laptop"

        // Gọi hàm để lấy danh sách hóa đơn
        List<Bill> bills = oc.getBillsSelectFilter(userId, page, pageSize, priceFilter, search);

        // In kết quả ra màn hình
        System.out.println("Danh sách hóa đơn tìm thấy:");
        for (Bill bill : bills) {
            System.out.println("BillID: " + bill.getBillID()
                    + ", Username: " + bill.getUsername()
                    + ", Order Date: " + bill.getOrderDate()
                    + ", Shipping Address: " + bill.getShippingAddress()
                   
                    + ", Payment Method: " + bill.getPaymentMethod()
                    + ", Total Amount: " + bill.getTotalAmount());
        }

        // Kiểm tra nếu không có hóa đơn nào được tìm thấy
        if (bills.isEmpty()) {
            System.out.println("Không tìm thấy hóa đơn nào.");
        }

    }

}
