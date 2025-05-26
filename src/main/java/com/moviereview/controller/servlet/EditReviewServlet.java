package com.moviereview.controller.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.moviereview.controller.dao.ReviewDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.Review;
import com.moviereview.model.User;

@WebServlet("/EditReviewServlet")
public class EditReviewServlet extends HttpServlet {
    
    // Handle GET request (display edit form)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get review ID from request
        int reviewId = Integer.parseInt(request.getParameter("reviewID"));
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            ReviewDAO reviewDao = new ReviewDAO(conn);
            
            // Get the review and verify it belongs to the current user
            Review review = reviewDao.getReviewByID(reviewId);
            if (review != null && review.getUserID() == user.getUserId()) {
                request.setAttribute("review", review);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/EditReview.jsp");
                dispatcher.forward(request, response);
            } else {
                session.setAttribute("errorMessage", "You can only edit your own reviews");
                response.sendRedirect("ReviewReportServlet");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error loading review: " + e.getMessage());
            response.sendRedirect("ReviewReportServlet");
        }
    }
    
    // Handle POST request (process form submission)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get form data
        int reviewId = Integer.parseInt(request.getParameter("reviewID"));
        String reviewDescription = request.getParameter("reviewDescription");
        int rating = Integer.parseInt(request.getParameter("rating"));
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            ReviewDAO reviewDao = new ReviewDAO(conn);
            
            // Verify the review belongs to the current user before updating
            Review existingReview = reviewDao.getReviewByID(reviewId);
            if (existingReview != null && existingReview.getUserID() == user.getUserId()) {
                // Create updated review object
                Review updatedReview = new Review();
                updatedReview.setReviewID(reviewId);
                updatedReview.setReviewDescription(reviewDescription);
                updatedReview.setRating(rating);
                updatedReview.setMovieID(existingReview.getMovieID());
                updatedReview.setUserID(user.getUserId());
                
                boolean updated = reviewDao.updateReview(updatedReview);
                
                if (updated) {
                    session.setAttribute("successMessage", "Review updated successfully");
                } else {
                    session.setAttribute("errorMessage", "Failed to update review");
                }
            } else {
                session.setAttribute("errorMessage", "You can only edit your own reviews");
            }
            
            // Redirect back to reviews page
            response.sendRedirect("ReviewReportServlet");
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error updating review: " + e.getMessage());
            response.sendRedirect("ReviewReportServlet");
        }
    }
}