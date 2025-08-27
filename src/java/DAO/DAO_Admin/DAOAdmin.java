/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.DAO_Admin;

import DAO.DAO_User.DAOUsers;
import Model.Admin;
import Model.Orders;
import Model.Payment;
import Model.Shops;
import Model.Users;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Date;

/**
 *
 * @author lenovo
 */
public class DAOAdmin extends DAO.DBcontext {

    

    public Admin loginAdmin(String email, String pass) {
        String sql = "select * from [Admins] where [Email] = ? and [Password] = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, pass);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Admin admin = new Admin();
                    admin.setAdminId(rs.getInt("AdminID"));
                    admin.setUsername(rs.getString("Username"));
                    admin.setPassword(rs.getString("Password"));
                    admin.setEmail(rs.getString("Email"));
                    admin.setFirstName(rs.getString("FirstName"));
                    admin.setLastName(rs.getString("LastName"));
                    admin.setAddress(rs.getString("Address"));
                    try { admin.setDateOfBirth(rs.getDate("DateOfBirth")); } catch (SQLException ignore) {}
                    try { admin.setGender(rs.getBoolean("Gender")); } catch (SQLException ignore) {}
                    admin.setPhoneNumber(rs.getString("PhoneNumber"));
                    admin.setImage(rs.getString("Image"));
                    admin.setStatus(rs.getString("Status"));
                    try { admin.setCreatedAt(rs.getTimestamp("CreatedAt")); } catch (SQLException ignore) {}
                    return admin;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int GetTotalCustomers() {
        int total = 0;
        String sql = "select COUNT(*) from Customers";
        try (PreparedStatement stm = conn.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return total;
    }

    public void UpdateAccountStatus(Users user) {
        try {
            String sql = "UPDATE [Customers] SET [Status] = ? WHERE [CustomerID] = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, user.getStatus());
            stm.setInt(2, user.getUserID());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Users> GetUserList() {
        List<Users> list = new ArrayList<>();
        String sql = "select * from Customers";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Users user = new Users();
                user.setUserID(rs.getInt("CustomerID"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setFirstName(rs.getString("FirstName"));
                user.setLastName(rs.getString("LastName"));
                user.setAddress(rs.getString("Address"));
                try { user.setDateOfBirth(String.valueOf(rs.getDate("DateOfBirth"))); } catch (Exception ignore) {}
                try { user.setGender(rs.getBoolean("Gender")); } catch (Exception ignore) {}
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setImage(rs.getString("Image"));
                user.setUserRole("Customer");
                user.setStatus(rs.getString("Status"));
                try { user.setCreateAt(String.valueOf(rs.getTimestamp("CreatedAt"))); } catch (Exception ignore) {}
                list.add(user);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Shops> GetShopList() { //// Checked
        // Using ArrayList allows dynamic operations such as adding, updating, and removing elements.
        List<Shops> list = new ArrayList<>();
        String sql = "select * from Shops ORDER BY id DESC";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Shops shop = new Shops();
                shop.setId(rs.getInt("id"));
                shop.setName(rs.getString("name"));
                shop.setTax(rs.getString("tax"));
                shop.setDescribe(rs.getString("describe"));
                shop.setLogo(rs.getString("logo"));
                shop.setUserId(rs.getInt("userId"));
                boolean isApproved = rs.getBoolean("IsApproved");
                Integer approvedBy = rs.getObject("ApprovedByAdminID") != null ? rs.getInt("ApprovedByAdminID") : null;
                java.util.Date approvedAt = null;
                try { approvedAt = rs.getTimestamp("ApprovedAt"); } catch (SQLException ignore) {}
                // Derive status string
                String status = isApproved ? "Approved" : (approvedBy != null ? "Rejected" : "Pending");
                shop.setStatus(status);
                shop.setApprovalDate(approvedAt);
                shop.setAdminNotes(null);
                list.add(shop);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    /**
     * Lấy danh sách shop theo status
     * @param status Pending, Approved, Rejected
     * @return List<Shops>
     */
    public List<Shops> GetShopListByStatus(String status) {
        List<Shops> list = new ArrayList<>();
        String sql = "select * from Shops ORDER BY id DESC";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                boolean isApproved = rs.getBoolean("IsApproved");
                Integer approvedBy = rs.getObject("ApprovedByAdminID") != null ? rs.getInt("ApprovedByAdminID") : null;
                String derived = isApproved ? "Approved" : (approvedBy != null ? "Rejected" : "Pending");
                if (!derived.equals(status)) continue;
                Shops shop = new Shops();
                shop.setId(rs.getInt("id"));
                shop.setName(rs.getString("name"));
                shop.setTax(rs.getString("tax"));
                shop.setDescribe(rs.getString("describe"));
                shop.setLogo(rs.getString("logo"));
                shop.setUserId(rs.getInt("userId"));
                shop.setStatus(derived);
                try { shop.setApprovalDate(rs.getTimestamp("ApprovedAt")); } catch (SQLException ignore) {}
                shop.setAdminNotes(null);
                list.add(shop);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    /**
     * Duyệt hoặc từ chối shop
     * @param shopId ID của shop
     * @param status Approved hoặc Rejected
     * @param adminNotes Ghi chú của admin
     * @return true nếu thành công
     */
    public boolean approveShop(int shopId, String status, String adminNotes) {
        // Map status to DB fields
        boolean approve = "Approved".equalsIgnoreCase(status);
        String sql = "UPDATE [Shops] SET [IsApproved] = ?, [ApprovedByAdminID] = ?, [ApprovedAt] = GETDATE() WHERE [id] = ?";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            // For Approved: 1; For Rejected/Pending: 0
            stm.setBoolean(1, approve);
            // Use a fallback admin id if not available; caller should update this if needed
            int adminId = 0; // will be set by controller-specific overload if needed
            try { adminId = this.getAdminIdFromContext(); } catch (Exception ignore) {}
            stm.setInt(2, adminId);
            stm.setInt(3, shopId);
            int result = stm.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            System.out.println("Error approving shop: " + e.getMessage());
            return false;
        }
    }

    public boolean approveShopWithAdmin(int shopId, int adminId, boolean approve, String adminNotes) {
        String sql = "UPDATE [Shops] SET [IsApproved] = ?, [ApprovedByAdminID] = ?, [ApprovedAt] = GETDATE() WHERE [id] = ?";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setBoolean(1, approve);
            stm.setInt(2, adminId);
            stm.setInt(3, shopId);
            int result = stm.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            System.out.println("Error approving shop: " + e.getMessage());
            return false;
        }
    }

    /**
     * Cập nhật role của user thành Seller khi shop được duyệt
     * @param userId ID của user
     * @return true nếu thành công
     */
    public boolean updateUserRoleToSeller(int userId) {
        String sql = "UPDATE [Users] SET [UserRole] = 'Seller' WHERE [UserID] = ?";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, userId);
            
            int result = stm.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            System.out.println("Error updating user role: " + e.getMessage());
            return false;
        }
    }

    public Users getUserById(int id) { ////Checked
        String sql = "select * from [Users] where UserID = '" + id + "'  ";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);

            while (rs.next()) {
               int UsersID = rs.getInt(1);
                String Username = rs.getString(2);
                String Password = rs.getString(3);
                String Email = rs.getString(4);
                String FirstName = rs.getString(5);
                String LastName = rs.getString(6);
                String Address = rs.getString(7);
                String DateOfBirth = rs.getString(8);
                boolean Gender = rs.getBoolean(9);
                
                String PhoneNumber = rs.getString(10);
                String Image = rs.getString(11);
                String UserRole = rs.getString(12);
                String Status = rs.getString(13);
                String CreateAt = rs.getString(14);

                Users ac = new Users(UsersID, Username, Password, Email, FirstName, LastName, Address, DateOfBirth, Gender, PhoneNumber, Image, UserRole, Status, CreateAt);
                System.out.println(ac);
                return ac;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
     public Shops getShopById(int id) { ////Checked
        String sql = "select * from [Shops] where id = ?";
        try {
            PreparedStatement state = conn.prepareStatement(sql);
            state.setInt(1, id);
            ResultSet rs = state.executeQuery();
            while (rs.next()) {
                int shopid = rs.getInt("id");
                String name = rs.getString("name");
                String tax = rs.getString("tax");
                String describe = rs.getString("describe");
                String logo = rs.getString("logo");
                int userId = rs.getInt("userId");
                boolean isApproved = rs.getBoolean("IsApproved");
                Integer approvedBy = rs.getObject("ApprovedByAdminID") != null ? rs.getInt("ApprovedByAdminID") : null;
                java.util.Date approvedAt = rs.getTimestamp("ApprovedAt");
                String status = isApproved ? "Approved" : (approvedBy != null ? "Rejected" : "Pending");
                Shops shop = new Shops(shopid, name, tax, describe, logo, userId, status, approvedAt, null);
                return shop;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    
    
    
    public List<Shops> GetShopListByEmail(String email) { //// Checked
        List<Shops> list = new ArrayList<>();
        String sql = "select s.* from [Shops] s INNER JOIN Customers c ON c.CustomerID = s.userId where c.Email like ?";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, email + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Shops shop = new Shops();
                shop.setId(rs.getInt("id"));
                shop.setName(rs.getString("name"));
                shop.setTax(rs.getString("tax"));
                shop.setDescribe(rs.getString("describe"));
                shop.setLogo(rs.getString("logo"));
                shop.setUserId(rs.getInt("userId"));
                boolean isApproved = rs.getBoolean("IsApproved");
                Integer approvedBy = rs.getObject("ApprovedByAdminID") != null ? rs.getInt("ApprovedByAdminID") : null;
                java.util.Date approvedAt = rs.getTimestamp("ApprovedAt");
                String status = isApproved ? "Approved" : (approvedBy != null ? "Rejected" : "Pending");
                shop.setStatus(status);
                shop.setApprovalDate(approvedAt);
                list.add(shop);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
    
     public List<Users> GetUserListByEmail(String email) { //// Checked
        List<Users> list = new ArrayList<>();
        String sql = "select * from Customers where Email like ?";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, email + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Users user = new Users();
                user.setUserID(rs.getInt("CustomerID"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setFirstName(rs.getString("FirstName"));
                user.setLastName(rs.getString("LastName"));
                user.setAddress(rs.getString("Address"));
                try { user.setDateOfBirth(String.valueOf(rs.getDate("DateOfBirth"))); } catch (Exception ignore) {}
                try { user.setGender(rs.getBoolean("Gender")); } catch (Exception ignore) {}
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setImage(rs.getString("Image"));
                user.setUserRole("Customer");
                user.setStatus(rs.getString("Status"));
                try { user.setCreateAt(String.valueOf(rs.getTimestamp("CreatedAt"))); } catch (Exception ignore) {}
                list.add(user);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
    
      public void AddPaymentMethod(String paymentMethod) { ////Checked
        String sql = "INSERT INTO [dbo].[Payment] ([PaymentMethod],[status]) VALUES (?,?)";

        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);
            pre.setString(1, paymentMethod);
            pre.setInt(2, 1);
            pre.executeUpdate();

        } catch (Exception e) {
            System.out.println(e);
        }
    }
         public Payment FindPaymentMethod(String paymentMethod) { ////Checked
        String sql = "select * from [Payment] where PaymentMethod = '" + paymentMethod + "'  ";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);

            while (rs.next()) {
               int paymentId = rs.getInt(1);
                String PaymentMethod = rs.getString(2);
                int status  = rs.getInt(3);
               
              
                Payment p = new Payment(paymentId, PaymentMethod, status);

                
               System.out.println(p);
                return p;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public void UpdatePaymentStatus(int status, int paymentId) { ////Checked

        try {
            String sql = "UPDATE [Payment]\n"
                    + "   SET [status] = ?\n"
                    + " WHERE PaymentID = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, status);
            stm.setInt(2, paymentId);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }

    }


    public List<Payment> GetPaymentMethod() { //// Checked
        List<Payment> list = new ArrayList<>();
        String sql = "select * from Payment";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentID(rs.getInt(1));
             
                payment.setPaymentMethod(rs.getString(2));
                payment.setStatus(rs.getInt(3));

                list.add(payment);
            }
            System.out.println(list);
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
    
    
    public void DeletePaymentMethod(int id) { ////Checked

        try {
            String sql = "DELETE FROM [dbo].[Payment] WHERE PaymentID = ? ";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    
    public int GetTotalUsers() { //// Checked
        return GetTotalCustomers();
    }
    
      public int GetTotalOrder() { //// Checked
        int total = 0;
        String sql = "select COUNT(*) from Orders";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return total;
    }
            public int GetTotalProducts() { //// Checked
        int total = 0;
        String sql = "select COUNT(*) from Products";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return total;
    }
    
   public List<Orders> GetOrderList() { //// Checked
        List<Orders> list = new ArrayList<>();
        String sql = "select * from Orders";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Orders order = new Orders();
                order.setOrderID(rs.getInt(1));
                order.setUserID(rs.getInt(2));
             
                order.setOrderDate(rs.getDate(3));
                order.setTotalAmount(rs.getFloat(4));
                order.setStatus(rs.getString(5));
                order.setShippingAddress(rs.getString(6));
                order.setPaymentMethod(rs.getString(7));

                list.add(order);
            }
            System.out.println(list);
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
    
    public List<Users> GetSellerUserList() {
        List<Users> list = new ArrayList<>();
        String sql = "select SellerID, Username, Email, PhoneNumber from Shop";
        try (PreparedStatement stm = conn.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                Users user = new Users();
                user.setUserID(rs.getInt("SellerID"));
                user.setUsername(rs.getString("Username"));
                user.setEmail(rs.getString("Email"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setUserRole("Seller");
                user.setStatus("Active");
                list.add(user);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public static void main(String[] args) {
        DAOAdmin test = new DAOAdmin();
        test.GetOrderList();
    } 
}
