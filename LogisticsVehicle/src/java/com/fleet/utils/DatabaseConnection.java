package com.fleet.utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnection {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Use the older driver name for Java 1.8 / JEE 5
            Class.forName("com.mysql.jdbc.Driver");
            
            // Verify your database name is exactly 'fleet_manager'
            String url = "jdbc:mysql://localhost:3306/fleet_manager";
            String user = "root"; // XAMPP default
            String password = ""; // XAMPP default is usually empty
            
            conn = DriverManager.getConnection(url, user, password);
        } catch (Exception e) {
            // This will print the REAL reason why it's null in your NetBeans Output window
            System.out.println("DATABASE CONNECTION ERROR: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }
}