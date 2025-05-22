package com.moviereview.controller.servlet;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.moviereview.controller.dao.ReviewDAO;
import com.moviereview.controller.dao.UserDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.Review;
import com.moviereview.model.User;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    private static final String DEFAULT_PROFILE_IMAGE = "images/default-profile.png";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Load fresh user data from database
            UserDAO userDAO = new UserDAO(conn);
            User currentUser = userDAO.getUserById(user.getUserId());
            
            // Process profile picture path
            processProfilePicturePath(currentUser, request);
            
            // Store in session and request
            session.setAttribute("user", currentUser);
            request.setAttribute("userProfile", currentUser);
            
            // Load reviews
            ReviewDAO reviewDAO = new ReviewDAO(conn);
            List<Review> recentReviews = reviewDAO.getRecentReviewsByUser(user.getUserId(), 4);
            request.setAttribute("recentReviews", recentReviews);
            
            // Forward to profile page
            request.getRequestDispatcher("/pages/UserProfile.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error loading profile: " + e.getMessage());
            request.getRequestDispatcher("/pages/UserProfile.jsp").forward(request, response);
        }
    }

    private void processProfilePicturePath(User user, HttpServletRequest request) {
        if (user.getProfilePicturePath() == null || user.getProfilePicturePath().isEmpty()) {
            user.setProfilePicturePath(DEFAULT_PROFILE_IMAGE);
            return;
        }

        // Validate path format first
        if (!user.getProfilePicturePath().matches("images/\\w+(\\.\\w+)+")) {
            System.err.println("Invalid path format: " + user.getProfilePicturePath());
            user.setProfilePicturePath(DEFAULT_PROFILE_IMAGE);
            return;
        }

        // Verify file exists
        try {
            String realPath = request.getServletContext().getRealPath("/" + user.getProfilePicturePath());
            if (realPath == null || !Files.exists(Paths.get(realPath))) {
                System.err.println("Profile picture not found at: " + realPath);
                user.setProfilePicturePath(DEFAULT_PROFILE_IMAGE);
            }
        } catch (Exception e) {
            System.err.println("Error checking profile picture: " + e.getMessage());
            user.setProfilePicturePath(DEFAULT_PROFILE_IMAGE);
        }
    }
}