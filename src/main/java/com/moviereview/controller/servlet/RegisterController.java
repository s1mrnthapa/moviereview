package com.moviereview.controller.servlet;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.moviereview.controller.dao.UserDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.User;

@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegisterController() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch parameters from form
        String username = request.getParameter("username");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String role = request.getParameter("role");  // <-- get role from form input

        // If role is null or empty, fallback to "user"
        if (role == null || role.trim().isEmpty()) {
            role = "user";
        }

        // Regex patterns for validation
        String nameRegex = "^[A-Za-z]+$";
        String usernameRegex = "^[A-Za-z0-9]{6,}$";
        String passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{7,}$";

        // Validate firstName
        if (firstName == null || !Pattern.matches(nameRegex, firstName)) {
            request.setAttribute("error", "First name must contain only letters.");
            request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
            return;
        }

        // Validate lastName
        if (lastName == null || !Pattern.matches(nameRegex, lastName)) {
            request.setAttribute("error", "Last name must contain only letters.");
            request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
            return;
        }

        // Validate username
        if (username == null || !Pattern.matches(usernameRegex, username)) {
            request.setAttribute("error", "Username must be at least 6 characters and contain only letters and numbers.");
            request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
            return;
        }

        // Validate password
        if (password == null || !Pattern.matches(passwordRegex, password)) {
            request.setAttribute("error", "Password must be at least 7 characters long, contain one uppercase letter, one number, and one special character.");
            request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
            return;
        }

        // Confirm password check
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
            return;
        }

        try {
            // Hash the password securely
            String hashedPassword = hashPassword(password);

            // Register date timestamp
            Timestamp registerDate = new Timestamp(System.currentTimeMillis());

            // Create User object with role from request
            User user = new User(0, username, firstName, lastName, email, hashedPassword, registerDate, role);

            try (Connection conn = DatabaseConnection.getConnection()) {
                UserDAO userDAO = new UserDAO(conn);

                // Check if email already exists
                if (userDAO.isEmailExist(email)) {
                    request.setAttribute("error", "Email is already registered.");
                    request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
                    return;
                }

                // Check if username already exists
                if (userDAO.isUsernameExist(username)) {
                    request.setAttribute("error", "Username is already taken.");
                    request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
                    return;
                }

                // Register user in database
                boolean success = userDAO.registerUser(user);

                if (success) {
                    // Redirect to login page on success
                    response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
                } else {
                    // Registration failed
                    request.setAttribute("error", "Registration failed. Please try again later.");
                    request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred. Please try again later.");
            request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
        }
    }

    // SHA-256 password hashing
    private String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hashBytes = digest.digest(password.getBytes());
        StringBuilder hexString = new StringBuilder();
        for (byte b : hashBytes) {
            hexString.append(String.format("%02x", b));
        }
        return hexString.toString();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/pages/Register.jsp");
    }
}
