/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.DAO_User;

import DAO.DBcontext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author lenovo
 */
public class DAOUserChangePassword extends DBcontext {

    public void changePassword(String newPassword, int userId) {
        String sql = "UPDATE [dbo].[Customers] SET [Password] = ? WHERE [CustomerID] = ?";
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, newPassword);
            preparedStatement.setInt(2, userId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean checkCurrentPassword(int userId, String currentPassword) {
        String sql = "SELECT 1 FROM [dbo].[Customers] WHERE [CustomerID] = ? AND [Password] = ?";
        boolean isPassword = false;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, currentPassword);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    isPassword = true;
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return isPassword;
    }
}
