package com.fleet.controllers;

import com.fleet.utils.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FuelServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
            double liters = Double.parseDouble(request.getParameter("liters"));
            double cost = Double.parseDouble(request.getParameter("cost"));
            String logDate = request.getParameter("logDate");

            Connection conn = DatabaseConnection.getConnection();
            
            String sql = "INSERT INTO fuel_logs (vehicle_id, liters_filled, total_cost, log_date) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, vehicleId);
            stmt.setDouble(2, liters);
            stmt.setDouble(3, cost);
            stmt.setString(4, logDate);
            
            stmt.executeUpdate();
            conn.close();
            
            response.sendRedirect("fuel.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Fuel Log Error: " + e.getMessage());
        }
    }
}