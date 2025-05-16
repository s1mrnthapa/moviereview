package com.moviereview.controller.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.moviereview.model.Review;

public class ReviewDAO {
    private Connection conn;

    public ReviewDAO(Connection connection) {
        this.conn = connection;
    }

    // Insert a new review
    public boolean addReview(Review review) {
        String sql = "INSERT INTO review (movieID, userID, reviewDescription, rating) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, review.getMovieID());
            ps.setInt(2, review.getUserID());
            ps.setString(3, review.getReviewDescription());
            ps.setInt(4, review.getRating());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all reviews for a particular movie
    public List<Review> getReviewsByMovie(int movieID) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT * FROM review WHERE movieID = ? ORDER BY review_date DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, movieID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Review review = new Review(
                    rs.getInt("reviewID"),
                    rs.getInt("movieID"),
                    rs.getInt("userID"),
                    rs.getString("reviewDescription"),
                    rs.getInt("rating"),
                    rs.getTimestamp("review_date")
                );
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    // Get a review by its reviewID
    public Review getReviewByID(int reviewID) {
        String sql = "SELECT * FROM review WHERE reviewID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reviewID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Review(
                    rs.getInt("reviewID"),
                    rs.getInt("movieID"),
                    rs.getInt("userID"),
                    rs.getString("reviewDescription"),
                    rs.getInt("rating"),
                    rs.getTimestamp("review_date")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
