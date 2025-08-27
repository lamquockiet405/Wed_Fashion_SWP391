/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author lenovo
 */
public class DBcontext {

    public Connection conn = null;

    public DBcontext(String url, String user, String pass) {
        try {
            // call Driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            //connect
            conn = DriverManager.getConnection(url, user, pass);
            System.out.println("connected");
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public ResultSet getData(String sql) {
        ResultSet rs = null;
        Statement state;
        try {
            state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs = state.executeQuery(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DBcontext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    public Connection getConnection()
    {
        try {
            // Edit URL , username, password to authenticate with your MS SQL Server

            String url = "jdbc:sqlserver://localhost:1433;databaseName=ecommerce_platform_v2";

            String username = "sa";
            String password = "123";


            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
             return DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex);
            return null;
        }
    }


    public DBcontext() {
        this("jdbc:sqlserver://localhost\\SQLEXPRESS:1433;databaseName=ecommerce_platform_v2",
                "sa", "123");
    }

    public static void main(String[] args) {
        new DBcontext();
    }
}
