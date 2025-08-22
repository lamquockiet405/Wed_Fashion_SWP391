/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author lenovo
 */
public class Shops {
    int id;
    String name;
    String tax;
    String describe;
    String logo;
    int userId;
    String status; // Pending, Approved, Rejected
    Date approvalDate;
    String adminNotes;

    public Shops() {
    }

    public Shops(int id, String name, String tax, String describe, String logo, int userId) {
        this.id = id;
        this.name = name;
        this.tax = tax;
        this.describe = describe;
        this.logo = logo;
        this.userId = userId;
        this.status = "Pending"; // Mặc định là Pending
    }

    public Shops(int id, String name, String tax, String describe, String logo, int userId, String status, Date approvalDate, String adminNotes) {
        this.id = id;
        this.name = name;
        this.tax = tax;
        this.describe = describe;
        this.logo = logo;
        this.userId = userId;
        this.status = status;
        this.approvalDate = approvalDate;
        this.adminNotes = adminNotes;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getApprovalDate() {
        return approvalDate;
    }

    public void setApprovalDate(Date approvalDate) {
        this.approvalDate = approvalDate;
    }

    public String getAdminNotes() {
        return adminNotes;
    }

    public void setAdminNotes(String adminNotes) {
        this.adminNotes = adminNotes;
    }

    @Override
    public String toString() {
        return "Shops{" + "id=" + id + ", name=" + name + ", tax=" + tax + ", describe=" + describe + ", logo=" + logo + ", userId=" + userId + ", status=" + status + ", approvalDate=" + approvalDate + ", adminNotes=" + adminNotes + '}';
    }
    
}
