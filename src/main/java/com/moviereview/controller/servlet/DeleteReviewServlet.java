package com.moviereview.controller.servlet;

import java.io.IOException;
import java.sql.Connection;

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

@WebServlet("/DeleteReviewServlet")
public class DeleteReviewServlet extends HttpServlet {
    
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
            
            // Verify the review belongs to the current user before deleting
            Review review = reviewDao.getReviewByID(reviewId);
            if (review != null && review.getUserID() == user.getUserId()) {
                boolean deleted = reviewDao.deleteReview(reviewId);
                
                if (deleted) {
                    session.setAttribute("successMessage", "Review deleted successfully");
                } else {
                    session.setAttribute("errorMessage", "Failed to delete review");
                }
            } else {
                session.setAttribute("errorMessage", "You can only delete your own reviews");
            }
            
            // Redirect back to reviews page
            response.sendRedirect("ReviewReportServlet");
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error deleting review: " + e.getMessage());
            response.sendRedirect("ReviewReportServlet");
        }
    }
}