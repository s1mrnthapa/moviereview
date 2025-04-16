package com.moviereview.controller.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.moviereview.model.User;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class UserDAO {
    private Connection conn;
    private PreparedStatement ps;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    // Registers a new user
    public boolean registerUser(User user) {
        boolean isUserRegistered = false;
        String query = "INSERT INTO user (username, firstName, lastName, email, password, role) VALUES (?, ?, ?, ?, ?, ?)";
        if (conn != null) {
            try {
                ps = conn.prepareStatement(query);
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getFirstName());
                ps.setString(3, user.getLastName());
                ps.setString(4, user.getEmail());
                ps.setString(5, hashPassword(user.getPassword()));  // Hashing password here ✅
                ps.setString(6, user.getRole());
                if (ps.executeUpdate() > 0) {
                    isUserRegistered = true;
                }
            } catch (SQLException | NoSuchAlgorithmException e) {
                e.printStackTrace();
            }
        }
        return isUserRegistered;
    }

    // User login authentication
    public User loginUser(String usernameToCheck, String passwordToCheck) {
        User user = null;
        String query = "SELECT * FROM user WHERE username = ?";
        if (conn != null) {
            try {
                ps = conn.prepareStatement(query);
                ps.setString(1, usernameToCheck);
                ResultSet userSet = ps.executeQuery();
                if (userSet.next()) {
                    String storedPassword = userSet.getString("password");
                    if (storedPassword.equals(hashPassword(passwordToCheck))) {
                        user = new User();
                        user.setUserId(userSet.getInt("userID"));
                        user.setUsername(userSet.getString("username"));
                        user.setFirstName(userSet.getString("firstName"));
                        user.setLastName(userSet.getString("lastName"));
                        user.setEmail(userSet.getString("email"));
                        user.setPassword(storedPassword);
                        user.setRegisterDate(userSet.getTimestamp("registerDate"));
                        user.setRole(userSet.getString("role"));
                    }
                }
            } catch (SQLException | NoSuchAlgorithmException e) {
                e.printStackTrace();
            }
        }
        return user;
    }

    // Method to hash the password using SHA-256
    private String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hashBytes = digest.digest(password.getBytes());
        StringBuilder hexString = new StringBuilder();
        for (byte b : hashBytes) {
            hexString.append(String.format("%02x", b));
        }
        return hexString.toString();
    }
}
