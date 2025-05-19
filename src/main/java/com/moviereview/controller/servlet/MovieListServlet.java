package com.moviereview.controller.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.moviereview.model.Movies;
import com.moviereview.controller.database.DatabaseConnection;

@WebServlet("/MovieListServlet")
public class MovieListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String yearParam = request.getParameter("year");
        String genreParam = request.getParameter("genre");
        String keywordParam = request.getParameter("keyword");

        String year = (yearParam != null && !yearParam.trim().isEmpty()) ? yearParam.trim() : null;
        String genre = (genreParam != null && !genreParam.trim().isEmpty()) ? genreParam.trim() : null;
        String keyword = (keywordParam != null && !keywordParam.trim().isEmpty()) ? keywordParam.trim().toLowerCase() : null;

        List<Movies> moviesList = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection()) {

            StringBuilder sql = new StringBuilder(
                "SELECT DISTINCT m.* FROM movie m " +
                "LEFT JOIN movie_genre_table mg ON m.movieID = mg.movieID " +
                "LEFT JOIN genre g ON mg.genreID = g.genreID " +
                "WHERE 1=1 "
            );

            boolean filterYearByUpcoming = "Upcoming".equalsIgnoreCase(year);
            int paramIndex = 1;
            List<Object> params = new ArrayList<>();

            if (keyword != null) {
                sql.append("AND LOWER(m.title) LIKE ? ");
                params.add("%" + keyword + "%");
            }

            if (year != null && !filterYearByUpcoming) {
                try {
                    int yearInt = Integer.parseInt(year);
                    sql.append("AND YEAR(m.release_date) BETWEEN ? AND ? ");
                    params.add(yearInt);
                    params.add(yearInt + 9);
                } catch (NumberFormatException e) {
                    // Invalid year input
                }
            } else if (filterYearByUpcoming) {
                sql.append("AND m.release_date > CURDATE() ");
            }

            if (genre != null) {
                sql.append("AND g.genre_name = ? ");
                params.add(genre);
            }

            PreparedStatement ps = connection.prepareStatement(sql.toString());

            for (Object param : params) {
                ps.setObject(paramIndex++, param);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int movieID = rs.getInt("movieID");
                String title = rs.getString("title");
                Date releaseDate = rs.getDate("release_date");
                String duration = rs.getString("duration");
                String country = rs.getString("country");
                String director = rs.getString("director");
                String description = rs.getString("description");
                String castString = rs.getString("cast");
                String imagePath = rs.getString("image_path");

                Movies movie = new Movies(movieID, title, releaseDate, duration, country, director, description, castString, imagePath);

                String genreSql = "SELECT g.genre_name FROM genre g " +
                        "INNER JOIN movie_genre_table mg ON g.genreID = mg.genreID " +
                        "WHERE mg.movieID = ?";

                try (PreparedStatement genreStmt = connection.prepareStatement(genreSql)) {
                    genreStmt.setInt(1, movieID);
                    ResultSet genreRs = genreStmt.executeQuery();

                    List<String> genres = new ArrayList<>();
                    while (genreRs.next()) {
                        genres.add(genreRs.getString("genre_name"));
                    }
                    movie.setGenre(genres);
                }

                moviesList.add(movie);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        if (moviesList.isEmpty()) {
            request.setAttribute("error", "No movies found matching your filters.");
        }

        request.setAttribute("movies", moviesList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/Movies.jsp");
        dispatcher.forward(request, response);

        System.out.println("Movie list returned. Count: " + moviesList.size());
    }
}
