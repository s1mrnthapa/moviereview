package com.moviereview.controller.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.moviereview.model.User;

public class UserDAO {
    private Connection conn;

    // Constructor receives a connection (for better control/testing)
    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    // Method to authenticate user based on username and password
    public User loginUser(String username, String hashedPassword) throws SQLException {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, hashedPassword);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setRole(rs.getString("role"));
                return user;
            }
        }
        return null;
    }
}
