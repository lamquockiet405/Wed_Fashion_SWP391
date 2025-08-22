/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.Chinh;

/**
 *
 * @author lenovo
 */
public class images {
    int id;
    String image;
    int status;
    int ProductID;

    public images() {
    }

    public images(int id, String image, int status, int ProductID) {
        this.id = id;
        this.image = image;
        this.status = status;
        this.ProductID = ProductID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getProductID() {
        return ProductID;
    }

    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    @Override
    public String toString() {
        return "Images{" + "id=" + id + ", image=" + image + ", status=" + status + ", ProductID=" + ProductID + '}';
    }
    
}
