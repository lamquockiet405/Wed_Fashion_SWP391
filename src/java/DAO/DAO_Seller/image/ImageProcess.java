package DAO.DAO_Seller.image;

import Model.Image;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ImageProcess extends DAO.DAO {

    public static final ImageProcess INSTANCE = new ImageProcess();

    private ImageProcess() {
    }
    
    private void removeByProductId (int productId) {
        String sql = "DELETE FROM [images] WHERE [ProductID] = ?;";
        
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, productId);
            ps.execute();
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
    }

    public void add(String images, int productID, int status) {
        
        if (images == null || images.isEmpty()) {
            this.status = "image is null";
            return;
        }
        
        removeByProductId(productID);

        String[] imagesArray = images.split("\\|");
        String sql = "INSERT INTO [images] ([image], [status], [ProductID]) VALUES (?, ?, ?)";

        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            for (String img : imagesArray) {
                if (img != null && !img.isBlank()) {
                    ps.setString(1, img);
                    ps.setInt(2, status);
                    ps.setInt(3, productID);
                    ps.addBatch();
                }
            }
            ps.executeBatch();
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
    }

    public void remove(String imageIDs) {
        String sql = "DELETE FROM images WHERE id = ?";
        String[] idArray = imageIDs.split("\\|");
        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            for (String id : idArray) {
                ps.setInt(1, Integer.parseInt(id));
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
    }

    public List<Image> read() {
        List<Image> imageList = new ArrayList<>();
        String sql = "SELECT * FROM images";
        try (PreparedStatement ps = this.conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Image image = new Image();
                image.setId(rs.getInt("id"));
                image.setImage(rs.getString("image"));
                image.setProductId(rs.getInt("ProductID"));
                image.setStatus(rs.getInt("status"));
                imageList.add(image);
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return imageList;
    }

    public Image getTop1ImageByProductID(int productID) {
        String sql = "SELECT TOP 1 * FROM images WHERE ProductID = ? ORDER BY id ASC;";
        Image image = null;
        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                image = new Image();
                image.setId(rs.getInt("id"));
                image.setImage(rs.getString("image"));
                image.setProductId(rs.getInt("ProductID"));
                image.setStatus(rs.getInt("status"));
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return image;
    }

    public List<Image> getAllImagesByProductID(int productID) {
        List<Image> imageList = new ArrayList<>();
        String sql = "SELECT * FROM images WHERE ProductID = ?";
        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Image image = new Image();
                image.setId(rs.getInt("id"));
                image.setImage(rs.getString("image"));
                image.setProductId(rs.getInt("ProductID"));
                image.setStatus(rs.getInt("status"));
                imageList.add(image);
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return imageList;
    }

    public static void main(String[] args) {
        System.out.println(ImageProcess.INSTANCE.getTop1ImageByProductID(2).getImage());
    }
}
