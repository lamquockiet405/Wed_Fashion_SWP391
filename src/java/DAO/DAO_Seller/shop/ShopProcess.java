/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.DAO_Seller.shop;

import Model.Shop;
import java.sql.*;

public class ShopProcess extends DAO.DAO {

    public static ShopProcess INSTANCE = new ShopProcess();

    private ShopProcess() {
    }

    public Shop read(int userId) {
        Shop shop = null;
        String sql = "SELECT * FROM [Shops] WHERE [userId] = ? ";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                shop = new Shop(rs.getInt("id"), rs.getString("name"), rs.getString("tax"),
                        rs.getString("describe"), rs.getString("logo"), rs.getInt("userId"));
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return shop;
    }

    public Shop read(String userId) {
        Shop shop = null;
        String sql = "SELECT * FROM [Shops] WHERE [userId] = ? ";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                shop = new Shop(rs.getInt("id"), rs.getString("name"), rs.getString("tax"),
                        rs.getString("describe"), rs.getString("logo"), rs.getInt("userId"));
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return shop;
    }

    public Shop getShopById(int id) {
        Shop shop = new Shop();
        String sql = "SELECT * FROM [Shops] WHERE [id] = ? ";

        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                shop.setId(rs.getInt("id"));
                shop.setName(rs.getString("name"));
                shop.setTax(rs.getString("tax"));
                shop.setDescribe(rs.getString("describe"));
                shop.setLogo(rs.getString("logo"));
                shop.setUserId(rs.getInt("userId"));
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return shop;
    }

    public static void main(String[] args) {
        System.out.println(ShopProcess.INSTANCE.read(1).toString());
    }

    private boolean isShopNameDuplicate(Shop shop) {
        if (shop == null) {
            return false;
        }
        String sql = "SELECT COUNT(*) FROM [Shops] WHERE [name] LIKE ? AND [id] != ?";
        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            ps.setString(1, "%" + shop.getName() + "%");
            ps.setInt(2, shop.getId());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; 
                }
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return false;
    }

    public void update(Shop shop) {
        if (shop != null) {
            if (isShopNameDuplicate(shop)) {
                throw new IllegalArgumentException("Shop name already exists");
            } else {
                String sql = "Update [Shops] set [name] = ?, [tax] = ?, [describe] = ?, [logo] = ? where [id] = ?";
                try {
                    int index = 1;
                    PreparedStatement ps = this.conn.prepareStatement(sql);
                    ps.setString(index++, shop.getName());
                    ps.setString(index++, shop.getTax());
                    ps.setString(index++, shop.getDescribe());
                    ps.setString(index++, shop.getLogo());
                    ps.setInt(index++, shop.getId());
                    ps.execute();
                } catch (SQLException e) {
                    this.status = e.getMessage();
                }
            }
        }
    }

    public Shop getShopByUserId(int userID) {
        Shop shop = new Shop();
        String sql = "SELECT * FROM [Shops] WHERE [userId] = ? ";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                shop.setId(rs.getInt("id"));
                shop.setName(rs.getString("name"));
                shop.setTax(rs.getString("tax"));
                shop.setDescribe(rs.getString("describe"));
                shop.setLogo(rs.getString("logo"));
                shop.setUserId(rs.getInt("userId"));
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return shop;
    }
    
}
