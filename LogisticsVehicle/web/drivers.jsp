<%@ page import="java.sql.*, com.fleet.utils.DatabaseConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Driver Profiles - Fleet Manager</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Flexbox layout to lock the top and scroll the bottom */
        .main-content {
            margin-left: 260px;
            padding: 30px;
            height: 100vh;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            background-color: #f8fafc;
        }

        .form-card {
            flex-shrink: 0;
            margin-bottom: 10px;
        }

        .table-scroll-box {
            flex-grow: 1;
            overflow-y: auto;
            border: 1px solid #e2e8f0;
            background-color: white;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
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
        <h1>Driver Profiles</h1>
        <div class="form-card">
            <h3>Add New Driver</h3>
            <form action="DriverServlet" method="POST">
                <input type="text" name="driverName" placeholder="Full Name" required>
                <input type="date" name="licenseExpiry" required>
                <button type="submit">Register Driver</button>
            </form>
        </div>

        <h2 style="margin-top: 10px; margin-bottom: 5px;">Active Roster</h2>

        <div class="table-scroll-box">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>License Expiry</th>
                        <th>Status</th>
                        <th>Safety Score</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try (Connection conn = DatabaseConnection.getConnection();
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery("SELECT * FROM drivers ORDER BY driver_id DESC")) {

                            while(rs.next()) {
                                String status = rs.getString("status");
                                String statusClass = status != null ? status.toLowerCase().replace(" ", "-") : "available";
                    %>
                    <tr>
                        <td><%= rs.getInt("driver_id") %></td>
                        <td><%= rs.getString("full_name") %></td>
                        <td><%= rs.getDate("license_expiry") %></td>
                        <td><span class="status-pill <%= statusClass %>"><%= status %></span></td>
                        <td><%= rs.getInt("safety_score") %>/100</td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='5'>Error loading drivers: " + e.getMessage() + "</td></tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>