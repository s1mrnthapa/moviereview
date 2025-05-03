package com.moviereview.controller.servlet;

import java.io.IOException;
import java.sql.*;
import java.sql.Date;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.moviereview.model.Movies;
import com.moviereview.controller.database.DatabaseConnection;

@WebServlet("/MovieListServlet")
public class MovieListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Movies> moviesList = new ArrayList<>();

        try {
            Connection connection = DatabaseConnection.getConnection();

            String movieSql = "SELECT * FROM movie";
            PreparedStatement movieStatement = connection.prepareStatement(movieSql);
            ResultSet movieResultSet = movieStatement.executeQuery();

            while (movieResultSet.next()) {
                int movieID = movieResultSet.getInt("movieID");
                String title = movieResultSet.getString("title");
                Date releaseDate = movieResultSet.getDate("release_date");
                String duration = movieResultSet.getString("duration");
                String country = movieResultSet.getString("country");
                String director = movieResultSet.getString("director");
                String description = movieResultSet.getString("description");
                String castString = movieResultSet.getString("cast");
                String imagePath = movieResultSet.getString("image_path");

                Movies movie = new Movies(movieID, title, releaseDate, duration, country, director, description, castString, imagePath);

                // 👉 Now fetch genres separately from the junction table
                String genreSql = "SELECT g.genre_name FROM genre g "
                        + "INNER JOIN movie_genre_table mg ON g.genreID = mg.genreID "
                        + "WHERE mg.movieID = ?";
                
                PreparedStatement genreStatement = connection.prepareStatement(genreSql);
                genreStatement.setInt(1, movieID);
                ResultSet genreResultSet = genreStatement.executeQuery();

                List<String> genres = new ArrayList<>();
                while (genreResultSet.next()) {
                    genres.add(genreResultSet.getString("genre_name"));
                }
                movie.setGenre(genres);

                moviesList.add(movie);

                System.out.println(movie);
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("movies", moviesList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/Movies.jsp");
        dispatcher.forward(request, response);
        System.out.println("Passing movies list to JSP: " + moviesList);
    }
}
