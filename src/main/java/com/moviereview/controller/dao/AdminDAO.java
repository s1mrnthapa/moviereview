package com.moviereview.controller.dao;

import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.Admin;
import java.sql.*;
import java.util.Date;

public class AdminDAO {
    public Admin getAdminById(int adminId) {
        Admin admin = null;
        Connection connection = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            String query = "SELECT * FROM admins WHERE id = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, adminId);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setName(rs.getString("name"));
                admin.setEmail(rs.getString("email"));
                admin.setUsername(rs.getString("username"));
                admin.setRole(rs.getString("role"));
                admin.setJoinedDate(rs.getDate("joined_date"));
                admin.setLastLogin(rs.getDate("last_login"));
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        
        return admin;
    }
    
    // Add methods for statistics
    public int getMoviesAddedCount(int adminId) throws SQLException, ClassNotFoundException {
        Connection connection = DatabaseConnection.getConnection();
        String query = "SELECT COUNT(*) FROM movies WHERE added_by = ?";
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setInt(1, adminId);
        
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }
    
    public int getReviewsModeratedCount(int adminId) throws SQLException, ClassNotFoundException {
        Connection connection = DatabaseConnection.getConnection();
        String query = "SELECT COUNT(*) FROM reviews WHERE moderated_by = ?";
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setInt(1, adminId);
        
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }
    
    public int getUsersManagedCount(int adminId) throws SQLException, ClassNotFoundException {
        Connection connection = DatabaseConnection.getConnection();
        String query = "SELECT COUNT(*) FROM users WHERE managed_by = ?";
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setInt(1, adminId);
        
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }
}