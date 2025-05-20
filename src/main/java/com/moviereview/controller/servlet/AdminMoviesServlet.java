package com.moviereview.controller.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.Movies;

@WebServlet("/AdminMoviesServlet")
public class AdminMoviesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Movies> moviesList = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM movie";
            try (PreparedStatement ps = connection.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Movies movie = new Movies(
                            rs.getInt("movieID"),
                            rs.getString("title"),
                            rs.getDate("release_date"),
                            rs.getString("duration"),
                            rs.getString("country"),
                            rs.getString("director"),
                            rs.getString("description"),
                            rs.getString("cast"),
                            rs.getString("image_path")
                    );
                    moviesList.add(movie);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("movies", moviesList);
        request.getRequestDispatcher("/pages/AllMovies.jsp").forward(request, response);
    }

    // Optional: if you don't plan to handle POST here, just remove this method.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Do nothing or handle other POST requests if needed
        response.sendRedirect("AdminMoviesServlet");
    }
}
