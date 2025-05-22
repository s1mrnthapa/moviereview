package com.moviereview.controller.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.moviereview.controller.dao.MovieDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.Movies;

@WebServlet("/AdminMoviesServlet")
@MultipartConfig
public class AdminMoviesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            int movieID = Integer.parseInt(request.getParameter("movieID"));
            try (Connection conn = DatabaseConnection.getConnection()) {
                String sql = "SELECT * FROM movie WHERE movieID = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, movieID);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
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
                        request.setAttribute("movie", movie);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/EditMovie.jsp");
                        dispatcher.forward(request, response);
                        return;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Unable to fetch movie.");
                request.getRequestDispatcher("/pages/AllMovies.jsp").forward(request, response);
                return;
            }
        }

        List<Movies> moviesList = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM movie";
            try (PreparedStatement ps = connection.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    int movieID = rs.getInt("movieID");

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

                    // Fetch genres
                    List<String> genres = getGenresByMovieId(connection, movieID);
                    movie.setGenre(genres);

                    // Fetch average rating
                    String ratingSql = "SELECT AVG(rating) AS avg_rating FROM review WHERE movieID = ?";
                    try (PreparedStatement ratingStmt = connection.prepareStatement(ratingSql)) {
                        ratingStmt.setInt(1, movieID);
                        ResultSet ratingRs = ratingStmt.executeQuery();

                        if (ratingRs.next()) {
                            double avgRating = ratingRs.getDouble("avg_rating");
                            if (ratingRs.wasNull()) {
                                avgRating = 0.0;
                            }
                            // Round to 2 decimal places
                            avgRating = Math.round(avgRating * 100.0) / 100.0;
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
        try {
            int movieID = Integer.parseInt(request.getParameter("movieID"));
            String title = request.getParameter("title");
            String duration = request.getParameter("duration");
            String country = request.getParameter("country");
            String director = request.getParameter("director");
            String description = request.getParameter("description");
            String cast = request.getParameter("cast");
            String imagePath = request.getParameter("imagePath");
            String releaseDateStr = request.getParameter("releaseDate");

            Date releaseDate = Date.valueOf(releaseDateStr);

            Movies movie = new Movies(movieID, title, releaseDate, duration, country, director, description, cast, imagePath);

            MovieDAO movieDAO = new MovieDAO();
            if (movieDAO.updateMovie(movie)) {
                response.sendRedirect("AdminMoviesServlet");
            } else {
                request.setAttribute("error", "Movie update failed.");
                request.setAttribute("movie", movie);
                request.getRequestDispatcher("/pages/EditMovie.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Update failed due to an internal error.");
            request.getRequestDispatcher("/pages/EditMovie.jsp").forward(request, response);
        }
    }
}
