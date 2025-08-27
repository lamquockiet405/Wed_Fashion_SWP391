package DAO.DAO_Seller.product;

import DAO.DAO_Seller.shop.ShopProcess;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Model.Product;
import Model.Shop;

public class ProductProcess extends DAO.DAO {

    private int index = 1;
    public static final ProductProcess INSTANCE = new ProductProcess();

    private ProductProcess() {
    }

    public int getTotalProducts(int pageSize, String status, String search, String sort, int shopId) {
        
        int totalPages = 0;
        int totalRecords;
        StringBuilder countQuery = new StringBuilder("SELECT COUNT(*) FROM Products WHERE 1 = 1 AND [ShopId] = ? ");

        if (status != null) {
            countQuery.append(" AND [status] = ?");
        }
        if (search != null) {
            countQuery.append(" AND ProductName LIKE ?");
        }

        try {
            PreparedStatement countStmt = this.conn.prepareStatement(countQuery.toString());
            index = 1;
            countStmt.setInt(index++, shopId);
            if (status != null) {
                countStmt.setString(index++, status);
            }
            if (search != null) {
                countStmt.setString(index++, "%" + search + "%");
            }
            index = 1;

            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalRecords = countRs.getInt(1);
                totalPages = (int) Math.ceil((double) totalRecords / pageSize);
            }

        } catch (SQLException e) {
            this.status = e.getMessage();
        }

        return totalPages;
    }

    public List<Product> getProductsByPage(int pageNumber, int pageSize, String status, String search, String sort, int shopId) {
        List<Product> productList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT [ProductID], [ProductName], [Description], [Status], [CategoryID], [ShopId], [CreatedAt] FROM [Products] WHERE 1 = 1 AND [ShopId] = ? ");

        if (status != null) {
            sql.append(" and [status] = ?");
        }
        if (search != null) {
            sql.append(" AND ProductName LIKE ?");
        }

        sql.append(" ORDER BY CreatedAt ").append(sort);
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try {
            index = 1;
            PreparedStatement stmt = this.conn.prepareStatement(sql.toString());
            stmt.setInt(index++, shopId);
            if (status != null) {
                stmt.setString(index++, status);
            }
            if (search != null) {
                stmt.setString(index++, "%" + search + "%");
            }
            stmt.setInt(index++, (pageNumber - 1) * pageSize);
            stmt.setInt(index++, pageSize);
            index = 1;
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setStatus(rs.getInt("Status"));
                product.setCategoryId(rs.getInt("CategoryID"));
                product.setShopId(rs.getInt("ShopId"));
                product.setCreatedAt(rs.getDate("CreatedAt"));

                productList.add(product);
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return productList;
    }
    
    public int getTotalProducts(int pageSize, String status, String search, String sort) {
        int totalPages = 0;
        int totalRecords;
        StringBuilder countQuery = new StringBuilder("SELECT COUNT(*) FROM Products WHERE 1 = 1");

        if (status != null) {
            countQuery.append(" AND [status] = ?");
        }
        if (search != null) {
            countQuery.append(" AND ProductName LIKE ?");
        }

        try {
            PreparedStatement countStmt = this.conn.prepareStatement(countQuery.toString());
            index = 1;

            if (status != null) {
                countStmt.setString(index++, status);
            }
            if (search != null) {
                countStmt.setString(index++, "%" + search + "%");
            }
            index = 1;

            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalRecords = countRs.getInt(1);
                totalPages = (int) Math.ceil((double) totalRecords / pageSize);
            }

        } catch (SQLException e) {
            this.status = e.getMessage();
        }

        return totalPages;
    }

    public List<Product> getProductsByPage(int pageNumber, int pageSize, String status, String search, String sort) {
        List<Product> productList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT [ProductID], [ProductName], [Description], [Status], [CategoryID], [ShopId], [CreatedAt] FROM [Products] WHERE 1 = 1 ");

        if (status != null) {
            sql.append(" and [status] = ?");
        }
        if (search != null) {
            sql.append(" AND ProductName LIKE ?");
        }

        sql.append(" ORDER BY CreatedAt ").append(sort);
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try {
            index = 1;
            PreparedStatement stmt = this.conn.prepareStatement(sql.toString());
            if (status != null) {
                stmt.setString(index++, status);
            }
            if (search != null) {
                stmt.setString(index++, "%" + search + "%");
            }
            stmt.setInt(index++, (pageNumber - 1) * pageSize);
            stmt.setInt(index++, pageSize);
            index = 1;
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setStatus(rs.getInt("Status"));
                product.setCategoryId(rs.getInt("CategoryID"));
                product.setShopId(rs.getInt("ShopId"));
                product.setCreatedAt(rs.getDate("CreatedAt"));

                productList.add(product);
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return productList;
    }
//ChangeStatus//
    private boolean UpdateSatusProduct(String status, String idProduct) {
        boolean isUpdate = false;
        String sql = "UPDATE [Products]  SET [Status] = ?  WHERE ProductID = ?;";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setString(2, idProduct);
            ps.execute();
            isUpdate = true;
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return isUpdate;
    }

    public void UpdateToDisable(String status, String idProduct) {
        boolean isUpdate = UpdateSatusProduct(status, idProduct);
        if (!isUpdate) {
            throw new IllegalArgumentException("The system encountered some problems while updating the product. Please try again later.");
        }
    }

    private Product findProductByName(String name) {
        Product product = null;
        String sql = "SELECT [ProductID], [ProductName], [Description], [Status], [CategoryID], [ShopId], [CreatedAt] FROM [Products] WHERE [ProductName] = ?;";
        try {
            try{
                name = name.trim().replaceAll("\\s+", " ");
            } catch (Exception e) {
            }
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setStatus(rs.getInt("Status"));
                product.setCategoryId(rs.getInt("CategoryID"));
                product.setShopId(rs.getInt("ShopId"));
                product.setCreatedAt(rs.getDate("CreatedAt"));
            }
        } catch (SQLException e) {
            product = new Product();
            this.status = e.getMessage();
        }
        return product;
    }

    public int add(String productName, String description, int status, String category, int shopId) {
        String sql = "{call insertProduct (?, ?, ?, ?, ?)}";
        int idProduct = -1;
        if (findProductByName(productName) != null) {
            throw new IllegalArgumentException("Product already exists");
        }
        try {
            index = 1;
            CallableStatement cs = this.conn.prepareCall(sql);
            cs.setString(index++, productName);
            cs.setString(index++, description);
            cs.setInt(index++, status);
            cs.setString(index++, category);
            cs.setInt(index++, shopId);
            index = 1;
            // Thực thi stored procedure
            boolean hasResults = cs.execute();

            // Lấy kết quả từ stored procedure
            if (hasResults) {
                ResultSet rs = cs.getResultSet();
                if (rs.next()) {
                    idProduct = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return idProduct;
    }

    private Product findProductById(String id) {
        Product product = null;
        String sql = "SELECT [ProductID], [ProductName], [Description], [Status], [CategoryID], [ShopId], [CreatedAt] FROM [Products] WHERE [ProductID] = ?;";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setStatus(rs.getInt("Status"));
                product.setCategoryId(rs.getInt("CategoryID"));
                product.setShopId(rs.getInt("ShopId"));
                product.setCreatedAt(rs.getDate("CreatedAt"));
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return product;
    }

    public Product getProductById(String pid) {
        Product product = findProductById(pid);
        if (product == null) {
            throw new IllegalArgumentException("Cannot find product.");
        }
        return product;
    }
//UpdateProduct//
    public void update(String idProduct, String productName, String description) {
        String sql = "UPDATE [Products] SET [ProductName] = ?, [Description] = ? WHERE [ProductID] = ?;";
        try {
            index = 1;
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setString(index++, productName);
            ps.setString(index++, description);
            ps.setString(index++, idProduct);
            index = 1;
            ps.execute();
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
    }

    private boolean hasOrderItemsForProduct(String productId) {
        String sql = "SELECT COUNT(*) FROM [OrderItems] oi "
                + "JOIN [ProductsVariant] pv ON oi.ProductVariantID = pv.ProductVariantID "
                + "WHERE pv.ProductID = ?";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setString(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return true;
    }

    private boolean deleteHard(String productId) {
        try {
            this.conn.setAutoCommit(false);
            // Delete images first
            try (PreparedStatement psImg = this.conn.prepareStatement("DELETE FROM [images] WHERE [ProductID] = ?")) {
                psImg.setString(1, productId);
                psImg.executeUpdate();
            }
            // Delete variants
            try (PreparedStatement psVar = this.conn.prepareStatement("DELETE FROM [ProductsVariant] WHERE [ProductID] = ?")) {
                psVar.setString(1, productId);
                psVar.executeUpdate();
            }
            // Delete product
            int affected;
            try (PreparedStatement psProd = this.conn.prepareStatement("DELETE FROM [Products] WHERE [ProductID] = ?")) {
                psProd.setString(1, productId);
                affected = psProd.executeUpdate();
            }
            if (affected <= 0) {
                this.conn.rollback();
                return false;
            }
            this.conn.commit();
            return true;
        } catch (SQLException e) {
            this.status = e.getMessage();
            try { this.conn.rollback(); } catch (SQLException ignore) {}
            return false;
        } finally {
            try { this.conn.setAutoCommit(true); } catch (SQLException ignore) {}
        }
    }

    private boolean deleteSoft(String productId) {
        try {
            this.conn.setAutoCommit(false);
            int prod;
            try (PreparedStatement ps = this.conn.prepareStatement("UPDATE [Products] SET [Status] = 4 WHERE [ProductID] = ?")) {
                ps.setString(1, productId);
                prod = ps.executeUpdate();
            }
            try (PreparedStatement ps = this.conn.prepareStatement("UPDATE [ProductsVariant] SET [Status] = 0 WHERE [ProductID] = ?")) {
                ps.setString(1, productId);
                ps.executeUpdate();
            }
            if (prod <= 0) {
                this.conn.rollback();
                return false;
            }
            this.conn.commit();
            return true;
        } catch (SQLException e) {
            this.status = e.getMessage();
            try { this.conn.rollback(); } catch (SQLException ignore) {}
            return false;
        } finally {
            try { this.conn.setAutoCommit(true); } catch (SQLException ignore) {}
        }
    }

    public void deleteProduct(String productId) {
        boolean canHardDelete = !hasOrderItemsForProduct(productId);
        boolean ok = canHardDelete ? deleteHard(productId) : deleteSoft(productId);
        if (!ok) {
            throw new IllegalArgumentException("Delete product failed. Please try again.");
        }
    }

    public void deleteProductForce(String productId) {
        try {
            this.conn.setAutoCommit(false);

            // Delete order history details that reference order items of this product (best-effort; column not FK)
            try (PreparedStatement ps = this.conn.prepareStatement(
                    "DELETE FROM [OrderHistoryDetail] WHERE [orderItemId] IN ("
                    + "SELECT oi.OrderItemID FROM [OrderItems] oi "
                    + "JOIN [ProductsVariant] pv ON oi.ProductVariantID = pv.ProductVariantID "
                    + "WHERE pv.ProductID = ?)") ) {
                ps.setString(1, productId);
                ps.executeUpdate();
            }

            // Remove cart items referencing variants of this product to avoid FK block
            try (PreparedStatement ps = this.conn.prepareStatement(
                    "DELETE FROM [Cart] WHERE [ProductVariantID] IN (SELECT [ProductVariantID] FROM [ProductsVariant] WHERE [ProductID] = ?)") ) {
                ps.setString(1, productId);
                ps.executeUpdate();
            }

            // Delete order items referencing variants of this product
            try (PreparedStatement ps = this.conn.prepareStatement(
                    "DELETE FROM [OrderItems] WHERE [ProductVariantID] IN (SELECT [ProductVariantID] FROM [ProductsVariant] WHERE [ProductID] = ?)") ) {
                ps.setString(1, productId);
                ps.executeUpdate();
            }

            // Then reuse hard delete to remove variants, images, product
            if (!deleteHard(productId)) {
                this.conn.rollback();
                throw new IllegalArgumentException("Force delete failed");
            }
            this.conn.commit();
        } catch (SQLException e) {
            this.status = e.getMessage();
            try { this.conn.rollback(); } catch (SQLException ignore) {}
            throw new IllegalArgumentException("Force delete failed: " + e.getMessage());
        } finally {
            try { this.conn.setAutoCommit(true); } catch (SQLException ignore) {}
        }
    }
    
     public static void main(String[] args) {
        ProductProcess test = new ProductProcess();
        test.add("minh", "123123", 1, "a", 1);
    }

}
