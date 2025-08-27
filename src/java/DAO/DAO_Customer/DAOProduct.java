/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.DAO_Customer;

import DAO.*;
import Model.Chinh.Categories;
import Model.Chinh.MinMaxPrice;
import Model.Chinh.Products;
import Model.Chinh.ProductsVariant;
import Model.Users;
import Model.Chinh.images;
import Model.Shop;
import Model.TotalOrderItemsByProduct;

import Model.Users;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Dell
 */
public class DAOProduct extends DBcontext {

    // Lấy danh sách tất cả sản phẩm
    //checked
    public List<Products> getAllProducts() {
        List<Products> productList = new ArrayList<>();
        String sql = "SELECT * FROM Products Where status = 1 ";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Products product = new Products(
                            rs.getInt("productID"),
                            rs.getString("productName"),
                            rs.getString("description"),
                            rs.getInt("status"),
                            rs.getInt("categoryID"),
                            rs.getInt("shopId"),
                            rs.getTimestamp("createdAt")
                    );
                    productList.add(product);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách sản phẩm: " + e.getMessage());
        }
        return productList;
    }
// tạo một giá trị GUID (Globally Unique Identifier) ngẫu nhiên cho mỗi dòng.

    public List<Products> getRandomProducts(int limit) {
        List<Products> productList = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " * FROM Products WHERE status = 1 ORDER BY NEWID()";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Products product = new Products(
                            rs.getInt("productID"),
                            rs.getString("productName"),
                            rs.getString("description"),
                            rs.getInt("status"),
                            rs.getInt("categoryID"),
                            rs.getInt("shopId"),
                            rs.getTimestamp("createdAt")
                    );
                    productList.add(product);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách sản phẩm ngẫu nhiên: " + e.getMessage());
        }
        return productList;
    }

    public List<images> getAllImagesDistinctList() {
        List<images> imagesList = new ArrayList<>();
        String sql = "SELECT i.id, i.image, i.status, i.productID\n"
                + "FROM Images i\n"
                + "JOIN (\n"
                + "    SELECT MIN(id) AS min_id FROM Images GROUP BY productID\n"
                + ") AS temp ON i.id = temp.min_id Where i.status = 1;";

        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    images image = new images(
                            rs.getInt("id"),
                            rs.getString("image"),
                            rs.getInt("status"),
                            rs.getInt("ProductID")
                    );
                    imagesList.add(image);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy ảnh không trùng productID: " + e.getMessage());
        }
        return imagesList;
    }

    // lấy một ảnh tiêu biểu chõ mỗi id product
//lấy ID nhỏ nhất của mỗi nhóm.
//    checked
    public images getImageDistinctByID(int imageId) {
        images image = null;
        String sql = "SELECT i.id, i.image, i.status, i.productID\n"
                + "FROM Images i\n"
                + "JOIN (\n"
                + "    SELECT MIN(id) AS min_id FROM Images GROUP BY productID\n"
                + ") AS temp ON i.id = temp.min_id\n"
                + "WHERE i.productID = ? AND i.status = 1;";

        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, imageId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    image = new images(
                            rs.getInt("id"),
                            rs.getString("image"),
                            rs.getInt("status"),
                            rs.getInt("ProductID")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy ảnh không trùng productID: " + e.getMessage());
        }
        return image;
    }

//checked
    public List<MinMaxPrice> getPriceMinMax() {
        List<MinMaxPrice> prices = new ArrayList<>();
        String sql = "SELECT productID, MIN(price) AS min_price, MAX(price) AS max_price\n"
                + "FROM ProductsVariant\n"
                + "GROUP BY productID;";

        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MinMaxPrice price = new MinMaxPrice(
                            rs.getInt("productid"),
                            rs.getFloat("min_price"),
                            rs.getFloat("max_price")
                    );
                    prices.add(price);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy ảnh  " + e.getMessage());
        }
        return prices;
    }

    //checked
    public images getImagesByImgId(int imgId) {
        String sql = "SELECT * FROM images WHERE id = ?";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, imgId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    images image = new images(
                            rs.getInt("id"),
                            rs.getString("image"),
                            rs.getInt("status"),
                            rs.getInt("ProductID")
                    );
                    return image;
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách ảnh: " + e.getMessage());
        }
        return null;
    }

    // Lấy danh sách ảnh theo productID
    //checked
    public List<images> getImagesByProductId(int productId) {
        List<images> images = new ArrayList<>();
        String sql = "SELECT * FROM images WHERE productID = ?";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    images image = new images(
                            rs.getInt("id"),
                            rs.getString("image"),
                            rs.getInt("status"),
                            rs.getInt("ProductID")
                    );
                    images.add(image);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách ảnh: " + e.getMessage());
        }
        return images;
    }
//checked

    public List<Categories> getAllCategories() {
        List<Categories> categories = new ArrayList<>();
        String sql = "SELECT * FROM Categories WHERE status = 1 ";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Categories category = new Categories(
                            rs.getInt("categoryID"),
                            rs.getString("categoryName"),
                            rs.getInt("status")
                    );
                    categories.add(category);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách danh mục: " + e.getMessage());
        }
        return categories;
    }
//checked

    public List<Products> getFilteredProducts(String searchText, String categoryID, Float minPrice, Float maxPrice, String sort) {
        List<Products> products = new ArrayList<>();
        String sql = "SELECT \n"
                + "    p.productID, \n"
                + "    p.productName, \n"
                + "	p.Description,\n"
                + "	p.Status,\n"
                + "    p.categoryID, \n"
                + "	p.ShopId,\n"
                + "	p.createdAt ,\n"
                + "    pv.price, \n"
                + "    pv.StockQuantity \n"
                + "   \n"
                + "FROM Products p\n"
                + "JOIN ProductsVariant pv ON p.productID = pv.productID\n"
                + "WHERE 1 = 1 AND p.Status = 1";

        if (searchText != null && !searchText.isEmpty()) {
            sql += "AND p.productName LIKE ? ";
        }
        if (categoryID != null && !categoryID.isEmpty()) {
            sql += "AND p.categoryID = ? ";
        }
        if (minPrice != null) {
            sql += "AND pv.price >= ? ";
        }
        if (maxPrice != null) {
            sql += "AND pv.price <= ? ";
        }

        if ("price_asc".equals(sort)) {
            sql += "ORDER BY pv.price ASC ";
        } else if ("price_desc".equals(sort)) {
            sql += "ORDER BY pv.price DESC ";
        } else if ("newest".equals(sort)) {
            sql += "ORDER BY p.createdAt DESC ";
        }
//        else if ("bestseller".equals(sort)) {
//            sql += "ORDER BY pv.stock DESC ";
//        }

        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {

            int paramIndex = 1;

            if (searchText != null && !searchText.isEmpty()) {
                ps.setString(paramIndex++, "%" + searchText + "%");
            }
            if (categoryID != null && !categoryID.isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(categoryID));
            }
            if (minPrice != null) {
                ps.setFloat(paramIndex++, minPrice);
            }
            if (maxPrice != null) {
                ps.setFloat(paramIndex++, maxPrice);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products product = new Products(
                        rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getString("description"),
                        rs.getInt("status"),
                        rs.getInt("categoryID"),
                        rs.getInt("shopId"),
                        rs.getTimestamp("createdAt")
                );
                products.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
//checked 

    public ProductsVariant getVariantsByVariantId(int productVariantID) {
        String sql = "SELECT * FROM ProductsVariant WHERE productVariantID = ?";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productVariantID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProductsVariant variant = new ProductsVariant(
                            rs.getInt("productVariantID"),
                            rs.getString("productVariantName"),
                            rs.getInt("productID"),
                            rs.getFloat("price"),
                            rs.getInt("stockQuantity"),
                            rs.getString("image")
                    );
                    return variant;
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách biến thể: " + e.getMessage());
        }
        return null;
    }
//checked 

    public List<ProductsVariant> getVariantsByProductId(int productId) {
        List<ProductsVariant> variants = new ArrayList<>();
        String sql = "SELECT * FROM ProductsVariant WHERE productID = ?";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductsVariant variant = new ProductsVariant(
                            rs.getInt("productVariantID"),
                            rs.getString("productVariantName"),
                            rs.getInt("productID"),
                            rs.getFloat("price"),
                            rs.getInt("stockQuantity"),
                            rs.getString("image")
                    );
                    variants.add(variant);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách biến thể: " + e.getMessage());
        }
        return variants;
    }
//checked 

    public List<ProductsVariant> getAllVariants() {
        List<ProductsVariant> variants = new ArrayList<>();
        String sql = "SELECT * FROM ProductsVariant";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductsVariant variant = new ProductsVariant(
                            rs.getInt("productVariantID"),
                            rs.getString("productVariantName"),
                            rs.getInt("productID"),
                            rs.getFloat("price"),
                            rs.getInt("stockQuantity"),
                            rs.getString("image")
                    );
                    variants.add(variant);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách biến thể: " + e.getMessage());
        }
        return variants;
    }
// Lấy tất cả ảnh từ bảng Images
    //chưa dùng

    public List<images> getAllImages() {
        List<images> imagesList = new ArrayList<>();
        String sql = "SELECT * FROM images";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    images image = new images(
                            rs.getInt("id"),
                            rs.getString("image"),
                            rs.getInt("status"),
                            rs.getInt("ProductID")
                    );
                    imagesList.add(image);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy tất cả ảnh: " + e.getMessage());
        }
        return imagesList;
    }
//checked

    public List<Users> GetUserList() { //// Checked
        List<Users> list = new ArrayList<>();
        String sql = "select * from Users ";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int UserID = rs.getInt(1);
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
                String CreatedAt = rs.getString(14);

                Users user = new Users(UserID, Username, Password, Email, FirstName, LastName, Address, DateOfBirth, Gender, PhoneNumber, Image, UserRole, Status, CreatedAt);

                list.add(user);
            }
            System.out.println(list);
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public Products getProductsById(int keyword) {
        String sql = "SELECT * FROM Products WHERE productID = ?";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, keyword);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Products product = new Products(
                            rs.getInt("productID"),
                            rs.getString("productName"),
                            rs.getString("description"),
                            rs.getInt("status"),
                            rs.getInt("categoryID"),
                            rs.getInt("shopId"),
                            rs.getTimestamp("createdAt")
                    );
                    return product;
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm kiếm sản phẩm: " + e.getMessage());
        }
        return null;
    }

    public List<TotalOrderItemsByProduct> getAllProductsWithTotalOrdered() {
        List<TotalOrderItemsByProduct> products = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, COALESCE(SUM(oi.Quantity), 0) AS TotalOrdered FROM Products p LEFT JOIN ProductsVariant pv ON p.ProductID = pv.ProductID LEFT JOIN OrderItems oi ON pv.ProductVariantID = oi.ProductVariantID GROUP BY p.ProductID, p.ProductName";

        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                TotalOrderItemsByProduct product = new TotalOrderItemsByProduct(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getInt("TotalOrdered")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách sản phẩm: " + e.getMessage());
        }
        return products;
    }

    public List<Shop> getAllShops() {
        List<Shop> shops = new ArrayList<>();
        String query = "SELECT * FROM Shops";
        try (Connection conn = new DBcontext().conn; PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Shop shop = new Shop(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("tax"),
                        rs.getString("describe"),
                        rs.getString("logo"),
                        rs.getInt("userId")
                );
                shops.add(shop);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách sản phẩm: " + e.getMessage());
        }

        return shops;
    }

    // Main method để kiểm tra
    public static void main(String[] args) {
        DAOProduct dao = new DAOProduct();

        List<Shop> shop = dao.getAllShops();
        for (Shop shop1 : shop) {
            System.out.println(shop1.getId());
        }

//Products product = dao.getProductsById(1);
//        if (product != null) {
//            System.out.println("Sản phẩm có ID 1: " + product.getProductName());
//        } else {
//            System.out.println("Không tìm thấy sản phẩm có ID 1");
//        }
////        // Test 1: Lấy tất cả sản phẩm
//        System.out.println("Test 1: Lấy tất cả sản phẩm");
//        List<Products> allProducts = dao.getFilteredProducts(null, null, null, null, null);
//        printProducts(allProducts);
//
//        // Test 2: Tìm sản phẩm theo tên
//        System.out.println("\nTest 2: Tìm sản phẩm chứa 'Laptop'");
//        List<Products> searchByName = dao.getFilteredProducts("iphone", null, null, null, null);
//        printProducts(searchByName);
//
//        // Test 3: Lọc theo danh mục (Ví dụ: categoryID = "1")
//        System.out.println("\nTest 3: Lọc theo danh mục ID 1");
//        List<Products> filterByCategory = dao.getFilteredProducts(null, "1", null, null, null);
//        printProducts(filterByCategory);
//
//        // Test 4: Lọc theo khoảng giá (Ví dụ: 500 đến 1000)
//        System.out.println("\nTest 4: Lọc theo khoảng giá từ 500 đến 1000");
//        List<Products> filterByPrice = dao.getFilteredProducts(null, null, 500.0f, 1000.0f, null);
//        printProducts(filterByPrice);
//
//        // Test 5: Sắp xếp theo giá tăng dần
//        System.out.println("\nTest 5: Sắp xếp theo giá tăng dần");
//        List<Products> sortByPriceAsc = dao.getFilteredProducts(null, null, null, null, "price_asc");
//        printProducts(sortByPriceAsc);
//
//        // Test 6: Sắp xếp theo giá giảm dần
//        System.out.println("\nTest 6: Sắp xếp theo giá giảm dần");
//        List<Products> sortByPriceDesc = dao.getFilteredProducts(null, null, null, null, "price_desc");
//        printProducts(sortByPriceDesc);
//
//        // Test 7: Sắp xếp theo sản phẩm mới nhất
//        System.out.println("\nTest 7: Sắp xếp theo sản phẩm mới nhất");
//        List<Products> sortByNewest = dao.getFilteredProducts(null, null, null, null, "newest");
//        printProducts(sortByNewest);
//
////        // Test 8: Sắp xếp theo sản phẩm bán chạy nhất
////        System.out.println("\nTest 8: Sắp xếp theo sản phẩm bán chạy nhất");
////        List<Products> sortByBestseller = dao.getFilteredProducts(null, null, null, null, "bestseller");
////        printProducts(sortByBestseller);
    }

    // Hàm in danh sách sản phẩm
    private static void printProducts(List<Products> products) {
        if (products.isEmpty()) {
            System.out.println("Không có sản phẩm nào.");
            return;
        }
        for (Products product : products) {
            System.out.println(product);
        }
    }
}
