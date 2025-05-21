package com.moviereview.controller.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.User;
import com.moviereview.controller.dao.UserDAO;

@WebServlet("/AllUsersServlet")
public class AllUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        List<User> users = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM user WHERE role = 'User'"; // Only fetch users, not admins

            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("userID"));
                    user.setUsername(rs.getString("username"));
                    user.setFirstName(rs.getString("firstName"));
                    user.setLastName(rs.getString("lastName"));
                    user.setEmail(rs.getString("email"));
                    user.setRegisterDate(rs.getTimestamp("registerDate"));
                    user.setRole(rs.getString("role")); // Optional but good to keep

                    // Fetch and set total reviews count from DAO
                    user.setTotalReviews(UserDAO.getTotalReviewsByUser(conn, user.getUserId()));

                    users.add(user);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // You might want to set an error message attribute here and forward to an error page
        }

        request.setAttribute("users", users);
        request.getRequestDispatcher("/pages/AllUsers.jsp").forward(request, response);
    }
}
