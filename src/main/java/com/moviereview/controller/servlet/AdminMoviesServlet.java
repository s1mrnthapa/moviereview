package com.moviereview.controller.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.Movies;

@WebServlet("/AdminMoviesServlet")
@MultipartConfig
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
                    int movieID = rs.getInt("movieID");

                    // Create movie with cast and image path
                    Movies movie = new Movies(
                            movieID,
                            rs.getString("title"),
                            rs.getDate("release_date"),
                            rs.getString("duration"),
                            rs.getString("country"),
                            rs.getString("director"),
                            rs.getString("description"),
                            rs.getString("cast"),
                            rs.getString("image_path")
                    );

                    // Fetch genres directly (NO DAO)
                    List<String> genres = getGenresByMovieId(connection, movieID);
                    movie.setGenre(genres);
                    String ratingSql = "SELECT AVG(rating) AS avg_rating FROM review WHERE movieID = ?";
                    try (PreparedStatement ratingStmt = connection.prepareStatement(ratingSql)) {
                        ratingStmt.setInt(1, movieID);
                        ResultSet ratingRs = ratingStmt.executeQuery();

                        if (ratingRs.next()) {
                            double avgRating = ratingRs.getDouble("avg_rating");
                            if (ratingRs.wasNull()) {
                                avgRating = 0.0;
                            }
                            movie.setAverageRating(avgRating);
                        } else {
                            movie.setAverageRating(0.0);
                        }
                    }

                    moviesList.add(movie);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("movies", moviesList);
        request.getRequestDispatcher("/pages/AllMovies.jsp").forward(request, response);
    }

    private List<String> getGenresByMovieId(Connection conn, int movieId) {
        List<String> genres = new ArrayList<>();
        String sql = "SELECT g.genre_name FROM movie_genre_table mg JOIN genre g ON mg.genreID = g.genreID WHERE mg.movieID = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, movieId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    genres.add(rs.getString("genre_name"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return genres;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("AdminMoviesServlet");
    }
}