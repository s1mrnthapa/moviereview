package com.moviereview.controller.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.User;
public class UserDAO {
        private Connection conn;
        private PreparedStatement ps;

        public UserDAO(Connection conn) {
            this.conn = conn;
        }

        // Registers a new user
        public boolean registerUser(User user) {
            boolean isUserRegistered = false;
            String query = "INSERT INTO user (username, firstName, lastName, email, password) VALUES (?, ?, ?, ?, ?)";
            if (conn != null) {
                try {
                    ps = conn.prepareStatement(query);
                    ps.setString(1, user.getUsername());
                    ps.setString(2, user.getFirstName());
                    ps.setString(3, user.getLastName());
                    ps.setString(4, user.getEmail());
                    ps.setString(5, user.getPassword());
                    if (ps.executeUpdate() > 0) {
                        isUserRegistered = true;
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            return isUserRegistered;
        }

        // User login authentication
        public User loginUser(String username, String hashedPassword) {
            User user = null;
            String query = "SELECT * FROM user WHERE username = ? AND password = ?";
            if (conn != null) {
                try {
                    ps = conn.prepareStatement(query);
                    ps.setString(1, username);
                    ps.setString(2, hashedPassword);
                    try (ResultSet userSet = ps.executeQuery()) {
                        if (userSet.next()) {
                            user = new User();
                            user.setUserId(userSet.getInt("userID"));
                            user.setUsername(userSet.getString("username"));
                            user.setFirstName(userSet.getString("firstName"));
                            user.setLastName(userSet.getString("lastName"));
                            user.setEmail(userSet.getString("email"));
                            user.setPassword(userSet.getString("password"));
                            user.setRegisterDate(userSet.getTimestamp("registerDate"));
                            user.setRole(userSet.getString("role"));
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            return user;
        }

     // Method to check if the email already exists
        public boolean isEmailExist(String email) throws SQLException {
            String sql = "SELECT COUNT(*) FROM user WHERE email = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) > 0; // If count > 0, email exists
                }
            }
            return false;
        }

        // Method to check if the username already exists
        public boolean isUsernameExist(String username) throws SQLException {
            String sql = "SELECT COUNT(*) FROM user WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) > 0; // If count > 0, username exists
                }
            }
            return false;
        }
     // Updates an existing user's profile details including username
        public boolean updateUser(User user) {
            String query = "UPDATE user SET username=?, firstName=?, lastName=?, email=? WHERE userID=?";
            
            try (Connection conn = DatabaseConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(query)) {
                
                // Debug output
                System.out.println("Updating userID: " + user.getUserId());
                
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getFirstName());
                ps.setString(3, user.getLastName());
                ps.setString(4, user.getEmail());
                ps.setInt(5, user.getUserId());
                
                int rowsAffected = ps.executeUpdate();
                System.out.println("Rows affected: " + rowsAffected);
                
                return rowsAffected > 0;
            } catch (SQLException e) {
                System.err.println("Update failed for userID: " + user.getUserId());
                e.printStackTrace();
                return false;
            }
        }
        public User getUserById(int userId) throws SQLException {
            String query = "SELECT * FROM user WHERE userID = ?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        User user = new User();
                        user.setUserId(rs.getInt("userID"));
                        user.setUsername(rs.getString("username"));
                        user.setFirstName(rs.getString("firstName"));
                        user.setLastName(rs.getString("lastName"));
                        user.setEmail(rs.getString("email"));
                        // Add other fields as needed
                        return user;
                    }
                }
            }
            return null;
        }

		
    }
