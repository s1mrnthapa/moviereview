package com.moviereview.controller.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.moviereview.controller.dao.MovieDAO;
import com.moviereview.controller.dao.ReviewDAO;
import com.moviereview.controller.dao.UserDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.Movies;


@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int totalMovies = 0;
        int totalUsers = 0;
        int totalReviews = 0;
        String topReviewerName = "N/A";
        int topReviewCount = 0;
        List<Movies> topRatedMovies = null;

        try (Connection conn = DatabaseConnection.getConnection()) {

            MovieDAO movieDAO = new MovieDAO();
            UserDAO userDAO = new UserDAO(conn);
            ReviewDAO reviewDAO = new ReviewDAO(conn);

            // Fetch totals
            totalMovies = movieDAO.getTotalMovies();
            totalUsers = userDAO.getTotalUsers();
            totalReviews = reviewDAO.getTotalReviews();

            // Fetch top reviewer
            Map<String, Integer> topReviewer = reviewDAO.getTopReviewerWithCount();
            if (!topReviewer.isEmpty()) {
                Map.Entry<String, Integer> entry = topReviewer.entrySet().iterator().next();
                topReviewerName = entry.getKey();
                topReviewCount = entry.getValue();
            }

            // Fetch top 5 rated movies
            topRatedMovies = movieDAO.getTopRatedMovies(5);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        // Pass data to JSP
        request.setAttribute("totalMovies", totalMovies);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalReviews", totalReviews);
        request.setAttribute("topReviewerName", topReviewerName);
        request.setAttribute("topReviewCount", topReviewCount);
        request.setAttribute("topRatedMovies", topRatedMovies);

        // Logging
        System.out.println("totalMovies: " + totalMovies);
        System.out.println("totalUsers: " + totalUsers);
        System.out.println("totalReviews: " + totalReviews);
        System.out.println("topReviewerName: " + topReviewerName);
        System.out.println("topReviewCount: " + topReviewCount);
        System.out.println("topRatedMovies: " + topRatedMovies);
        

        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/Dashboard.jsp");
        dispatcher.forward(request, response);
    }
}
