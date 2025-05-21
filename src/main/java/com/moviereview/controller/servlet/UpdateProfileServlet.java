package com.moviereview.controller.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

import com.moviereview.controller.dao.UserDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.User;

@WebServlet("/UpdateProfileServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,    // 1MB
    maxFileSize = 5 * 1024 * 1024,      // 5MB
    maxRequestSize = 10 * 1024 * 1024   // 10MB
)
public class UpdateProfileServlet extends HttpServlet {

    private static final String IMAGE_FOLDER = "images";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Handle showing the edit form (GET request)
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Always get FRESH data from database
            UserDAO userDAO = new UserDAO(conn);
            User currentUser = userDAO.getUserById(user.getUserId());

            // Update session with fresh data
            session.setAttribute("user", currentUser);
            request.setAttribute("userProfile", currentUser);

            request.getRequestDispatcher("/pages/EditProfile.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error loading profile: " + e.getMessage());
            request.getRequestDispatcher("/pages/EditProfile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Get form parameters
            String username = request.getParameter("username");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            boolean removePic = "true".equals(request.getParameter("removePicture"));

            // Handle profile picture upload
            String picturePath = handleProfilePicture(request, user, removePic);

            // Validate inputs
            if (username == null || username.trim().isEmpty() ||
                firstName == null || firstName.trim().isEmpty() ||
                lastName == null || lastName.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {
                throw new Exception("All fields are required");
            }

            try (Connection conn = DatabaseConnection.getConnection()) {
                UserDAO userDAO = new UserDAO(conn);

                if (!username.equals(user.getUsername())) {
                    if (userDAO.isUsernameExist(username)) {
                        throw new Exception("Username already taken");
                    }
                }

                user.setUsername(username);
                user.setFirstName(firstName);
                user.setLastName(lastName);
                user.setEmail(email);
                if (picturePath != null) {
                    user.setProfilePicturePath(picturePath);
                } else if (removePic) {
                    user.setProfilePicturePath(null);
                }

                boolean updated = userDAO.updateUser(user);

                if (!updated) {
                    throw new Exception("Failed to update profile");
                }

                User updatedUser = userDAO.getUserById(user.getUserId());
                session.setAttribute("user", updatedUser);
                request.setAttribute("userProfile", updatedUser);

                session.setAttribute("successMessage", "Profile updated successfully");

                response.sendRedirect("ProfileServlet");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/pages/EditProfile.jsp").forward(request, response);
        }
    }

    private String handleProfilePicture(HttpServletRequest request, User user, boolean removePic)
            throws IOException, ServletException {

        if (removePic) {
            deleteFile(user.getProfilePicturePath(), request);
            return null;
        }

        Part filePart = request.getPart("profilePicture");
        if (filePart == null || filePart.getSize() == 0) {
            return user.getProfilePicturePath();
        }

        String fileName = filePart.getSubmittedFileName();
        String fileExtension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
        
        if (!Arrays.asList(".jpg", ".jpeg", ".png", ".gif").contains(fileExtension)) {
            throw new ServletException("Only JPG, JPEG, PNG, or GIF images are allowed");
        }

        if (user.getProfilePicturePath() != null && !user.getProfilePicturePath().isEmpty()) {
            deleteFile(user.getProfilePicturePath(), request);
        }

        return saveUploadedFile(filePart, request);
    }

    private String saveUploadedFile(Part filePart, HttpServletRequest request) throws IOException {
        String appPath = request.getServletContext().getRealPath("");
        String imagesPath = appPath + File.separator + IMAGE_FOLDER;

        File imagesDir = new File(imagesPath);
        if (!imagesDir.exists()) {
            imagesDir.mkdirs();
        }

        // Get the original filename and extension
        String originalFileName = filePart.getSubmittedFileName();
        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf('.'));
        
        // Create new filename with proper extension
        String fileName = "user_" + System.currentTimeMillis() + fileExtension;
        String filePath = imagesPath + File.separator + fileName;
        
        filePart.write(filePath);

        return IMAGE_FOLDER + "/" + fileName;
    }

    private void deleteFile(String filePath, HttpServletRequest request) {
        if (filePath != null && !filePath.isEmpty() && !filePath.equals("images/default-profile.png")) {
            String realPath = request.getServletContext().getRealPath(filePath);
            if (realPath != null) {
                File file = new File(realPath);
                if (file.exists()) {
                    file.delete();
                }
            }
        }
    }
}
