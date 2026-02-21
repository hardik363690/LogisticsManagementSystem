<%@ page import="java.sql.*, com.fleet.utils.DatabaseConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Fuel & Expenses</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="sidebar">
        <h2>Fleet Manager</h2>
        <a href="dashboard.jsp">Command Center</a>
        <a href="vehicles.jsp">Vehicle Registry</a>
        <a href="dispatch.jsp">Trip Dispatcher</a>
        <a href="maintenance.jsp">Service Logs</a>
        <a href="fuel.jsp">Fuel & Expenses</a>
        <a href="drivers.jsp">Driver Profiles</a>
        <a href="analytics.jsp">Analytics & Reports</a>
        <a href="login.html">Logout</a>
    </div>

    <div class="main-content">
        <h1>Fuel Tracking</h1>
        <div class="form-card">
            <h3>Record Fuel Entry</h3>
            <form action="FuelServlet" method="POST">
                <select name="vehicleId" required>
                    <option value="" disabled selected>Select Vehicle</option>
                    <%
                        try (Connection conn = DatabaseConnection.getConnection();
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery("SELECT vehicle_id, model_name FROM vehicles")) {
                            while(rs.next()) {
                                out.print("<option value='" + rs.getInt("vehicle_id") + "'>" + rs.getString("model_name") + "</option>");
                            }
                        } catch (Exception e) {}
                    %>
                </select>
                <input type="number" name="liters" placeholder="Liters" step="0.1" required>
                <input type="number" name="cost" placeholder="Total Cost ($)" step="0.01" required>
                <input type="date" name="logDate" required>
                <button type="submit">Log Fuel</button>
            </form>
        </div>
    </div>
</body>
</html>