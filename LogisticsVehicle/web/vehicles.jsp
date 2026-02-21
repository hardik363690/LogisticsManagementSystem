<%@ page import="java.sql.*, com.fleet.utils.DatabaseConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Vehicle Registry</title>
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
        <h1>Vehicle Registry</h1>
        <div class="form-card">
            <h3>Register Asset</h3>
            <form action="VehicleServlet" method="POST">
                <input type="text" name="modelName" placeholder="Model (e.g. Tata Prima)" required>
                <input type="text" name="licensePlate" placeholder="Plate (e.g. GJ-04-372B)" required>
                <input type="number" name="capacity" placeholder="Capacity (kg)" required>
                <input type="number" name="odometer" placeholder="Odometer (km)" required>
                <button type="submit">Add to Registry</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Model</th>
                    <th>Plate</th>
                    <th>Capacity</th>
                    <th>Odometer</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Connection conn = DatabaseConnection.getConnection();
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM vehicles ORDER BY vehicle_id DESC");
                        while(rs.next()) {
                            String status = rs.getString("status");
                            String statusClass = status.toLowerCase().replace(" ", "-");
                %>
                <tr>
                    <td><%= rs.getString("model_name") %></td>
                    <td><%= rs.getString("license_plate") %></td>
                    <td><%= rs.getString("max_capacity_kg") %> kg</td>
                    <td><%= rs.getString("odometer") %> km</td>
                    <td><span class="status-pill <%= statusClass %>"><%= status %></span></td>
                </tr>
                <%
                        }
                        conn.close();
                    } catch (Exception e) { out.println("<tr><td colspan='5'>Error</td></tr>"); }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>