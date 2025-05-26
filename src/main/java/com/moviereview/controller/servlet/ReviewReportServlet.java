package com.moviereview.controller.servlet;


import com.moviereview.controller.dao.ReviewDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.Review;
import com.moviereview.model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/ReviewReportServlet")
public class ReviewReportServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String successMessage = (String) session.getAttribute("successMessage");
        String errorMessage = (String) session.getAttribute("errorMessage");

        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            session.removeAttribute("errorMessage");
        }
        
        // Get sorting parameter
        String sortOption = request.getParameter("sort");
        if (sortOption == null) {
            sortOption = "newest"; // default
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            ReviewDAO reviewDao = new ReviewDAO(conn);
            
            // Get all reviews for the current user with sorting
            //List<Review> allReviews = reviewDao.getAllReviewsByUser(user.getUserId(), sortOption);
            
            System.out.println("Fetching reviews for user ID: " + user.getUserId());
            List<Review> allReviews = reviewDao.getAllReviewsByUser(user.getUserId(), sortOption);
            
            System.out.println("Number of reviews found: " + allReviews.size());
            if (!allReviews.isEmpty()) {
                System.out.println("First review movie image: " + allReviews.get(0).getMovieImage());
            }
            
            // Set the reviews as a request attribute
            request.setAttribute("allReviews", allReviews);
            request.setAttribute("sortOption", sortOption);
            
            // Forward to the Review.jsp page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/Review.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error fetching reviews: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/Review.jsp");
            dispatcher.forward(request, response);
        }
    }
}