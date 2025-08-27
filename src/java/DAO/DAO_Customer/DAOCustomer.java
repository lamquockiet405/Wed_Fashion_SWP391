package DAO.DAO_Customer;

import DAO.*;
import Model.Customer;
import Model.Shops;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author lenovo
 */
public class DAOCustomer extends DBcontext {

    public Customer login(String email, String pass) {
        String sql = "SELECT * FROM [Customers] WHERE [Email] = ? AND [Password] = ? AND [Status] = 'Active'";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, email);
            pre.setString(2, pass);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                int CustomerID = rs.getInt("CustomerID");
                String Username = rs.getString("Username");
                String Password = rs.getString("Password");
                String Email = rs.getString("Email");
                String FirstName = rs.getString("FirstName");
                String LastName = rs.getString("LastName");
                String Address = rs.getString("Address");
                Date DateOfBirth = rs.getDate("DateOfBirth");
                Boolean Gender = rs.getBoolean("Gender");
                String PhoneNumber = rs.getString("PhoneNumber");
                String Image = rs.getString("Image");
                String Status = rs.getString("Status");
                Date CreatedAt = rs.getTimestamp("CreatedAt");

                Customer customer = new Customer(CustomerID, Username, Password, Email, FirstName, LastName, Address, DateOfBirth, Gender, PhoneNumber, Image, Status, CreatedAt);
                return customer;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Customer loginByGoogle(String email) {
        String sql = "SELECT * FROM [Customers] WHERE [Email] = ? AND [Status] = 'Active'";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, email);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                int CustomerID = rs.getInt("CustomerID");
                String Username = rs.getString("Username");
                String Password = rs.getString("Password");
                String Email = rs.getString("Email");
                String FirstName = rs.getString("FirstName");
                String LastName = rs.getString("LastName");
                String Address = rs.getString("Address");
                Date DateOfBirth = rs.getDate("DateOfBirth");
                Boolean Gender = rs.getBoolean("Gender");
                String PhoneNumber = rs.getString("PhoneNumber");
                String Image = rs.getString("Image");
                String Status = rs.getString("Status");
                Date CreatedAt = rs.getTimestamp("CreatedAt");

                Customer customer = new Customer(CustomerID, Username, Password, Email, FirstName, LastName, Address, DateOfBirth, Gender, PhoneNumber, Image, Status, CreatedAt);
                return customer;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void signup(String username, String password, String email, String firstName, String lastName, String address, Date dateOfBirth, Boolean gender, String phoneNumber) {
        String sql = "INSERT INTO [Customers] ([Username], [Password], [Email], [FirstName], [LastName], [Address], [DateOfBirth], [Gender], [PhoneNumber], [Status], [CreatedAt]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            pre.setString(2, password);
            pre.setString(3, email);
            pre.setString(4, firstName);
            pre.setString(5, lastName);
            pre.setString(6, address);
            pre.setDate(7, new java.sql.Date(dateOfBirth.getTime()));
            pre.setBoolean(8, gender);
            pre.setString(9, phoneNumber);
            pre.setString(10, "Active");
            pre.setTimestamp(11, new Timestamp(System.currentTimeMillis()));
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void signupByGoogle(String username, String email, String firstName, String lastName) {
        String sql = "INSERT INTO [Customers] ([Username], [Email], [FirstName], [LastName], [Status], [CreatedAt]) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            pre.setString(2, email);
            pre.setString(3, firstName);
            pre.setString(4, lastName);
            pre.setString(5, "Active");
            pre.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Customer checkExistAccount(String email) {
        String sql = "SELECT * FROM [Customers] WHERE [Email] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, email);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                int CustomerID = rs.getInt("CustomerID");
                String Username = rs.getString("Username");
                String Password = rs.getString("Password");
                String Email = rs.getString("Email");
                String FirstName = rs.getString("FirstName");
                String LastName = rs.getString("LastName");
                String Address = rs.getString("Address");
                Date DateOfBirth = rs.getDate("DateOfBirth");
                Boolean Gender = rs.getBoolean("Gender");
                String PhoneNumber = rs.getString("PhoneNumber");
                String Image = rs.getString("Image");
                String Status = rs.getString("Status");
                Date CreatedAt = rs.getTimestamp("CreatedAt");

                Customer customer = new Customer(CustomerID, Username, Password, Email, FirstName, LastName, Address, DateOfBirth, Gender, PhoneNumber, Image, Status, CreatedAt);
                return customer;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void updateProfile(int customerID, String firstName, String lastName, String address, Date dateOfBirth, Boolean gender, String phoneNumber) {
        String sql = "UPDATE [Customers] SET [FirstName] = ?, [LastName] = ?, [Address] = ?, [DateOfBirth] = ?, [Gender] = ?, [PhoneNumber] = ? WHERE [CustomerID] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, firstName);
            pre.setString(2, lastName);
            pre.setString(3, address);
            pre.setDate(4, new java.sql.Date(dateOfBirth.getTime()));
            pre.setBoolean(5, gender);
            pre.setString(6, phoneNumber);
            pre.setInt(7, customerID);
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void changePassword(int customerID, String newPassword) {
        String sql = "UPDATE [Customers] SET [Password] = ? WHERE [CustomerID] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, newPassword);
            pre.setInt(2, customerID);
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Customer getCustomerById(int customerID) {
        String sql = "SELECT * FROM [Customers] WHERE [CustomerID] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, customerID);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                int CustomerID = rs.getInt("CustomerID");
                String Username = rs.getString("Username");
                String Password = rs.getString("Password");
                String Email = rs.getString("Email");
                String FirstName = rs.getString("FirstName");
                String LastName = rs.getString("LastName");
                String Address = rs.getString("Address");
                Date DateOfBirth = rs.getDate("DateOfBirth");
                Boolean Gender = rs.getBoolean("Gender");
                String PhoneNumber = rs.getString("PhoneNumber");
                String Image = rs.getString("Image");
                String Status = rs.getString("Status");
                Date CreatedAt = rs.getTimestamp("CreatedAt");

                Customer customer = new Customer(CustomerID, Username, Password, Email, FirstName, LastName, Address, DateOfBirth, Gender, PhoneNumber, Image, Status, CreatedAt);
                return customer;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Shops CheckExitShop(int customerID) {
        String sql = "SELECT * FROM [Shops] WHERE [userId] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, customerID);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String tax = rs.getString("tax");
                String describe = rs.getString("describe");
                String logo = rs.getString("logo");
                int userId = rs.getInt("userId");
                String status = rs.getString("status") != null ? rs.getString("status") : "Pending";
                Date approvalDate = rs.getDate("approval_date");
                String adminNotes = rs.getString("admin_notes");

                Shops shop = new Shops(id, name, tax, describe, logo, userId, status, approvalDate, adminNotes);
                return shop;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
