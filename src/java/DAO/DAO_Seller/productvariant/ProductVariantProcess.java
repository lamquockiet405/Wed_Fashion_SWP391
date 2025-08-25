/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.DAO_Seller.productvariant;

import Model.ProductVariant;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import DAO.DBcontext;

public class ProductVariantProcess extends DAO.DAO {

    public static ProductVariantProcess INSTANCE = new ProductVariantProcess();

    private ProductVariantProcess() {
    }

    public boolean updateStockQuantity(int quantity, int pvId) {
        boolean isUpdate = false;
        String sql = "UPDATE [ProductsVariant] SET [StockQuantity] = ? WHERE [ProductVariantID] = ?";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, pvId);
            int rowUpdate = ps.executeUpdate();
            if (rowUpdate > 0) {
                isUpdate = true;
            }
            ps.close();
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return isUpdate;
    }

    public ProductVariant getProductVariantById(int pvId) {
        ProductVariant pv = null;
        String sql = "SELECT [ProductVariantID], [ProductVariantName], [ProductID], [Price], [StockQuantity], [Image], [status] FROM [ProductsVariant] WHERE [ProductVariantID] = ?";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, pvId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                pv = new ProductVariant();
                pv.setProductVariantId(rs.getInt("ProductVariantID"));
                pv.setProductId(rs.getInt("ProductID"));
                pv.setProductVariantName(rs.getString("ProductVariantName"));
                pv.setProductId(rs.getInt("ProductID"));
                pv.setPrice(rs.getFloat("Price"));
                pv.setStockQuantity(rs.getInt("StockQuantity"));
                pv.setImage(rs.getString("Image"));
                pv.setStatus(rs.getInt("status"));
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return pv;
    }
    
    public ProductVariant getProductVariantById(String pvId) {
        ProductVariant pv = null;
        String sql = "SELECT [ProductVariantID], [ProductVariantName], [ProductID], [Price], [StockQuantity], [Image], [status] FROM [ProductsVariant] WHERE [ProductVariantID] = ?";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setString(1, pvId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                pv = new ProductVariant();
                pv.setProductVariantId(rs.getInt("ProductVariantID"));
                pv.setProductId(rs.getInt("ProductID"));
                pv.setProductVariantName(rs.getString("ProductVariantName"));
                pv.setProductId(rs.getInt("ProductID"));
                pv.setPrice(rs.getFloat("Price"));
                pv.setStockQuantity(rs.getInt("StockQuantity"));
                pv.setImage(rs.getString("Image"));
                pv.setStatus(rs.getInt("status"));
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return pv;
    }

    public static void main(String[] args) {
        System.out.println(ProductVariantProcess.INSTANCE.getProductVariantById("1"));
    }

    public List<ProductVariant> read(int idProduct) {
        List<ProductVariant> listProductVariant = new ArrayList<>();
        String sql = "SELECT [ProductVariantID], [ProductVariantName], [ProductID], [Price], [StockQuantity], [Image], [status] FROM [ProductsVariant] WHERE [ProductID] = ? and [status] = ?;";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, idProduct);
            ps.setInt(2, 1);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductVariant productVariant = new ProductVariant();
                productVariant.setProductVariantId(rs.getInt("ProductVariantID"));
                productVariant.setProductVariantName(rs.getString("ProductVariantName"));
                productVariant.setProductId(rs.getInt("ProductID"));
                productVariant.setPrice(rs.getFloat("Price"));
                productVariant.setStockQuantity(rs.getInt("StockQuantity"));
                productVariant.setImage(rs.getString("Image"));
                productVariant.setStatus(rs.getInt("status"));
                listProductVariant.add(productVariant);
            }
            ps.close();
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return listProductVariant;
    }

    public List<ProductVariant> read(String idProduct) {
        List<ProductVariant> listProductVariant = new ArrayList<>();
        String sql = "SELECT [ProductVariantID], [ProductVariantName], [ProductID], [Price], [StockQuantity], [Image], [status] FROM [ProductsVariant] WHERE [ProductID] = ? and [status] = ?;";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setString(1, idProduct);
            ps.setInt(2, 1);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductVariant productVariant = new ProductVariant();
                productVariant.setProductVariantId(rs.getInt("ProductVariantID"));
                productVariant.setProductVariantName(rs.getString("ProductVariantName"));
                productVariant.setProductId(rs.getInt("ProductID"));
                productVariant.setPrice(rs.getFloat("Price"));
                productVariant.setStockQuantity(rs.getInt("StockQuantity"));
                productVariant.setImage(rs.getString("Image"));
                productVariant.setStatus(rs.getInt("status"));
                listProductVariant.add(productVariant);
            }
            ps.close();
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return listProductVariant;
    }

    private boolean updateProductVariant(List<ProductVariant> productVariants) throws SQLException {
        String sql = "UPDATE [ProductsVariant] SET [ProductVariantName] = ?, [Price] = ?, [StockQuantity] = ?, [Image] = ?, [Status] = ? "
                + "WHERE [ProductVariantId] = ? AND [ProductID] = ?";

        try (Connection connection = new DBcontext().getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            for (ProductVariant variant : productVariants) {
                int paramIndex = 1;
                ps.setString(paramIndex++, variant.getProductVariantName() != null ? variant.getProductVariantName() : "");
                ps.setFloat(paramIndex++, variant.getPrice());
                ps.setInt(paramIndex++, variant.getStockQuantity());
                ps.setString(paramIndex++, variant.getImage() != null ? variant.getImage() : "");
                ps.setInt(paramIndex++, variant.getStatus());
                ps.setInt(paramIndex++, variant.getProductVariantId());
                ps.setInt(paramIndex++, variant.getProductId());
                ps.addBatch();
            }
            int[] rowsAffected = ps.executeBatch();
            boolean isSuccessful = true;
            for (int rows : rowsAffected) {
                if (rows == Statement.EXECUTE_FAILED) {
                    isSuccessful = false;
                    break;
                }
            }
            return isSuccessful;
        } catch (SQLException e) {
            this.status = "Error updating product variants" + e.getMessage();
            throw e;
        }
    }

    private boolean addProductVariant(List<ProductVariant> productVariantList) throws SQLException {
        return addProductVariant(productVariantList, null);
    }
    
    private boolean addProductVariant(List<ProductVariant> productVariantList, Connection connection) throws SQLException {
        String sql = "INSERT INTO [ProductsVariant] ([ProductVariantName], [Price], [StockQuantity], [Image], [ProductID], [Status]) VALUES (?, ?, ?, ?, ?, ?)";
        boolean check = false;
        
        // Sử dụng connection được truyền vào hoặc tạo mới
        Connection conn = connection != null ? connection : new DBcontext().getConnection();
        boolean shouldCloseConnection = connection == null;
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            System.out.println("Debug - Adding " + productVariantList.size() + " variants");
            for (ProductVariant pv : productVariantList) {
                int paramIndex = 1;
                ps.setString(paramIndex++, pv.getProductVariantName());
                ps.setFloat(paramIndex++, pv.getPrice());
                ps.setInt(paramIndex++, pv.getStockQuantity());
                ps.setString(paramIndex++, pv.getImage());
                ps.setInt(paramIndex++, pv.getProductId());
                ps.setInt(paramIndex++, pv.getStatus());
                ps.addBatch();
                System.out.println("Debug - Added to batch: " + pv.getProductVariantName());
            }
            int[] rowsAffected = ps.executeBatch();
            System.out.println("Debug - Batch executed, rows affected: " + rowsAffected.length);
            check = true;
            for (int i = 0; i < rowsAffected.length; i++) {
                System.out.println("Debug - Row " + i + " affected: " + rowsAffected[i]);
                if (rowsAffected[i] == Statement.EXECUTE_FAILED) {
                    this.status = "Batch execution failed for record " + i;
                    check = false;
                    break;
                }
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
            System.out.println("Debug - SQL Exception: " + e.getMessage());
            throw e;
        } finally {
            if (shouldCloseConnection && conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    System.out.println("Debug - Error closing connection: " + e.getMessage());
                }
            }
        }
        return check;
    }

    /**
     * Divide data into different places to add update and delete product
     * variant
     *
     * @param productVariantListRead origin value read from database
     * @param productVariantList new value user action
     * @return true if update is success full
     */
    private boolean processValueUpdate(List<ProductVariant> productVariantListRead, List<ProductVariant> productVariantList) {
        // Tạo Map từ danh sách cũ để tra cứu nhanh
        Map<Integer, ProductVariant> oldVariantsMap = new HashMap<>();
        for (ProductVariant oldVariant : productVariantListRead) {
            oldVariantsMap.put(oldVariant.getProductVariantId(), oldVariant);
        }

        // Danh sách để lưu các hành động SQL
        List<ProductVariant> toInsert = new ArrayList<>();
        List<ProductVariant> toUpdate = new ArrayList<>();
        List<ProductVariant> toDelete = new ArrayList<>();

        for (ProductVariant productVariant : productVariantList) {
            // add new
            if (!oldVariantsMap.containsKey(productVariant.getProductVariantId())) {
                productVariant.setStatus(1);
                toInsert.add(productVariant);
            } else { // update
                productVariant.setStatus(1);
                toUpdate.add(productVariant);
                oldVariantsMap.remove(productVariant.getProductVariantId());
            }
        }

        // delete
        for (ProductVariant productVariant : oldVariantsMap.values()) {
            productVariant.setStatus(0);
            toDelete.add(productVariant);
        }

        boolean isUpdate = true;

        try {
            updateProductVariant(toInsert, toUpdate, toDelete);
        } catch (SQLException e) {
            this.status = e.getMessage();
            isUpdate = false;
        }

        return isUpdate;
    }

    private boolean updateProductVariant(List<ProductVariant> toInsert, List<ProductVariant> toUpdate, List<ProductVariant> toDelete) throws SQLException {
        try {
            this.conn.setAutoCommit(false);

            if (!toInsert.isEmpty()) {
                if (!addProductVariant(toInsert)) {
                    this.conn.rollback();
                    return false;
                }
            }
            if (!toUpdate.isEmpty()) {
                if (!updateProductVariant(toUpdate)) {
                    this.conn.rollback();
                    return false;
                }
            }
            if (!toDelete.isEmpty()) {
                if (!updateProductVariant(toDelete)) {
                    this.conn.rollback();
                    return false;
                }
            }
            this.conn.commit();
            return true;
        } catch (SQLException e) {
            this.status = "Update failed: " + e.getMessage();

            try {
                this.conn.rollback();
            } catch (SQLException rollbackEx) {
                this.status += "; Rollback failed: " + rollbackEx.getMessage();
            }

            return false;
        } finally {
            this.conn.setAutoCommit(true);
        }
    }

    public void update(List<ProductVariant> productVariantListRead, List<ProductVariant> productVariantList) {
        if (!productVariantList.isEmpty()) {
            if (!processValueUpdate(productVariantListRead, productVariantList)) {
                throw new IllegalArgumentException("Update failed! Please try again.");
            }
        }
    }

    private boolean addProductVariantTransection(List<ProductVariant> productVariantList) throws SQLException {
        try (Connection connection = new DBcontext().getConnection()) {
            connection.setAutoCommit(false);
            if (!addProductVariant(productVariantList, connection)) {
                connection.rollback();
                return false;
            }
            connection.commit();
            return true;
        } catch (SQLException e) { // if error callback value
            this.status = e.getMessage();
            return false;
        }
    }

    public void add(List<ProductVariant> productVariantList) throws SQLException {
        if (!productVariantList.isEmpty()) {
            if (!addProductVariantTransection(productVariantList)) {
                throw new SQLException("Update failed! Please try again.");
            }
        }
    }
}
