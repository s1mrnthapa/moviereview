package com.moviereview.controller.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private final static String databaseName = "moviereview";
    private final static String username = "root";
    private final static String password = "";
    private final static String jdbcURL = "jdbc:mysql://localhost:3306/moviereview?useSSL=false&allowPublicKeyRetrieval=true";
    
    static {
        try {
            // Explicitly load driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        Connection conn = DriverManager.getConnection(jdbcURL, username, password);
        conn.setAutoCommit(true); // Ensure auto-commit is enabled
        return conn;
    }
}