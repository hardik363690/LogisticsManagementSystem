package com.fleet.controllers;

import com.fleet.utils.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DriverServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String driverName = request.getParameter("driverName");
        String licenseExpiry = request.getParameter("licenseExpiry"); 

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO drivers (full_name, license_expiry, status, safety_score) VALUES (?, ?, 'Available', 100)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, driverName);
            stmt.setString(2, licenseExpiry);
            
            stmt.executeUpdate();
            response.sendRedirect("drivers.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error saving driver: " + e.getMessage());
        }
    }
}