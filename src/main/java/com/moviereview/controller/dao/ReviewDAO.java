package com.moviereview.controller.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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
    public boolean updateReview(Review review) throws SQLException {
        String sql = "UPDATE review SET reviewDescription = ?, rating = ? WHERE reviewID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, review.getReviewDescription());
            ps.setInt(2, review.getRating());
            ps.setInt(3, review.getReviewID());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }
    public boolean deleteReview(int reviewId) throws SQLException {
        String sql = "DELETE FROM review WHERE reviewID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reviewId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }
    public List<Review> getAllReviewsByUser(int userId, String sortOption) {
        List<Review> reviews = new ArrayList<>();
        
        String baseSql = "SELECT r.*, m.title as movieTitle, m.image_path as movieImage FROM review r " +
                "JOIN movie m ON r.movieID = m.movieID " +
                "WHERE r.userID = ? ";
        
        // Add sorting based on the option (keep existing sort logic)
        String orderBy;
        switch (sortOption) {
            case "newest":
                orderBy = "ORDER BY r.review_date DESC";
                break;
            case "oldest":
                orderBy = "ORDER BY r.review_date ASC";
                break;
            case "highest":
                orderBy = "ORDER BY r.rating DESC";
                break;
            case "lowest":
                orderBy = "ORDER BY r.rating ASC";
                break;
            default:
                orderBy = "ORDER BY r.review_date DESC";
        }
        
        String sql = baseSql + orderBy;
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Review review = new Review();
                review.setReviewID(rs.getInt("reviewID"));
                review.setMovieID(rs.getInt("movieID"));
                review.setRating(rs.getInt("rating"));
                review.setReviewDate(rs.getTimestamp("review_date"));
                review.setReviewDescription(rs.getString("reviewDescription"));
                review.setMovieTitle(rs.getString("movieTitle"));
                review.setMovieImage(rs.getString("movieImage"));
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }
    // In ReviewDAO.java
    public List<Review> getRecentReviewsByUser(int userId, int limit) {
        System.out.println("DEBUG: Fetching reviews for userID=" + userId); // Add this
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, m.title as movieTitle, m.image_path as movieImage " +
                    "FROM review r JOIN movie m ON r.movieID = m.movieID " +
                    "WHERE r.userID = ? ORDER BY r.review_date DESC LIMIT ?";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, limit);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                System.out.println("DEBUG: Found review - Rating=" + rs.getInt("rating") + 
                                 ", Title=" + rs.getString("movieTitle")); // Add this
                
                Review review = new Review();
                review.setReviewID(rs.getInt("reviewID"));
                review.setRating(rs.getInt("rating")); // Make sure this line exists
                review.setMovieTitle(rs.getString("movieTitle"));
                review.setReviewDescription(rs.getString("reviewDescription"));
                review.setMovieImage(rs.getString("movieImage"));
                review.setReviewDate(rs.getTimestamp("review_date"));
                
                reviews.add(review);
            }
        } catch (SQLException e) {
            System.out.println("ERROR in getRecentReviewsByUser: " + e.getMessage()); // Add this
            e.printStackTrace();
        }
        return reviews;
    }
 // Returns total number of reviews by a user
    public int getTotalReviewsByUser(int userId) {
        String sql = "SELECT COUNT(*) AS total FROM review WHERE userID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Returns list of unique movie IDs reviewed by a user
    public List<Integer> getReviewedMovieIdsByUser(int userId) {
        List<Integer> movieIds = new ArrayList<>();
        String sql = "SELECT DISTINCT movieID FROM review WHERE userID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                movieIds.add(rs.getInt("movieID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movieIds;
    }


}