package com.moviereview.controller.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.moviereview.controller.dao.MovieDAO;
import com.moviereview.controller.dao.ReviewDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.Movies;

@WebServlet("/UpcomingServlet")
public class UpcomingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Movies> trendingMovies = null;
        List<Movies> upcomingMovies = null;

        try (Connection conn = DatabaseConnection.getConnection()) {

            ReviewDAO reviewDAO = new ReviewDAO(conn);
            MovieDAO movieDAO = new MovieDAO();

            trendingMovies = reviewDAO.getTrendingMovies();      
            upcomingMovies = movieDAO.getUpcomingMovies();       

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        request.setAttribute("trendingMovies", trendingMovies);
        request.setAttribute("upcomingMovies", upcomingMovies);

        System.out.println("Trending Movies: " + trendingMovies);
        System.out.println("Upcoming Movies: " + upcomingMovies);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/Upcoming.jsp");
        dispatcher.forward(request, response);
    }
}