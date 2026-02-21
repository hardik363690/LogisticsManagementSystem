package com.fleet.controllers;

import com.fleet.utils.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MaintenanceServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
            String serviceType = request.getParameter("serviceType");
            double cost = Double.parseDouble(request.getParameter("cost"));
            String serviceDate = request.getParameter("serviceDate");

            Connection conn = DatabaseConnection.getConnection();
            
            // Log Maintenance
            String sql = "INSERT INTO maintenance_logs (vehicle_id, service_type, cost, service_date) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, vehicleId);
            stmt.setString(2, serviceType);
            stmt.setDouble(3, cost);
            stmt.setString(4, serviceDate);
            stmt.executeUpdate();

            // Update Vehicle Status
            String updateSql = "UPDATE vehicles SET status = 'In Shop' WHERE vehicle_id = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setInt(1, vehicleId);
            updateStmt.executeUpdate();

            conn.close();
            response.sendRedirect("maintenance.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Maintenance Error: " + e.getMessage());
        }
    }
}