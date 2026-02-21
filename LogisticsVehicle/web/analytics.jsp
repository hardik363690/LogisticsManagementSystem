<%@ page import="java.sql.*, com.fleet.utils.DatabaseConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Analytics & Reports</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="sidebar">
        <h2>Fleet Manager</h2>
        <a href="dashboard.jsp">Command Center</a>
        <a href="analytics.jsp">Analytics & Reports</a>
        <a href="login.html">Logout</a>
    </div>

    <div class="main-content">
        <h1>Operational Analytics</h1>
        <div class="kpi-grid">
            <div class="kpi-card">
                <h3>Total Fuel Spend</h3>
                <div class="number">
                    <%
                        try (Connection conn = DatabaseConnection.getConnection();
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery("SELECT SUM(total_cost) AS total FROM fuel_logs")) {
                            if(rs.next()) out.print("$" + String.format("%.2f", rs.getDouble("total")));
                        } catch (Exception e) { out.print("$0.00"); }
                    %>
                </div>
            </div>
        </div>
    </div>
</body>
</html>