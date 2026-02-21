package com.fleet.controllers;

import com.fleet.utils.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class VehicleServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String modelName = request.getParameter("modelName");
        String licensePlate = request.getParameter("licensePlate");
        
        try {
            double capacity = Double.parseDouble(request.getParameter("capacity"));
            int odometer = Integer.parseInt(request.getParameter("odometer"));

            Connection conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO vehicles (model_name, license_plate, max_capacity_kg, odometer, acquisition_cost, status) VALUES (?, ?, ?, ?, 0.00, 'Available')";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, modelName);
            stmt.setString(2, licensePlate);
            stmt.setDouble(3, capacity);
            stmt.setInt(4, odometer);
            
            stmt.executeUpdate();
            conn.close();
            
            response.sendRedirect("vehicles.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error saving vehicle: " + e.getMessage());
        }
    }
}