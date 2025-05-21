package com.moviereview.controller.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.moviereview.model.User;

public class UserDAO {
    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());
    private Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    // Register a new user
    public boolean registerUser(User user) {
        String query = "INSERT INTO user (username, firstName, lastName, email, password, role) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getFirstName());
            ps.setString(3, user.getLastName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPassword());  // Make sure password is hashed BEFORE calling this method
            ps.setString(6, user.getRole());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error registering user", e);
        }
        return false;
    }

    // Login (authentication)
    public User loginUser(String username, String hashedPassword) {
        String query = "SELECT * FROM user WHERE username = ? AND password = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);
            ps.setString(2, hashedPassword);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error logging in user", e);
        }
        return null;
    }

    // Get user by username
    public User getUserByUsername(String username) {
    	User user = null;
        String query = "SELECT * FROM user WHERE username = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = extractUserFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching user by username", e);
        }
        return user;
    }

    // Check if email exists
    public boolean isEmailExist(String email) {
        String sql = "SELECT 1 FROM user WHERE email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking email existence", e);
        }
        return false;
    }

    // Check if username exists
    public boolean isUsernameExist(String username) {
        String sql = "SELECT 1 FROM user WHERE username = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking username existence", e);
        }
        return false;
    }

    // Get user by ID (optional)
    public User getUserById(int id) {
        String query = "SELECT * FROM user WHERE userID = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching user by ID", e);
        }
        return null;
    }

    // Get admin user by username — reuse extractUserFromResultSet
    public User getAdminUser(String username) {
        String sql = "SELECT * FROM user WHERE username = ? AND role = 'admin'";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching admin user", e);
        }
        return null;
    }

    // Extract User from ResultSet
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("userID"));
        user.setUsername(rs.getString("username"));
        user.setFirstName(rs.getString("firstName"));
        user.setLastName(rs.getString("lastName"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password"));
        user.setRegisterDate(rs.getTimestamp("registerDate"));
        user.setRole(rs.getString("role"));
        return user;
    }

	public boolean updateUser(User user) {
		// TODO Auto-generated method stub
		return false;
	}
}
