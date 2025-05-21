package com.moviereview.controller.servlet;

import com.moviereview.model.Movies;
import com.moviereview.model.Review;
import com.moviereview.controller.dao.ReviewDAO;
import com.moviereview.controller.database.DatabaseConnection;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/MovieDetail")
public class MovieDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("movieID");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pages/Movies.jsp"); // Redirect if no movie ID
            return;
        }

        try {
            int movieID = Integer.parseInt(idParam);

            Connection connection = DatabaseConnection.getConnection();

            String sql = "SELECT * FROM movie WHERE movieID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, movieID);
            ResultSet rs = statement.executeQuery();

            Movies movie = null;

            if (rs.next()) {
                String title = rs.getString("title");
                Date releaseDate = rs.getDate("release_date");
                String duration = rs.getString("duration");
                String country = rs.getString("country");
                String director = rs.getString("director");
                String description = rs.getString("description");
                String castString = rs.getString("cast"); // Assuming comma-separated cast
                String imagePath = rs.getString("image_path");

                movie = new Movies(movieID, title, releaseDate, duration, country, director, description, castString, imagePath);

                // 👉 Fetch genres
                String genreSql = "SELECT g.genre_name FROM genre g "
                        + "INNER JOIN movie_genre_table mg ON g.genreID = mg.genreID "
                        + "WHERE mg.movieID = ?";
                PreparedStatement genreStatement = connection.prepareStatement(genreSql);
                genreStatement.setInt(1, movieID);
                ResultSet genreRs = genreStatement.executeQuery();

                List<String> genres = new ArrayList<>();
                while (genreRs.next()) {
                    genres.add(genreRs.getString("genre_name"));
                }
                movie.setGenre(genres);
                
                ReviewDAO reviewDAO = new ReviewDAO(connection);
                List<Review> reviews = reviewDAO.getReviewsByMovie(movieID); // Fetch reviews by movieID
                movie.setReviews(reviews); // Set reviews for the movie

                connection.close();
                if (description != null) {
                    int firstPeriodIndex = description.indexOf('.');
                    if (firstPeriodIndex != -1 && firstPeriodIndex < description.length() - 1) {
                        String firstSentence = description.substring(0, firstPeriodIndex + 1);
                        String restDescription = description.substring(firstPeriodIndex + 1).trim();
                        request.setAttribute("firstSentence", firstSentence);
                        request.setAttribute("restDescription", restDescription);
                    } else {
                        // No period found or period at the end: entire description is the first sentence
                        request.setAttribute("firstSentence", description);
                        request.setAttribute("restDescription", "");
                    }
                } else {
                    request.setAttribute("firstSentence", "");
                    request.setAttribute("restDescription", "");
                }
            }

            request.setAttribute("movie", movie);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/MovieDetail.jsp");
            dispatcher.forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pages/Movies.jsp"); // Invalid movieID
        } catch (Exception e) {
            throw new ServletException("Database error fetching movie detail", e);
        }
    }
}