<%@ page import="java.sql.*, com.fleet.utils.DatabaseConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Command Center - Fleet Manager</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* 1. Stop the main page from scrolling */
        .main-content {
            margin-left: 260px;
            padding: 30px;
            height: 100vh; /* Exactly the height of the screen */
            box-sizing: border-box;
            display: flex;
            flex-direction: column; /* Stacks items vertically */
            overflow: hidden; /* Hides the main page scrollbar */
            background-color: #f8fafc;
        }

        /* 2. Create a dedicated scrollable box just for the table */
        .table-scroll-box {
            flex-grow: 1; /* Tells the box to take up all remaining space below the stats */
            overflow-y: auto; /* Adds a scrollbar ONLY to this box */
            margin-top: 15px;
            border: 1px solid #e2e8f0;
            background-color: white;
        }

        /* 3. Keep the table header locked at the top of the scroll box */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0; /* Remove default margin so it sits flush in the box */
        }
        
        table thead th {
            position: sticky;
            top: 0;
            background-color: #34495e;
            color: white;
            z-index: 10;
            padding: 12px;
            text-align: left;
        }

        table td {
            padding: 12px;
            border-bottom: 1px solid #eee;
        }
    </style>
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
        <h1>Command Center</h1>
        
        <div class="kpi-grid">
            <div class="kpi-card">
                <h3>Active Fleet</h3>
                <div class="number">
                    <%
                        try (Connection conn = DatabaseConnection.getConnection();
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS total FROM vehicles")) {
                            if(rs.next()) out.print(rs.getInt("total"));
                        } catch (Exception e) { out.print("0"); }
                    %>
                </div>
            </div>

            <div class="kpi-card">
                <h3>Maintenance Alerts</h3>
                <div class="number">
                    <%
                        try (Connection conn = DatabaseConnection.getConnection();
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS total FROM vehicles WHERE status='In Shop'")) {
                            if(rs.next()) out.print(rs.getInt("total"));
                        } catch (Exception e) { out.print("0"); }
                    %>
                </div>
            </div>

            <div class="kpi-card">
                <h3>Dispatched Trips</h3>
                <div class="number">
                    <%
                        try (Connection conn = DatabaseConnection.getConnection();
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS total FROM trips WHERE status='Dispatched'")) {
                            if(rs.next()) out.print(rs.getInt("total"));
                        } catch (Exception e) { out.print("0"); }
                    %>
                </div>
            </div>
        </div>

        <h2 style="margin-bottom: 5px;">Live Fleet Monitoring</h2>
        
        <div class="table-scroll-box">
            <table>
                <thead>
                    <tr>
                        <th>Vehicle ID</th>
                        <th>Model</th>
                        <th>Current Status</th>
                        <th>License Plate</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try (Connection conn = DatabaseConnection.getConnection();
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery("SELECT * FROM vehicles ORDER BY vehicle_id DESC")) {

                            while(rs.next()) {
                                String status = rs.getString("status");
                                String statusClass = status.toLowerCase().replace(" ", "-");
                    %>
                    <tr>
                        <td><%= rs.getInt("vehicle_id") %></td>
                        <td><%= rs.getString("model_name") %></td>
                        <td><span class="status-pill <%= statusClass %>"><%= status %></span></td>
                        <td><%= rs.getString("license_plate") %></td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='4'>Error loading live data</td></tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>