/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

public class Shop {
    private int id; 
    private String name, tax, describe, logo;
    private int userId;

    public Shop() {
    }

    public Shop(int id, String name, String tax, String describe, String logo, int userId) {
        this.id = id;
        this.name = name;
        this.tax = tax;
        this.describe = describe;
        this.logo = logo;
        this.userId = userId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTax() {
        return tax;
    }

    public void setTax(String tax) {
        this.tax = tax;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "Shop{" + "id=" + id + ", name=" + name + ", tax=" + tax + ", describe=" + describe + ", logo=" + logo + ", userId=" + userId + '}';
    }
}
