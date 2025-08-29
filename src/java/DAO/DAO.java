/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

public class DAO {

    protected java.sql.Connection conn;
    protected String status = "OK";

    public DAO() {
        try {
            conn = new DBcontext().conn;
        } catch (Exception e) {
            status = "Error connect at: " + e.getMessage();
        }
    }
}
