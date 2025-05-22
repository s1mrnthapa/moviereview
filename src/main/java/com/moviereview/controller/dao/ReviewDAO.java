package com.moviereview.controller.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.moviereview.model.Movies;
import com.moviereview.model.Review;

public class ReviewDAO {
    private Connection conn;

    public ReviewDAO(Connection connection) {
        this.conn = connection;
    }

    // Insert a new review
    public boolean addReview(Review review) {
        String sql = "INSERT INTO review (movieID, userID, username, reviewDescription, rating) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, review.getMovieID());
            ps.setInt(2, review.getUserID());
            ps.setString(3, review.getUsername());
            ps.setString(4, review.getReviewDescription());
            ps.setInt(5, review.getRating());
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
                    rs.getString("userName"),
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
                    rs.getString("username"),
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
    
    
 // ✅ Get total reviews in the database
    public int getTotalReviews() {
        String sql = "SELECT COUNT(*) FROM review";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public Map<String, Integer> getTopReviewerWithCount() {
        String sql = "SELECT u.username, COUNT(r.reviewID) AS review_count " +
                     "FROM user u " +
                     "JOIN review r ON u.userID = r.userID " +
                     "GROUP BY u.username " +
                     "ORDER BY review_count DESC " +
                     "LIMIT 1";

        Map<String, Integer> result = new HashMap<>();
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                result.put(rs.getString("username"), rs.getInt("review_count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    
	/* method that gets trending movies */
    public List<Movies> getTrendingMovies() {
        List<Movies> trending = new ArrayList<>();

        String sql = "SELECT m.movieID, m.title, m.image_path, ROUND(AVG(r.rating), 2) AS avg_rating " +
                     "FROM movie m " +
                     "JOIN review r ON m.movieID = r.movieID " +
                     "WHERE r.review_date >= CURDATE() - INTERVAL 7 DAY " +
                     "GROUP BY m.movieID, m.title, m.image_path " +
                     "ORDER BY avg_rating DESC " +
                     "LIMIT 10";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Movies movie = new Movies();
                movie.setMovieID(rs.getInt("movieID"));
                movie.setTitle(rs.getString("title"));
                movie.setImagePath(rs.getString("image_path"));
                movie.setAverageRating(rs.getDouble("avg_rating")); // ⚠️ Make sure this field exists in your Movies class

                trending.add(movie);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return trending;
    }
}
