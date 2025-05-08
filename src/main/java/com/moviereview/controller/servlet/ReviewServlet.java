package com.moviereview.controller.servlet;

import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.moviereview.controller.dao.ReviewDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.Review;

@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ReviewServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("[DEBUG] Received POST request for submitting review.");

        // Get form data
        String movieIdParam = request.getParameter("movieID");
        String userIdParam = request.getParameter("userID");
        String reviewDescription = request.getParameter("reviewDescription");
        String ratingParam = request.getParameter("rating");

        System.out.println("[DEBUG] movieID = " + movieIdParam);
        System.out.println("[DEBUG] userID = " + userIdParam);
        System.out.println("[DEBUG] reviewDescription = " + reviewDescription);
        System.out.println("[DEBUG] rating = " + ratingParam);

        if (movieIdParam == null || userIdParam == null || ratingParam == null || 
            movieIdParam.isEmpty() || userIdParam.isEmpty() || ratingParam.isEmpty()) {
            System.out.println("[ERROR] Missing form data. Redirecting to Movies.jsp");
            response.sendRedirect(request.getContextPath() + "/pages/Movies.jsp");
            return;
        }

        try {
            int movieID = Integer.parseInt(movieIdParam);
            int userID = Integer.parseInt(userIdParam);
            int rating = Integer.parseInt(ratingParam);

            // Create Review object
            Review review = new Review();
            review.setMovieID(movieID);
            review.setUserID(userID);
            review.setReviewDescription(reviewDescription);
            review.setRating(rating);

            // Establish connection and insert review via DAO
            try (Connection connection = DatabaseConnection.getConnection()) {
                ReviewDAO reviewDAO = new ReviewDAO(connection);
                boolean isInserted = reviewDAO.addReview(review);
                if (isInserted) {
                    System.out.println("[DEBUG] Review successfully inserted.");
                } else {
                    System.out.println("[ERROR] Failed to insert review.");
                }
            }

            // Redirect to movie detail page
            response.sendRedirect(request.getContextPath() + "/MovieDetail?movieID=" + movieID);
            System.out.println("[DEBUG] Redirected to MovieDetail page.");

        } catch (NumberFormatException e) {
            System.out.println("[ERROR] Invalid number format: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/pages/Movies.jsp");
        } catch (Exception e) {
            System.out.println("[ERROR] Exception occurred while submitting review: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error submitting review", e);
        }
    }
}
