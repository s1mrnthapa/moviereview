package com.moviereview.controller.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

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
                            return user;
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
     // Updates an existing user's profile details including username
        public boolean updateUser(User user) throws SQLException {
            // Validate profile picture path format if present
        	if (user.getProfilePicturePath() != null && !user.getProfilePicturePath().isEmpty()) {        
        	        // Check path format
        		if (!user.getProfilePicturePath().matches("images/\\w+(\\.\\w+)+")) {
        			throw new SQLException("Invalid profile picture path format");
        	    }
        	}

            String query = "UPDATE user SET username=?, firstName=?, lastName=?, email=?, profilePicturePath=? WHERE userID=?";
            
            try (PreparedStatement ps = conn.prepareStatement(query)) {    
                // Set parameters with null checks
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getFirstName());
                ps.setString(3, user.getLastName());
                ps.setString(4, user.getEmail());
                
                // Handle potential null profile picture path
                if (user.getProfilePicturePath() != null && !user.getProfilePicturePath().isEmpty()) {
                    ps.setString(5, user.getProfilePicturePath());
                } else {
                    ps.setNull(5, Types.VARCHAR);
                }
                
                ps.setInt(6, user.getUserId());
                
                int rowsAffected = ps.executeUpdate();
                
                // Detailed logging
                System.out.println("Updated user ID: " + user.getUserId() + 
                                 ", Rows affected: " + rowsAffected +
                                 ", New profile path: " + user.getProfilePicturePath());
                
                return rowsAffected > 0;
                
            } catch (SQLException e) {
                // Enhanced error logging
                System.err.println("Error updating user ID " + user.getUserId() + ": " + e.getMessage());
                throw e; // Re-throw to let caller handle
            }
        }
        public List<User> getAllUsers() {
            List<User> users = new ArrayList<>();
            String sql = "SELECT * FROM users"; // Change table name if it's different

            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("userID"));
                    user.setUsername(rs.getString("username"));
                    user.setFirstName(rs.getString("firstName"));
                    user.setLastName(rs.getString("lastName"));
                    user.setEmail(rs.getString("email"));
                    user.setRegisterDate(rs.getTimestamp("registerDate"));
                    // You can skip password and role if not needed

                    users.add(user);
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }
            return users;
        }
        public static int getTotalReviewsByUser(Connection conn, int userId) {
            String sql = "SELECT COUNT(*) AS total FROM review WHERE userID = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt("total");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return 0;
        }

        public static List<Integer> getReviewedMovieIdsByUser(Connection conn, int userId) {
            List<Integer> movieIds = new ArrayList<>();
            String sql = "SELECT DISTINCT movieID FROM review WHERE userID = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        movieIds.add(rs.getInt("movieID"));
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return movieIds;
        }
        public List<User> getAllNormalUsers() {
            List<User> users = new ArrayList<>();
            String sql = "SELECT * FROM user WHERE role = 'User'";

            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("userID"));
                    user.setUsername(rs.getString("username"));
                    user.setFirstName(rs.getString("firstName"));
                    user.setLastName(rs.getString("lastName"));
                    user.setEmail(rs.getString("email"));
                    user.setRegisterDate(rs.getTimestamp("registerDate"));
                    // Do not set password or image or role here

                    users.add(user);
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }
            return users;
        }

    }