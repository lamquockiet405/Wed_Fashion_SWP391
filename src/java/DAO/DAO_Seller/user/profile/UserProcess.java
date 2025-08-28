/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.DAO_Seller.user.profile;

import DAO.DAO;
import Model.User;
import java.sql.*;

public class UserProcess extends DAO {

    public static final UserProcess INSTANCE = new UserProcess();
    private int index = 1;

    private UserProcess() {
    }

    private User findUserById(int id) {
        User user = null;
        String sql = "SELECT "
                + "[CustomerID] as UserID,"
                + "[Username],"
                + "[Password],"
                + "[Email],"
                + "[FirstName],"
                + "[LastName],"
                + "[Address],"
                + "[DateOfBirth],"
                + "[Gender],"
                + "[PhoneNumber],"
                + "[Image],"
                + "'Customer' as UserRole,"
                + "[CreatedAt] "
                + "FROM [Customers] WHERE [CustomerID] = ?;";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                user = new User(rs.getInt(index++), rs.getString(index++), rs.getString(index++),
                        rs.getString(index++), rs.getString(index++), rs.getString(index++),
                        rs.getString(index++), rs.getDate(index++), rs.getBoolean(index++),
                        rs.getString(index++), rs.getString(index++), rs.getString(index++),
                        rs.getDate(index));
                index = 1;
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return user;
    }

    public User getUser(User user) {
        if (user == null) {
            throw new IllegalArgumentException("An error occurred! Please log in again.");
        }
        User u = findUserById(user.getUserId());
        if (u == null) {
            throw new IllegalArgumentException("An error occurred! Please log in again.");
        }
        return u;
    }

    private boolean update(String id, String firstName, String lastName, String email, String phoneNumber, boolean gender, String address, String dob, String image) {
        String sql = "UPDATE [Customers] SET [FirstName] = ?, [LastName] = ?, [Email] = ?, [PhoneNumber] = ?, [Gender] = ?, [Address] = ?, [DateOfBirth] = ?, [Image] = ? WHERE [CustomerID] = ?";
        boolean check = false;
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setString(index++, firstName);
            ps.setString(index++, lastName);
            ps.setString(index++, email);
            ps.setString(index++, phoneNumber);
            ps.setBoolean(index++, gender);
            ps.setString(index++, address);
            ps.setString(index++, dob);
            ps.setString(index++, image);
            ps.setString(index++, id);
            ps.execute();
            index = 1;
            check = true;
        } catch (SQLException e) {
            throw new RuntimeException("Error updating information.");
        }
        return check;
    }

    public void updateUser(String id, String firstName, String lastName, String email, String phoneNumber, boolean gender, String address, String dob, String image) {
        boolean update = update(id, firstName, lastName, email, phoneNumber, gender, address, dob, image);
        if (!update) throw new IllegalArgumentException();
    }

    public static void main(String[] args) {
        System.out.println(UserProcess.INSTANCE.findUserById(1));
    }
}
