package com.moviereview.controller.servlet;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.sql.Connection;
import java.util.regex.Pattern;

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
        String username = request.getParameter("username");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");

        // Regex Patterns
        String nameRegex = "^[A-Za-z]+$";
        String usernameRegex = "^[A-Za-z0-9]{6,}$";
        String passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{7,}$";

        // Validation
        if (firstName == null || !Pattern.matches(nameRegex, firstName)) {
            request.setAttribute("error", "First name must contain only letters.");
            request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
            return;
        }

        if (lastName == null || !Pattern.matches(nameRegex, lastName)) {
            request.setAttribute("error", "Last name must contain only letters.");
            request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
            return;
        }

        if (username == null || !Pattern.matches(usernameRegex, username)) {
            request.setAttribute("error", "Username must be at least 6 characters and contain only letters and numbers.");
            request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
            return;
        }

        if (password == null || !Pattern.matches(passwordRegex, password)) {
            request.setAttribute("error", "Password must be at least 7 characters long, contain one uppercase letter, one number, and one special character.");
            request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
            return;
        }

     // Check if the email or username already exists
        try {
            // Hash the password before saving
            String hashedPassword = hashPassword(password);

            // Create User object
            User user = new User(0, username, firstName, lastName, email, hashedPassword, null, null, hashedPassword);

            // Create UserDAO and check for existing username and email
            Connection conn = DatabaseConnection.getConnection();
            UserDAO userDAO = new UserDAO(conn);

            // Check if email or username exists
            if (userDAO.isEmailExist(email)) {
                request.setAttribute("error", "Email is already registered.");
                request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
                return;
            }

            if (userDAO.isUsernameExist(username)) {
                request.setAttribute("error", "Username is already taken.");
                request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
                return;
            }

            // Proceed to register the user
            boolean success = userDAO.registerUser(user);

            if (success) {
                // Redirect to login page if registration is successful
                response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
            } else {
                // Error message if registration failed
                request.setAttribute("error", "Registration failed. Please try again later.");
                request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            // Handle unexpected exceptions
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred. Please try again later.");
            request.getRequestDispatcher("/pages/Register.jsp").forward(request, response);
        }
        
    }

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