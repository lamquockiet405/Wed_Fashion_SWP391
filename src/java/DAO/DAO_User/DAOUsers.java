/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.DAO_User;

import DAO.*;
import Model.Cart;
import Model.ProductsVariant;
import Model.Payment;
import Model.ShippingAddresses;
import Model.Shops;
import Model.Users;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

/**
 *
 * @author lenovo
 */
public class DAOUsers extends DBcontext {

    public Users login(String email, String pass) { ////Checked
        String sql = "select * from [Users] where [Email] ='" + email + "' and [Password] ='" + pass + "'";
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
                Date CreateAt = rs.getDate(14);

                Users ac = new Users(UsersID, Username, Password, Email, FirstName, LastName, Address, DateOfBirth, Gender, PhoneNumber, Image, UserRole, Status, Status);
                System.out.println(ac);
                return ac;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public Users loginByGoogle(String email) { ////Checked
        String sql = "select * from [Users] where [Email] ='" + email + "'";
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
                Date CreateAt = rs.getDate(14);

                Users ac = new Users(UsersID, Username, Password, Email, FirstName, LastName, Address, DateOfBirth, Gender, PhoneNumber, Image, UserRole, Status, Status);
                System.out.println(ac);
                return ac;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public Users checkUserName(String user) { ////Checked
        String sql = "select * from [Users] where [Username] ='" + user + "'";
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
                Date CreateAt = rs.getDate(14);

                Users ac = new Users(UsersID, Username, Password, Email, FirstName, LastName, Address, DateOfBirth, Gender, PhoneNumber, Image, UserRole, Status, Status);
                System.out.println(ac);
                return ac;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public void signup(String user, String pass, String Email, String PhoneNumber, int Gender) { ////Checked
        String sql = "INSERT INTO [dbo].[Users]\n"
                + "           ([Username]\n"
                + "           ,[Password]\n"
                + "           ,[Email]\n"
                + "           ,[Gender]\n"
                + "           ,[PhoneNumber]\n"
                + "           ,[UserRole]\n"
                + "           ,[Status])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?)";

        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);
            pre.setString(1, user);
            pre.setString(2, pass);
            pre.setString(3, Email);
            pre.setInt(4, Gender);
            pre.setString(5, PhoneNumber);
            pre.setString(6, "User");
            pre.setString(7, "Active");
            pre.executeUpdate();

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void signupByGoogle(String user, String Email) { ////Checked
        String sql = "INSERT INTO [dbo].[Users]\n"
                + "           ([Username]\n"
                + "           ,[Email]\n"
                + "           ,[UserRole]\n"
                + "           ,[Status])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?)";

        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);
            pre.setString(1, user);
            pre.setString(2, Email);
            pre.setString(3, "User");
            pre.setString(4, "Active");
            pre.executeUpdate();

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public Users CheckExitAccount(String email) { ////Checked
        String sql = "select * from [Users] where [email] ='" + email + "'";
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
                Date CreateAt = rs.getDate(14);

                Users ac = new Users(UsersID, Username, Password, Email, FirstName, LastName, Address, DateOfBirth, Gender, PhoneNumber, Image, UserRole, Status, Status);
                System.out.println(ac);
                return ac;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public Integer getSellerIdByEmail(String email) {
        String sql = "SELECT SellerID FROM [Shop] WHERE Email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public int createSellerFromCustomer(Users acc) {
        String sql = "INSERT INTO [Shop] (Username, Password, Email, FirstName, LastName, Address, DateOfBirth, Gender, PhoneNumber, Image, Status, CreatedAt, IsApproved) VALUES (?,?,?,?,?,?,?,?,?,?,?,GETDATE(),0)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, acc.getUsername());
            ps.setString(2, null);
            ps.setString(3, acc.getEmail());
            ps.setString(4, acc.getFirstName());
            ps.setString(5, acc.getLastName());
            ps.setString(6, acc.getAddress());
            try { ps.setDate(7, acc.getDateOfBirth() != null ? java.sql.Date.valueOf(acc.getDateOfBirth()) : null); } catch (Exception ex) { ps.setDate(7, null); }
            try { ps.setBoolean(8, acc.isGender()); } catch (Exception ex) { ps.setBoolean(8, false); }
            ps.setString(9, acc.getPhoneNumber());
            ps.setString(10, acc.getImage());
            ps.setString(11, "Active");
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return -1;
    }

    public void registerShopForSeller(int sellerId, String shopName, String tax, String describe, String logo) {
        String sql = "INSERT INTO [Shops] ([name],[tax],[describe],[logo],[userId]) VALUES (?,?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, shopName);
            ps.setString(2, tax);
            ps.setString(3, describe);
            ps.setString(4, logo);
            ps.setInt(5, sellerId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void RegisterShop(String ShopName, String tax, String describe, int userID) { //// as per new workflow
        try {
            // Find customer info
            Users u = getCustomerAsUsersById(userID);
            if (u == null) return;
            // Ensure seller account exists in Shop table
            Integer sellerId = getSellerIdByEmail(u.getEmail());
            if (sellerId == null) {
                int created = createSellerFromCustomer(u);
                if (created <= 0) return;
                sellerId = created;
            }
            // Store pending shop in Shops with IsApproved default 0
            registerShopForSeller(sellerId, ShopName, tax, describe, null);
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void rejectShopRequest(int shopId) {
        String sql = "UPDATE [Shops] SET [IsApproved] = 0, [ApprovedByAdminID] = NULL, [ApprovedAt] = NULL WHERE [id] = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, shopId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Shops CheckExitShop(int UserID) { ////Checked
        String sql = "select * from [Shops] where [userId] =" + UserID + "";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);

            while (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(2);
                String tax = rs.getString(3);
                String describe = rs.getString(4);
                String logo = rs.getString(5);
                int userId = rs.getInt(6);
                String status = rs.getString(7) != null ? rs.getString(7) : "Pending";
                Date approvalDate = rs.getDate(8);
                String adminNotes = rs.getString(9);
                
                Shops shop = new Shops(id, name, tax, describe, logo, userId, status, approvalDate, adminNotes);
                System.out.println(shop);
                return shop;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public void UpdateRoleToSeller(int userID) { ////Checked

        try {
            String sql = "UPDATE [Users]\n"
                    + "   SET [UserRole] = ?\n"
                    + " WHERE UserID = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, "Seller");
            stm.setInt(2, userID);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    //Checked
    public boolean checkUserbyEmail(String email) {
        String sql = "SELECT * FROM Users WHERE Email = ?";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                String getEmail = rs.getString(email);

                if (getEmail != null) {
                    return true;
                } else {
                    return false;
                }

            }
        } catch (SQLException e) {
            System.err.println(e);

        }
        return false;
    }

    public Users getUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE Email = ?";
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
                Date CreateAt = rs.getDate(14);

                Users ac = new Users(UsersID, Username, Password, Email, FirstName, LastName, Address, DateOfBirth, Gender, PhoneNumber, Image, UserRole, Status, Status);
                System.out.println(ac);
                return ac;
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi truy vấn user: " + e.getMessage());
        }
        return null;  // Trả về null nếu không tìm thấy user
    }

    public boolean updatePassword(String email, String newPassword) {
        try {
            String sql = "UPDATE [dbo].[Users] SET [Password] = ? WHERE [Email] = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, newPassword);
                ps.setString(2, email);
                int rowCount = ps.executeUpdate();
                return rowCount > 0;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public int AddAddress(String username, String phoneNumber, String address, int userId) { ////Checked
        int generatedId = -1;
        String sql = "INSERT INTO [dbo].[ShippingAddresses] ([username],[phoneNumber],[address] ,[status],[userId]) VALUES(?,?,?,?,?)";
        
        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pre.setString(1, username);
            pre.setString(2, phoneNumber);
            pre.setString(3, address);
            pre.setInt(4, 0);
            pre.setInt(5, userId);
            pre.executeUpdate();
            
            try(ResultSet rs = pre.getGeneratedKeys()){
                if(rs.next()){
                    generatedId = rs.getInt(1);
                }
            
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return generatedId;
    }

    public void UpdateEachAddressStatus(int status, int userId, int addressId) { ////Checked

        try {
            String sql = "UPDATE [ShippingAddresses]\n"
                    + "   SET [status] = ?\n"
                    + " WHERE userId = ? AND id = ? ";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, status);
            stm.setInt(2, userId);
            stm.setInt(3, addressId);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void UpdateAllAddressStatus(int status, int userId) { ////Checked

        try {
            String sql = "UPDATE [ShippingAddresses]\n"
                    + "   SET [status] = ?\n"
                    + " WHERE userId = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, status);
            stm.setInt(2, userId);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
//UpdateAddress//
    public void UpdateAddress(String username, String phoneNumber, String address, int id) { ////Checked
        try {
            String sql = "UPDATE [ShippingAddresses] SET [username] = ?, [phoneNumber] = ?, [address] = ? WHERE id = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, phoneNumber);
            stm.setString(3, address);
            stm.setInt(4, id);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<ShippingAddresses> GetAddressListByUserId(int userId) { //// Checked
        List<ShippingAddresses> list = new ArrayList<>();
        String sql = "select * from ShippingAddresses where userId = " + userId;
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                ShippingAddresses sa = new ShippingAddresses();
                sa.setId(rs.getInt(1));
                sa.setUsername(rs.getString(2));
                sa.setPhoneNumber(rs.getString(3));
                sa.setAddress(rs.getString(4));
                sa.setStatus(rs.getBoolean(5));
                sa.setUserId(rs.getInt(6));
                list.add(sa);
            }
            System.out.println(list);
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public void AddOrder(int userID, String totalAmount, String status, String shippingAddress, int paymentId) { ////Checked
        String sql = "INSERT INTO [dbo].[Orders] ([UserID],[TotalAmount] ,[Status],[ShipingAddress],[PaymentID]) VALUES(?,?,?,?,?)";
        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);
            pre.setInt(1, userID);
            pre.setString(2, totalAmount);
            pre.setString(3, status);
            pre.setString(4, shippingAddress);
            pre.setInt(5, paymentId);
            pre.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void AddOrderItems(int OrderID, int ProductVariantID, int Quantity, String ProductName, String ProductVariantName, String Image) { ////Checked
        String sql = "INSERT INTO [dbo].[OrderItems] ([OrderID],[ProductVariantID],[Quantity] ,[Price],[ProductName],[ProductVariantName],[Image]) VALUES(?,?,?,?,?,?,?)";
        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);
            pre.setInt(1, OrderID);
            pre.setInt(2, ProductVariantID);
            pre.setInt(3, Quantity);
            pre.setFloat(4, getPriceByVariantId(ProductVariantID));
            pre.setString(5, ProductName);
            pre.setString(6, ProductVariantName);
            pre.setString(7, Image);
            pre.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public float getPriceByVariantId(int variantId) {
        String sql = "SELECT price FROM ProductsVariant WHERE ProductVariantID = ?";
        try (PreparedStatement pre = conn.prepareStatement(sql)) {
            pre.setInt(1, variantId);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getFloat("price");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void DeleteAddress(int userId, int id) { ////Checked

        try {
            String sql = "DELETE FROM [dbo].[ShippingAddresses] WHERE userId = ? and id = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, userId);
            stm.setInt(2, id);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public int CreateOrder(int userId, float totalAmount) {
        int orderId = 0;
        String sql = "INSERT INTO [dbo].[Orders] ([UserID], [TotalAmount], [Status], [PaymentID]) VALUES (?, ?, ?, ?)";

        try (PreparedStatement pre = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pre.setInt(1, userId);
            pre.setFloat(2, totalAmount);
            pre.setString(3, "Pending");
            pre.setInt(4, 1);
            pre.executeUpdate();

            // Lấy OrderID vừa tạo
            try (ResultSet rs = pre.getGeneratedKeys()) {
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }
            }
            System.out.println(orderId);
        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi để dễ debug
        }

        return orderId;
    }

    public List<Cart> GetCartDataByCartId(int cartId) { //// Checked
        List<Cart> list = new ArrayList<>();
        String sql = "select * from Cart where CartID = " + cartId;
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Cart ca = new Cart();
                ca.setCartID(rs.getInt(1));
                ca.setUserID(rs.getInt(2));
                ca.setProductVariantID(rs.getInt(3));
                ca.setQuantity(rs.getInt(4));

                list.add(ca);
            }
            System.out.println(list);
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public ProductsVariant getProductsVariantById(int id) {
        String sql = "SELECT * FROM ProductsVariant WHERE [ProductVariantID] = " + id;
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);

            while (rs.next()) {
                int ProductVariantID = rs.getInt(1);
                String ProductVariantName = rs.getString(2);
                int ProductID = rs.getInt(3);
                float Price = rs.getFloat(4);
                int StockQuantity = rs.getInt(5);
                String Image = rs.getString(6);

                ProductsVariant pv = new ProductsVariant(ProductVariantID, ProductVariantName, ProductID, Price, StockQuantity, Image, ProductVariantName);
                System.out.println(pv);
                return pv;
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi truy vấn user: " + e.getMessage());
        }
        return null;  // Trả về null nếu không tìm thấy user
    }

    public ShippingAddresses getAddressById(int addressId) { ////Checked
        String sql = "select * from [ShippingAddresses] where [id] =" + addressId + "";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);

            while (rs.next()) {
                int id = rs.getInt(1);
                String username = rs.getString(2);
                String phoneNumber = rs.getString(3);
                String address = rs.getString(4);
                boolean status = rs.getBoolean(5);
                int userId = rs.getInt(6);
                ShippingAddresses sa = new ShippingAddresses(id, username, phoneNumber, address, status, userId);
                System.out.println(sa);
                return sa;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public List<Cart> getCartByUserAndCartIds(int userId, List<Integer> cartIds) {
        List<Cart> cartList = new ArrayList<>();
        if (cartIds.isEmpty()) {
            return cartList; // Trả về danh sách rỗng nếu không có cartId nào
        }

        String sql = "SELECT * FROM Cart WHERE userID = ? AND cartID IN ("
                + cartIds.stream().map(id -> "?").collect(Collectors.joining(",")) + ")";

        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            for (int i = 0; i < cartIds.size(); i++) {
                ps.setInt(i + 2, cartIds.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart(
                        rs.getInt("cartID"),
                        rs.getInt("userID"),
                        rs.getInt("productVariantID"),
                        rs.getInt("quantity")
                );
                cartList.add(cart);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println(cartList);
        return cartList;
    }

    public ProductsVariant getProductVariantById(int productVariantID) {
        ProductsVariant variant = null;
        String sql = "SELECT * FROM ProductsVariant WHERE productVariantID = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productVariantID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                variant = new ProductsVariant(
                        rs.getInt("ProductVariantID"),
                        rs.getString("ProductVariantName"),
                        rs.getInt("ProductID"),
                        rs.getFloat("Price"),
                        rs.getInt("StockQuantity"),
                        rs.getString("Image"),
                        rs.getString("ProductName")
                );
            }
            System.out.println(variant);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return variant;
    }

    public int CreateBill(String username, String shippingAddress, String paymentMethod, double totalAmount, int userId, int orderId) throws SQLException {
        String sql = "INSERT INTO OrderHistory (username, OrderDate, ShippingAddress, status, PaymentMethod, TotalAmount, userId, orderId) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            String orderDate = String.valueOf(System.currentTimeMillis());
            pstmt.setString(1, username);
            pstmt.setString(2, orderDate);
            pstmt.setString(3, shippingAddress);
            pstmt.setInt(4, 2);
            pstmt.setString(5, paymentMethod);
            pstmt.setDouble(6, totalAmount);
            pstmt.setInt(7, userId);
            pstmt.setInt(8, orderId);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return -1;
    }

    public boolean updateStatusBillDetail(String status, String orderItemId) {
        String sql = "UPDATE [OrderHistoryDetail] SET [status] = ? WHERE [orderItemId] = ?";
        boolean isUpdated = false;
        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, orderItemId);
            int affectedRows = ps.executeUpdate();
            isUpdated = affectedRows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return isUpdated;
    }

    public void addBillDetails(int billId, String productVariantName, String productVariantImage, int quantity, double price, int status, int orderItemId) throws SQLException {
        String sql = "INSERT INTO OrderHistoryDetail (BillID, ProductVariantName, ProductVariantImage, Quantity, Price, status, orderItemId) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, billId);
            pstmt.setString(2, productVariantName);
            pstmt.setString(3, productVariantImage);
            pstmt.setInt(4, quantity);
            pstmt.setDouble(5, price);
            pstmt.setInt(6, status);
            pstmt.setInt(7, orderItemId);
            pstmt.executeUpdate();
        }
    }

    public Users getUserById(int id) { ////Checked
        String sql = "select * from [Users] where [UserID] ='" + id + "'";
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
                Date CreateAt = rs.getDate(14);

                Users ac = new Users(UsersID, Username, Password, Email, FirstName, LastName, Address, DateOfBirth, Gender, PhoneNumber, Image, UserRole, Status, Status);
                System.out.println(ac);
                return ac;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public Users getCustomerAsUsersById(int id) {
        String sql = "SELECT * FROM [Customers] WHERE [CustomerID] = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Users u = new Users();
                    u.setUserID(rs.getInt("CustomerID"));
                    u.setUsername(rs.getString("Username"));
                    u.setPassword(rs.getString("Password"));
                    u.setEmail(rs.getString("Email"));
                    u.setFirstName(rs.getString("FirstName"));
                    u.setLastName(rs.getString("LastName"));
                    u.setAddress(rs.getString("Address"));
                    try { u.setDateOfBirth(String.valueOf(rs.getDate("DateOfBirth"))); } catch (Exception ignore) {}
                    try { u.setGender(rs.getBoolean("Gender")); } catch (Exception ignore) {}
                    u.setPhoneNumber(rs.getString("PhoneNumber"));
                    u.setImage(rs.getString("Image"));
                    u.setUserRole("Customer");
                    u.setStatus(rs.getString("Status"));
                    try { u.setCreateAt(String.valueOf(rs.getTimestamp("CreatedAt"))); } catch (Exception ignore) {}
                    return u;
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean hasApprovedShopForSeller(int sellerId) {
        String sql = "SELECT COUNT(*) FROM [Shops] WHERE [userId] = ? AND [IsApproved] = 1";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, sellerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public Shops getApprovedShopForSeller(int sellerId) {
        String sql = "SELECT * FROM [Shops] WHERE [userId] = ? AND [IsApproved] = 1";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, sellerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Shops shop = new Shops();
                    shop.setId(rs.getInt("id"));
                    shop.setName(rs.getString("name"));
                    shop.setTax(rs.getString("tax"));
                    shop.setDescribe(rs.getString("describe"));
                    shop.setLogo(rs.getString("logo"));
                    shop.setUserId(rs.getInt("userId"));
                    shop.setStatus("Approved");
                    try { shop.setApprovalDate(rs.getTimestamp("ApprovedAt")); } catch (Exception ignore) {}
                    return shop;
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Shops getApprovedShopByEmail(String email) {
        String sql = "SELECT s.* FROM [Shops] s INNER JOIN [Shop] sh ON s.userId = sh.SellerID WHERE sh.Email = ? AND s.IsApproved = 1";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Shops shop = new Shops();
                    shop.setId(rs.getInt("id"));
                    shop.setName(rs.getString("name"));
                    shop.setTax(rs.getString("tax"));
                    shop.setDescribe(rs.getString("describe"));
                    shop.setLogo(rs.getString("logo"));
                    shop.setUserId(rs.getInt("userId"));
                    shop.setStatus("Approved");
                    try { shop.setApprovalDate(rs.getTimestamp("ApprovedAt")); } catch (Exception ignore) {}
                    return shop;
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        Users user = new Users();
        user.setUserID(1);
        List<Integer> testa = Arrays.asList(3, 9);
        DAOUsers test = new DAOUsers();
        test.AddAddress("123", "123", "123", 1);

    }

}
