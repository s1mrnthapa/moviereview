package com.moviereview.controller.servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import com.moviereview.controller.dao.UserDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.User;

@WebServlet("/UpdateProfileServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,    // 1MB
    maxFileSize = 1024 * 1024 * 5,     // 5MB
    maxRequestSize = 1024 * 1024 * 10  // 10MB
)
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads/profile-pictures";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
            return;
        }

        // Get form parameters
        String newUsername = request.getParameter("username");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        boolean removePicture = "true".equals(request.getParameter("removePicture"));

        // Validate username if changed
        if (!newUsername.equals(user.getUsername())) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                UserDAO userDAO = new UserDAO(conn);
                if (userDAO.isUsernameExist(newUsername)) {
                    request.setAttribute("error", "Username already taken");
                    request.getRequestDispatcher("/pages/EditProfile.jsp").forward(request, response);
                    return;
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database error checking username: " + e.getMessage());
                request.getRequestDispatcher("/pages/EditProfile.jsp").forward(request, response);
                return;
            }
        }

        // Handle profile picture upload
        String profilePicturePath = user.getProfilePicturePath();
        Part filePart = request.getPart("profilePicture");

        try {
            // Remove existing picture if requested
            if (removePicture) {
                deleteProfilePicture(user.getProfilePicturePath(), request);
                profilePicturePath = null;
            }
            // Upload new picture if provided
            else if (filePart != null && filePart.getSize() > 0) {
                // Delete old picture if exists
                if (profilePicturePath != null && !profilePicturePath.isEmpty()) {
                    deleteProfilePicture(profilePicturePath, request);
                }
                // Upload new picture
                profilePicturePath = uploadProfilePicture(filePart, request);
            }

            // Update user information
            try (Connection conn = DatabaseConnection.getConnection()) {
                if (conn == null) {
                    throw new SQLException("Database connection is null");
                }
                
                UserDAO userDAO = new UserDAO(conn);

                // Update user object
                user.setUsername(newUsername);
                user.setFirstName(firstName);
                user.setLastName(lastName);
                user.setEmail(email);
                user.setProfilePicturePath(profilePicturePath);

                // Execute update
                boolean success = userDAO.updateUser(user);
                
                if (success) {
                    // Update session and redirect
                    session.setAttribute("user", user);
                    session.setAttribute("userProfile", user); // Ensure both attributes are updated
                    response.sendRedirect(request.getContextPath() + "/ProfileServlet");
                } else {
                    request.setAttribute("error", "Failed to update profile in database. No rows affected.");
                    request.getRequestDispatcher("/pages/EditProfile.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/pages/EditProfile.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error processing request: " + e.getMessage());
            request.getRequestDispatcher("/pages/EditProfile.jsp").forward(request, response);
        }
    }

    private String uploadProfilePicture(Part filePart, HttpServletRequest request) throws IOException {
        // Validate file part first
        if (filePart == null || filePart.getSize() == 0) {
            throw new IOException("No file was uploaded");
        }

        // Get original filename and validate
        String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        if (originalFileName == null || originalFileName.isEmpty()) {
            throw new IOException("Invalid file name");
        }

        // Validate file extension
        int lastDotIndex = originalFileName.lastIndexOf('.');
        if (lastDotIndex <= 0) {
            throw new IOException("File must have an extension");
        }
        String fileExtension = originalFileName.substring(lastDotIndex).toLowerCase();

        // Validate allowed extensions (adjust as needed)
        if (!Arrays.asList(".jpg", ".jpeg", ".png", ".gif").contains(fileExtension)) {
            throw new IOException("Only JPG, PNG, or GIF images are allowed");
        }

        // Set up upload directory
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
        
        // Create upload directory if it doesn't exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();
            if (!created) {
                throw new IOException("Failed to create upload directory: " + uploadPath);
            }
        }

        // Generate clean filename with preserved extension
        String baseName = "user_" + System.currentTimeMillis();
        String cleanFileName = baseName + fileExtension;

        // Ensure filename is URL-safe
        cleanFileName = cleanFileName.replaceAll("[^a-zA-Z0-9.-]", "_");

        // Save file
        Path filePath = Paths.get(uploadPath + File.separator + cleanFileName);
        try {
            Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            throw new IOException("Failed to save file: " + e.getMessage(), e);
        }

        // Verify file was actually saved
        if (!Files.exists(filePath) || Files.size(filePath) == 0) {
            throw new IOException("Failed to verify uploaded file");
        }

        // Return relative path for database storage
        return UPLOAD_DIR + "/" + cleanFileName;
    }

    private void deleteProfilePicture(String picturePath, HttpServletRequest request) {
        if (picturePath != null && !picturePath.isEmpty()) {
            try {
                String applicationPath = request.getServletContext().getRealPath("");
                Path filePath = Paths.get(applicationPath + File.separator + picturePath);
                Files.deleteIfExists(filePath);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}