<%@ page import="java.sql.*, com.fleet.utils.DatabaseConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Trip Dispatcher</title>
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
        <h1>Trip Dispatcher</h1>
        <div class="form-card">
            <form action="DispatchServlet" method="POST">
                <select name="vehicleId" required>
                    <option value="" disabled selected>Select Available Vehicle</option>
                    <%
                        try (Connection conn = DatabaseConnection.getConnection();
                             ResultSet rs = conn.createStatement().executeQuery("SELECT vehicle_id, model_name FROM vehicles WHERE status='Available'")) {
                            while(rs.next()) {
                                out.print("<option value='" + rs.getInt("vehicle_id") + "'>" + rs.getString("model_name") + " (ID: " + rs.getInt("vehicle_id") + ")</option>");
                            }
                        } catch (Exception e) {}
                    %>
                </select>
                <select name="driverId" required>
                    <option value="" disabled selected>Select Available Driver</option>
                    <%
                        try (Connection conn = DatabaseConnection.getConnection();
                             ResultSet rs = conn.createStatement().executeQuery("SELECT driver_id, full_name FROM drivers WHERE status='Available'")) {
                            while(rs.next()) {
                                out.print("<option value='" + rs.getInt("driver_id") + "'>" + rs.getString("full_name") + "</option>");
                            }
                        } catch (Exception e) {}
                    %>
                </select>
                <input type="number" name="cargoWeight" placeholder="Cargo Weight (kg)" required>
                <button type="submit">Dispatch Trip</button>
            </form>
        </div>
    </div>
</body>
</html>