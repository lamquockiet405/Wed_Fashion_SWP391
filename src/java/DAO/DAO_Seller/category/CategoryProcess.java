package DAO.DAO_Seller.category;

import DAO.DAO;
import Model.Category;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryProcess extends DAO {

    private int index = 1;

    public static final CategoryProcess INSTANCE = new CategoryProcess();

    private CategoryProcess() {
    }

    public Category getCategoryByID(int categoryId) {
        Category category = null;
        String sql = "SELECT * FROM Categories WHERE CategoryID = ? ";
        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    category = new Category();
                    category.setCategoryId(rs.getInt("CategoryID"));
                    category.setCategoryName(rs.getString("CategoryName"));
                    category.setStatus(rs.getInt("status"));
                }
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return category;
    }

    public Category getCategoryByID(String categoryId) {
        Category category = null;
        String sql = "SELECT * FROM Categories WHERE CategoryID = ?";
        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            ps.setString(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    category = new Category();
                    category.setCategoryId(rs.getInt("CategoryID"));
                    category.setCategoryName(rs.getString("CategoryName"));
                    category.setStatus(rs.getInt("status"));
                }
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return category;
    }

    public int getTotalPage(int pageSize, String search, String sort, String status) {
        int totalPages = 0;
        int totalRecords;
        StringBuilder countQuery = new StringBuilder("SELECT COUNT(*) FROM Categories WHERE 1 = 1 ");

        if (status != null) {
            countQuery.append(" AND [status] = ?");
        }
        if (search != null) {
            countQuery.append(" AND CategoryName LIKE ?");
        }

        try {
            PreparedStatement countStmt = this.conn.prepareStatement(countQuery.toString());
            int index = 1; // Khai báo index trong scope của try
            if (status != null) {
                countStmt.setString(index++, status);
            }
            if (search != null) {
                countStmt.setString(index++, "%" + search + "%");
            }

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

    public List<Category> getAllCategories(int page, int pageSize, String search, String sort, String status) {
        List<Category> categoryList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT [CategoryID], [CategoryName], [Status] FROM [Categories] WHERE 1 = 1 ");

        if (status != null) {
            sql.append(" AND [status] = ?");
        }
        if (search != null) {
            sql.append(" AND CategoryName LIKE ?");
        }

        sql.append(" ORDER BY CategoryName ").append(sort);
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try {
            PreparedStatement stmt = this.conn.prepareStatement(sql.toString());
            int index = 1; // Khai báo index trong scope của try
            if (status != null) {
                stmt.setString(index++, status);
            }
            if (search != null) {
                stmt.setString(index++, "%" + search + "%");
            }
            stmt.setInt(index++, (page - 1) * pageSize);
            stmt.setInt(index++, pageSize);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                category.setStatus(rs.getInt("Status"));
                categoryList.add(category);
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }

        return categoryList;
    }

    public List<Category> getAllCategories() {
        List<Category> categoryList = new ArrayList<>();
        String sql = "SELECT * FROM Categories where [status] = ? ";
        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            ps.setString(1, "1");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Category category = new Category();
                    category.setCategoryId(rs.getInt("CategoryID"));
                    category.setCategoryName(rs.getString("CategoryName"));
                    category.setStatus(rs.getInt("status"));
                    categoryList.add(category);
                }
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return categoryList;
    }

    public static void main(String[] args) {
        System.out.println(CategoryProcess.INSTANCE.getCategoryByID("1").getCategoryName());
    }

    private boolean update(String status, String id) {
        String sql = "update Categories set [status] = ? where CategoryID = ?";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setString(2, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            this.status = e.getMessage();
            return false;
        }
    }

    public void updateStatus(String status, String id) {
        if (!update(status, id)) {
            throw new IllegalArgumentException("The system error! Please try again.");
        }
    }

    private Category findCategory(String categoryName) {
        Category category = null;
        String sql = "select * from Categories where CategoryName = ?";
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setString(1, categoryName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                category = new Category();
                category.setCategoryId(rs.getInt("CategoryID"));
                category.setCategoryName("CategoryName");
                category.setStatus(rs.getInt("status"));
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return category;
    }

    private Category findCategory(String categoryName, int id) {
        Category category = null;
        String sql = "select * from Categories where CategoryName = ? and CategoryID != ?;";
        try {
            try {
                categoryName = categoryName.trim().replaceAll("//s+", " ");
            } catch (Exception e) {
            }
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setString(1, categoryName);
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                category = new Category();
                category.setCategoryId(rs.getInt("CategoryID"));
                category.setCategoryName("CategoryName");
                category.setStatus(rs.getInt("status"));
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return category;
    }

    private boolean add(Category category) {
        if (findCategory(category.getCategoryName()) != null) {
            throw new IllegalArgumentException(category.getCategoryName() + " is already exist.");
        }
        String sql = "insert into [Categories] ([CategoryName], [status]) values (?, ?);";
        try {
            PreparedStatement stmt = this.conn.prepareStatement(sql);
            stmt.setString(1, category.getCategoryName());
            stmt.setInt(2, category.getStatus());
            int rowsAffected = stmt.executeUpdate();
            stmt.close();
            return rowsAffected > 0;
        } catch (SQLException e) {
            this.status = e.getMessage();
            return false;
        }
    }

    private boolean update(Category category) {
        if (findCategory(category.getCategoryName(), category.getCategoryId()) != null) {
            throw new IllegalArgumentException(category.getCategoryName() + " is already exist.");
        }
        String sql = "update [Categories] set CategoryName = ?, [status] = ? where CategoryID = ?;";
        try {
            PreparedStatement stmt = this.conn.prepareStatement(sql);
            stmt.setString(1, category.getCategoryName());
            stmt.setInt(2, category.getStatus());
            stmt.setInt(3, category.getCategoryId());
            int rowsAffected = stmt.executeUpdate();
            stmt.close();
            return rowsAffected > 0;
        } catch (SQLException e) {
            this.status = e.getMessage();
            return false;
        }
    }

    public void addCategory(Category category) {
        if (!add(category)) {
            throw new IllegalArgumentException("The system error! Please try again.");
        }
    }

    public void updateCategory(Category category) {
        if (!update(category)) {
            throw new IllegalArgumentException("The system error! Please try again.");
        }
    }

}
