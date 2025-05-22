package com.moviereview.controller.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.moviereview.controller.dao.ReviewDAO;
import com.moviereview.controller.dao.UserDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.Review;
import com.moviereview.model.User;

@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ReviewServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("[DEBUG] Received POST request for submitting review.");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userID") == null) {
            System.out.println("[ERROR] User not logged in. Redirecting to login page.");
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        // Retrieve session user data
        int userID = (int) session.getAttribute("userID");
        String username = (String) session.getAttribute("username");

        if (username == null || username.isEmpty()) {
            // If username not found in session, fetch from DB
            try (Connection connection = DatabaseConnection.getConnection()) {
                UserDAO userDAO = new UserDAO(connection);
                User user = userDAO.getUserById(userID);
                if (user != null) {
                    username = user.getUsername();
                    session.setAttribute("username", username);
                } else {
                    System.out.println("[ERROR] Failed to retrieve user from DB.");
                    response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
                return;
            }
        }

        // Get form data
        String movieIdParam = request.getParameter("movieID");
        String reviewDescription = request.getParameter("reviewDescription");
        String ratingParam = request.getParameter("rating");

        System.out.println("[DEBUG] movieID = " + movieIdParam);
        System.out.println("[DEBUG] userID = " + userID);
        System.out.println("[DEBUG] username = " + username);
        System.out.println("[DEBUG] reviewDescription = " + reviewDescription);
        System.out.println("[DEBUG] rating = " + ratingParam);

        if (movieIdParam == null || ratingParam == null ||
                movieIdParam.isEmpty() || ratingParam.isEmpty()) {
            System.out.println("[ERROR] Missing form data. Redirecting to Movies.jsp");
            response.sendRedirect(request.getContextPath() + "/pages/Movies.jsp");
            return;
        }

        try {
            int movieID = Integer.parseInt(movieIdParam);
            int rating = Integer.parseInt(ratingParam);

            // Create Review object
            Review review = new Review();
            review.setMovieID(movieID);
            review.setUserID(userID);
            review.setUsername(username);
            review.setReviewDescription(reviewDescription);
            review.setRating(rating);

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