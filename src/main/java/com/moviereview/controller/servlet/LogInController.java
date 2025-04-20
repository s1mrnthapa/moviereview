package com.moviereview.controller.servlet;

<<<<<<< HEAD
import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

=======
>>>>>>> origin/main
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
<<<<<<< HEAD
            
            // Check if the username and password match in the database
            User user = userDAO.loginUser(username, password);

            if (user != null) {
                // If login is successful, redirect to success page
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect(request.getContextPath() + "/pages/UserProfile.jsp?success=true");
            } else {
                // If login failed, redirect to login page with error
                response.sendRedirect(request.getContextPath() + "/pages/Login.jsp?error=true");
=======
            String hashedPassword = hashPassword(password); // hash input password
            User loggedInUser = userDAO.loginUser(username, hashedPassword);

            HttpSession session = request.getSession();

            if (loggedInUser != null) {
                session.removeAttribute("error");
                session.setMaxInactiveInterval(20 * 60); // Set session timeout to 20 mins

                if ("admin".equalsIgnoreCase(loggedInUser.getRole())) {
                    session.setAttribute("Admin", loggedInUser);
                    response.sendRedirect(request.getContextPath() + "/pages/AdminDashboard.jsp");
                } else {
                    session.setAttribute("user", loggedInUser);
                    response.sendRedirect(request.getContextPath() + "/pages/Home.jsp");
                }

            } else {
                session.setAttribute("error", "Invalid username or password");
                response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
>>>>>>> origin/main
            }

        } catch (Exception e) {
            e.printStackTrace();
<<<<<<< HEAD
            response.sendRedirect(request.getContextPath() + "/pages/Login.jsp?error=true");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
    }
}
=======
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

}
>>>>>>> origin/main
