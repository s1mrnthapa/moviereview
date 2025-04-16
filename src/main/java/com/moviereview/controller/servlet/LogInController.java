package com.moviereview.controller.servlet;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.moviereview.controller.dao.UserDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.User;

@WebServlet("/LogInController")
public class LogInController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LogInController() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();

        try (Connection conn = DatabaseConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);
            String hashedPassword = hashPassword(password); // hash input password
            User user = userDAO.loginUser(username, hashedPassword);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                String role = user.getRole().trim();
                if ("Admin".equalsIgnoreCase(role)) {
                    response.sendRedirect(request.getContextPath() + "/pages/AdminDashboard.jsp");
                } else if ("User".equalsIgnoreCase(role)) {
                    response.sendRedirect(request.getContextPath() + "/pages/UserProfile.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/pages/Login.jsp?error=unknownRole");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/Login.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/Login.jsp?error=exception");
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
