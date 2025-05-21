package com.moviereview.controller.servlet;

import com.moviereview.controller.dao.UserDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;

@WebServlet("/LogInController")
public class LogInController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim(); // Optionally hash this if stored hashed

        try (Connection conn = DatabaseConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);
            String hashedPassword = hashPassword(password); // hash input password
            
            User loggedInUser = userDAO.loginUser(username, hashedPassword);

            HttpSession session = request.getSession();

            if (loggedInUser != null) {
                session.removeAttribute("error");
                session.setMaxInactiveInterval(30 * 60); // Set session timeout to 30 mins
                session.setAttribute("userID", loggedInUser.getUserId());
                session.setAttribute("username", loggedInUser.getUsername());
                session.setAttribute("role", loggedInUser.getRole());

                if ("Admin".equalsIgnoreCase(loggedInUser.getRole())) {
                    session.setAttribute("Admin", loggedInUser);
                    response.sendRedirect(request.getContextPath() + "/pages/Dashboard.jsp");
                } else {
                    session.setAttribute("user", loggedInUser);
                    response.sendRedirect(request.getContextPath() + "/pages/Home.jsp");
                }

            } else {
            	System.out.println("Username: " + username);
            	System.out.println("Hashed Password: " + hashedPassword);
            	System.out.println("User Retrieved: " + (loggedInUser != null ? loggedInUser.getUsername() : "null"));
            	System.out.println("Role: " + (loggedInUser != null ? loggedInUser.getRole() : "N/A"));
                session.setAttribute("error", "Invalid username or password");
                response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Something went wrong!");
            response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
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
        response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
    }
}