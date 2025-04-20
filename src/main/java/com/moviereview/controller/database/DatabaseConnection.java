package com.moviereview.controller.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    public static Connection getConnection() throws SQLException {
        String dbURL = "jdbc:mysql://localhost:3308/your_db_name";
        String dbUsername = "your_username";
        String dbPassword = "your_password";
        try {
            return DriverManager.getConnection(dbURL, dbUsername, dbPassword);
        } catch (SQLException e) {
            throw new SQLException("Failed to connect to the database", e);
        }
    }
}
