package com.moviereview.controller.servlet;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.moviereview.controller.dao.UserDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.User;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    private static final String DEFAULT_PROFILE_IMAGE = "images/default-profile.png";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        //  Try to get user from session
        if (user == null) {
            // If not in session, load from database
            String userId = request.getParameter("userId");
            if (userId != null) {
                try (Connection conn = DatabaseConnection.getConnection()) {
                    UserDAO userDAO = new UserDAO(conn);
                    user = userDAO.getUserById(Integer.parseInt(userId));
                    
                    if (user != null) {
                        // Process profile picture path before storing in session
                        processProfilePicturePath(user, request);
                        session.setAttribute("user", user);
                        session.setAttribute("userProfile", user);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/pages/Login.jsp?error=db_error");
                    return;
                }
            }
        }

        // Final check - if still no user, redirect to login
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
            return;
        }

        // Process profile picture path for existing session user
        processProfilePicturePath(user, request);

        // Handle error messages
        if (request.getParameter("error") != null) {
            request.setAttribute("error", request.getParameter("error"));
        }

        // Forward to profile page
        request.setAttribute("userProfile", user);
        request.getRequestDispatcher("/pages/UserProfile.jsp").forward(request, response);
    }

    /**
     * Validates and processes the profile picture path
     */
    private void processProfilePicturePath(User user, HttpServletRequest request) {
        if (user.getProfilePicturePath() == null || user.getProfilePicturePath().isEmpty()) {
            user.setProfilePicturePath(DEFAULT_PROFILE_IMAGE);
            return;
        }

        // Sanitize the path
        String sanitizedPath = user.getProfilePicturePath()
                .replaceAll("\\.$", "") // Remove trailing dots
                .replaceAll("\\.\\.", ".") // Remove double dots
                .trim();

        // Verify file exists
        try {
            String realPath = request.getServletContext().getRealPath(sanitizedPath);
            if (realPath == null || !Files.exists(Paths.get(realPath))) {
                // Check if path is already context-relative
                if (sanitizedPath.startsWith(request.getContextPath())) {
                    realPath = request.getServletContext().getRealPath(
                        sanitizedPath.substring(request.getContextPath().length()));
                }
                
                if (realPath == null || !Files.exists(Paths.get(realPath))) {
                    throw new IOException("File not found");
                }
            }
        } catch (Exception e) {
            // Log the error for debugging
            System.err.println("Profile picture not found: " + sanitizedPath);
            System.err.println("Falling back to default image. Error: " + e.getMessage());
            user.setProfilePicturePath(DEFAULT_PROFILE_IMAGE);
        }
    }
}