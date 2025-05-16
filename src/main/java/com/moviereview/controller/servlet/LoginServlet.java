package com.moviereview.controller.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.moviereview.controller.database.DatabaseConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        try {
            Connection connection = DatabaseConnection.getConnection();
            String query = "SELECT id, name, email, username, role, joined_date, last_login FROM admins WHERE username = ? AND password = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password); // Reminder: use hashed passwords in production
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("adminId", rs.getInt("id"));
                session.setAttribute("name", rs.getString("name"));
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("username", rs.getString("username"));
                session.setAttribute("role", rs.getString("role"));
                session.setAttribute("joined", rs.getDate("joined_date"));
                session.setAttribute("lastLogin", rs.getTimestamp("last_login")); // use Timestamp for full date & time
                
                // Update last login time after storing the current one
                updateLastLogin(rs.getInt("id"));
                
                response.sendRedirect("admin-profile");
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    private void updateLastLogin(int adminId) {
        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "UPDATE admins SET last_login = NOW() WHERE id = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, adminId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
