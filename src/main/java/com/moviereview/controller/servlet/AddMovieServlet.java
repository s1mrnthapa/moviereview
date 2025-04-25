package com.moviereview.controller.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddMovieServlet")
public class AddMovieServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddMovieServlet() {
        super();
    }

    // Handle POST request
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data from request
        String title = request.getParameter("title");
        String release_date = request.getParameter("releaseDate");
        String genre = String.join(", ", request.getParameterValues("genre"));
        String duration = request.getParameter("duration");
        String country = request.getParameter("country");
        String director = request.getParameter("director");
        String cast = request.getParameter("cast");
        String description = request.getParameter("description");

        // Insert movie data into the database
        try {
            // Establish DB connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviereview", "root", "");

            // Prepare SQL statement to insert movie
            String sql = "INSERT INTO movie (title, release_date, genre, duration, country, director, cast, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, release_date);
            stmt.setString(3, genre);
            stmt.setString(4, duration);
            stmt.setString(5, country);
            stmt.setString(7, director);
            stmt.setString(8, cast);
            stmt.setString(9, description);

            // Execute update
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // If movie is inserted, redirect to movie database page
                response.sendRedirect("movieDatabase.jsp");
            } else {
                response.getWriter().write("Error inserting movie.");
            }

            // Close the connection
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
