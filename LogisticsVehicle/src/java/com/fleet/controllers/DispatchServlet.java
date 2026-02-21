package com.fleet.controllers;

import com.fleet.utils.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DispatchServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
            int driverId = Integer.parseInt(request.getParameter("driverId"));
            double cargoWeight = Double.parseDouble(request.getParameter("cargoWeight"));

            Connection conn = DatabaseConnection.getConnection();
            
            // Step 1: Check Vehicle Capacity
            String checkCapacitySql = "SELECT max_capacity_kg FROM vehicles WHERE vehicle_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkCapacitySql);
            checkStmt.setInt(1, vehicleId);
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next() && cargoWeight > rs.getDouble("max_capacity_kg")) {
                response.getWriter().println("<h1>Error: Cargo Weight exceeds Vehicle Capacity!</h1>");
                conn.close();
                return; 
            }

            // Step 2: Create Trip Record
            String tripSql = "INSERT INTO trips (vehicle_id, driver_id, cargo_weight_kg, status, revenue) VALUES (?, ?, ?, 'Dispatched', 0.00)";
            PreparedStatement tripStmt = conn.prepareStatement(tripSql);
            tripStmt.setInt(1, vehicleId);
            tripStmt.setInt(2, driverId);
            tripStmt.setDouble(3, cargoWeight);
            tripStmt.executeUpdate();

            // Step 3: Update Statuses
            conn.prepareStatement("UPDATE vehicles SET status = 'On Trip' WHERE vehicle_id = " + vehicleId).executeUpdate();
            conn.prepareStatement("UPDATE drivers SET status = 'On Trip' WHERE driver_id = " + driverId).executeUpdate();

            conn.close();
            response.sendRedirect("dispatch.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Dispatch Error: " + e.getMessage());
        }
    }
}