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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.moviereview.controller.dao.MovieDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.Movies;


/**
 * Servlet implementation class AdminMoviesServlet
 */
@WebServlet("/AdminMoviesServlet")
public class AdminMoviesServlet extends HttpServlet {

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
                   
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

            // Parse the release date
            java.sql.Date releaseDate = java.sql.Date.valueOf(releaseDateStr); // Ensure input is yyyy-MM-dd

            // Construct the movie object
            Movies movie = new Movies(movieID, title, releaseDate, duration, country, director, description, cast, imagePath);

            // Update the movie using DAO
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
