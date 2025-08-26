package DAO.DAO_Customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import DAO.DBcontext;
import Model.Chinh.Cart;

/**
 *
 * @author Dell
 */
public class DAOCart extends DBcontext {

    // Thêm sản phẩm vào giỏ hàng
    //checked
    public void addCartItem(Cart cart) {
        String sql = "INSERT INTO Cart (UserID, ProductVariantID, Quantity) VALUES (?, ?, ?)";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cart.getUserID());
            ps.setInt(2, cart.getProductVariantID());
            ps.setInt(3, cart.getQuantity());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Lấy danh sách sản phẩm trong giỏ hàng của một người dùng
    //checked
    public List<Cart> getCartItems(int userID) {
        List<Cart> cartItems = new ArrayList<>();
        String sql = "SELECT * FROM Cart WHERE UserID = ?";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                cartItems.add(new Cart(
                        rs.getInt("CartID"),
                        rs.getInt("UserID"),
                        rs.getInt("ProductVariantID"),
                        rs.getInt("Quantity")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    // Cập nhật số lượng sản phẩm trong giỏ hàng
    //checked
    public boolean updateCartItem(int cartID, int quantity) {
        String sql = "UPDATE Cart SET Quantity = ? WHERE CartID = ?";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, cartID);
            int row = ps.executeUpdate();
            System.out.println("Rows affected" + row);
            return row > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa sản phẩm khỏi giỏ hàng
    //checked
    public void deleteCartItem(int cartID) {
        String sql = "DELETE FROM Cart WHERE CartID = ?";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cartID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int countCartItems(int userID) {
        String sql = "SELECT COUNT(*) FROM Cart WHERE UserID = ?";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Lấy giá trị COUNT từ cột đầu tiên
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Trả về 0 nếu có lỗi xảy ra
    }

    // Hàm main để kiểm tra các phương thức
    public static void main(String[] args) {

        DAOCart daoCart = new DAOCart();
//        
//        // Thêm sản phẩm vào giỏ hàng
        int cartCount = daoCart.countCartItems(1);
        System.out.println("Số lượng sản phẩm trong giỏ hàng: " + cartCount);

//        // Lấy danh sách giỏ hàng
//        List<Cart> cartItems = daoCart.getCartItems(1);
//        System.out.println("Danh sách giỏ hàng:");
//        for (Cart item : cartItems) {
//            System.out.println(item);
//        }
//        
        // Cập nhật số lượng sản phẩm
//        boolean pc = daoCart.updateCartItem(3, 5);
//        System.out.println("Cập nhật số lượng sản phẩm thành công!" + pc);
//        
//        // Xóa sản phẩm khỏi giỏ hàng
//        daoCart.deleteCartItem(2);
//        System.out.println("Xóa sản phẩm khỏi giỏ hàng thành công!");
    }
}
