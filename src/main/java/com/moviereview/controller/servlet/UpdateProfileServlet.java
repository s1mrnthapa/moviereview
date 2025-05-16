package com.moviereview.controller.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.moviereview.controller.dao.UserDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.User;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
            return;
        }

        // Get updated fields from form
        String newUsername = request.getParameter("username");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");

        // Debug output
        System.out.println("Attempting to update userID: " + user.getUserId());
        System.out.println("New username: " + newUsername);
        System.out.println("New name: " + firstName + " " + lastName);
        System.out.println("New email: " + email);

        // Validate username availability if changed
        if (!newUsername.equals(user.getUsername())) {
            try {
                Connection conn = DatabaseConnection.getConnection();
                UserDAO userDAO = new UserDAO(conn);
                
                if (userDAO.isUsernameExist(newUsername)) {
                    request.setAttribute("error", "Username already taken");
                    request.getRequestDispatcher("/pages/EditProfile.jsp").forward(request, response);
                    return;
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database error checking username availability");
                request.getRequestDispatcher("/pages/EditProfile.jsp").forward(request, response);
                return;
            }
        }

        // Update user information
        try (Connection conn = DatabaseConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);

            // Update user object
            user.setUsername(newUsername);
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);

            // Execute update
            boolean success = userDAO.updateUser(user);
            
            if (success) {
                System.out.println("Successfully updated userID: " + user.getUserId());
                // Update session and redirect
                session.setAttribute("user", user);
                response.sendRedirect(request.getContextPath() + "/ProfileServlet");
            } else {
                request.setAttribute("error", "Failed to update profile in database");
                request.getRequestDispatcher("/pages/EditProfile.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/pages/EditProfile.jsp").forward(request, response);
        }
    }
}