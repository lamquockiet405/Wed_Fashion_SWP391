/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.DAO_User;

import DAO.DBcontext;
import Model.Users;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DAOForgotPassword extends DBcontext {
    public Users getUserById(int id) {
        String sql = "select * from [Customers] where CustomerID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Users ac = new Users(
                        rs.getInt("CustomerID"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Address"),
                        String.valueOf(rs.getDate("DateOfBirth")),
                        rs.getBoolean("Gender"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Image"),
                        "Customer",
                        rs.getString("Status"),
                        String.valueOf(rs.getTimestamp("CreatedAt"))
                );
                return ac;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean checkUserbyEmail(String email) {
        String query = "SELECT 1 FROM Customers WHERE Email = ?";
        try (Connection conn = new DBcontext().getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }

    public Users getUserByEmail(String email) {
        String sql = "SELECT * FROM Customers WHERE Email = ?";
        try (Connection conn = new DBcontext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Users user = new Users(
                            rs.getInt("CustomerID"),
                            rs.getString("Username"),
                            rs.getString("Password"),
                            rs.getString("Email"),
                            rs.getString("FirstName"),
                            rs.getString("LastName"),
                            rs.getString("Address"),
                            String.valueOf(rs.getDate("DateOfBirth")),
                            rs.getBoolean("Gender"),
                            rs.getString("PhoneNumber"),
                            rs.getString("Image"),
                            "Customer",
                            rs.getString("Status"),
                            String.valueOf(rs.getTimestamp("CreatedAt"))
                    );
                    return user;
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi truy vấn user: " + e.getMessage());
        }
        return null;
    }

    public boolean updatePassword(String email, String newPassword) {
        try {
            String sql = "UPDATE [dbo].[Customers] SET [Password] = ? WHERE [Email] = ?";
            try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
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
}
