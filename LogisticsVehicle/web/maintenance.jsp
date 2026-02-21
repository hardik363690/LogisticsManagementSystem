<%@ page import="java.sql.*, com.fleet.utils.DatabaseConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Service Logs</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="sidebar">
        <h2>Fleet Manager</h2>
        <a href="dashboard.jsp">Command Center</a>
        <a href="vehicles.jsp">Vehicle Registry</a>
        <a href="maintenance.jsp">Service Logs</a>
        <a href="login.html">Logout</a>
    </div>
    <div class="main-content">
        <h1>Maintenance Logs</h1>
        <div class="form-card">
            <form action="MaintenanceServlet" method="POST">
                <select name="vehicleId" required>
                    <option value="">Select Vehicle (Plate)</option>
                    <%
                        try (Connection conn = DatabaseConnection.getConnection();
                             ResultSet rs = conn.createStatement().executeQuery("SELECT vehicle_id, license_plate FROM vehicles")) {
                            while(rs.next()) {
                                out.print("<option value='"+rs.getInt("vehicle_id")+"'>"+rs.getString("license_plate")+"</option>");
                            }
                        } catch(Exception e) {}
                    %>
                </select>
                <input type="text" name="serviceType" placeholder="Service Type" required>
                <input type="number" name="cost" placeholder="Cost" step="0.01" required>
                <input type="date" name="serviceDate" required>
                <button type="submit">Log Maintenance</button>
            </form>
        </div>
        <table>
            <thead><tr><th>Vehicle ID</th><th>Service</th><th>Date</th><th>Cost</th></tr></thead>
            <tbody>
                <%
                    try (Connection conn = DatabaseConnection.getConnection();
                         ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM maintenance_logs ORDER BY service_date DESC")) {
                        while(rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("vehicle_id") %></td>
                    <td><%= rs.getString("service_type") %></td>
                    <td><%= rs.getDate("service_date") %></td>
                    <td>₹<%= rs.getDouble("cost") %></td>
                </tr>
                <% } } catch(Exception e) {} %>
            </tbody>
        </table>
    </div>
</body>
</html>