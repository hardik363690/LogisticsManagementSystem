#Logistics Fleet Management System

A robust, dynamic web application built with **Java EE** to streamline logistics operations, manage vehicle assets, track maintenance, and monitor operational expenses.

## Key Features

* **Command Center (Dashboard):** Real-time KPI tracking for active fleet size, maintenance alerts, and dispatched trips, alongside a live monitoring feed.
* ** Vehicle Registry:** Complete asset management system to register and track trucks, vans, and heavy vehicles (optimized for large fleets).
* **🧑‍✈️ Driver Profiles:** HR management module to track driver information, license expiration dates, and safety scores.
* **🛣️ Trip Dispatcher:** Dynamic assignment system that prevents double-booking by only allowing 'Available' vehicles and drivers to be dispatched.
* **🔧 Service Logs:** Maintenance tracking to log repair costs and service dates, preventing unexpected breakdowns.
* **⛽ Fuel & Expenses:** Fuel consumption tracking (`liters_filled` and `total_cost`) linked to specific vehicles.
* **📈 Analytics:** Automated financial calculation of total fleet operational spending.

## 💻 Tech Stack

* **Frontend:** HTML5, CSS3 (Custom Flexbox layout with sticky headers and isolated scrolling)
* **Backend:** Java EE 5 (JSP & Servlets)
* **Database:** MySQL (Relational schema with Foreign Key constraints)
* **Database Connectivity:** JDBC
* **Server:** Apache Tomcat 9.0
* **IDE:** NetBeans IDE 8

## 🗄️ Database Structure (`fleet_manager`)

The system relies on a tightly integrated relational database:
* `vehicles` (vehicle_id, model_name, license_plate, max_capacity_kg, odometer, status)
* `drivers` (driver_id, full_name, license_expiry, status, safety_score)
* `trips` (trip_id, vehicle_id, driver_id, cargo_weight, status)
* `maintenance_logs` (log_id, vehicle_id, service_type, cost, service_date)
* `fuel_logs` (fuel_id, vehicle_id, liters_filled, total_cost, log_date)

## 🚀 Installation & Setup

Follow these steps to run the project locally using NetBeans and XAMPP:

### 1. Database Setup
1. Open **XAMPP** and start the **Apache** and **MySQL** modules.
2. Open **phpMyAdmin** (`http://localhost/phpmyadmin`).
3. Create a new database named `fleet_manager`.
4. Import your SQL script to generate the tables and insert the dummy data.

### 2. Project Setup
1. Open **NetBeans IDE**.
2. Go to `File` > `Open Project` and select the `LogisticsVehicle` folder.
3. Ensure the **MySQL JDBC Driver** (e.g., `mysql-connector-java.jar`) is added to your project's `Libraries` folder.
4. Open `src/java/com/fleet/utils/DatabaseConnection.java` and verify your database credentials:
   ```java
   String url = "jdbc:mysql://localhost:3306/fleet_manager";
   String user = "root";
   String password = ""; // Leave blank if default XAMPP