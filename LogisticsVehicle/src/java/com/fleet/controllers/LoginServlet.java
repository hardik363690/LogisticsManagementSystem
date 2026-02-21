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
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try {
            Connection conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE email=? AND password_hash=? AND role=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            stmt.setString(3, role);
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("user", email);
                response.sendRedirect("dashboard.jsp");
            } else {
                response.sendRedirect("login.html?error=1");
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}