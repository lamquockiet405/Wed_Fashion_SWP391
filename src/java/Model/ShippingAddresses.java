/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author lenovo
 */
public class ShippingAddresses {
    int id;
    String username;
    String phoneNumber;
    String address;
    boolean status;
    int userId;

    public ShippingAddresses() {
    }

    public ShippingAddresses(int id, String username, String phoneNumber, String address, boolean status, int userId) {
        this.id = id;
        this.username = username;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.status = status;
        this.userId = userId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "ShippingAddresses{" + "id=" + id + ", username=" + username + ", phoneNumber=" + phoneNumber + ", address=" + address + ", status=" + status + ", userId=" + userId + '}';
    }
    
    
    
}
