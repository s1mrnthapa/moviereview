package com.moviereview.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Review {
    private int reviewID;
    private int movieID;
    private int userID;
    private String username;
    private String reviewDescription;
    private int rating;
    private Timestamp review_date;
    private User user;
    private String movieTitle;
    private String releaseYear;
    private String movieImage;
    
 // Constructors
    public Review() {}

    public Review(int movieID, int userID, String username, String reviewDescription, int rating) {
        this.movieID = movieID;
        this.userID = userID;
        this.username = username;
        this.reviewDescription = reviewDescription;
        this.rating = rating;
    }

    public Review(int reviewID, int movieID, int userID, String username, String reviewDescription, int rating, Timestamp review_date) {
        this.reviewID = reviewID;
        this.movieID = movieID;
        this.userID = userID;
        this.username = username;
        this.reviewDescription = reviewDescription;
        this.rating = rating;
        this.review_date = review_date;
    }

    // Getters and Setters
    public int getReviewID() {
        return reviewID;
    }

    public void setReviewID(int reviewID) {
        this.reviewID = reviewID;
    }

    public int getMovieID() {
        return movieID;
    }

    public void setMovieID(int movieID) {
        this.movieID = movieID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }
    public String getUsername() {
        return user != null ? user.getUsername() : username;
    }

    public void setUsername(String username) {
        this.username = username;
        if (this.user != null) {
            this.user.setUsername(username);
        }
    }

    public String getReviewDescription() {
        return reviewDescription;
    }

    public void setReviewDescription(String reviewDescription) {
        this.reviewDescription = reviewDescription;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public Timestamp getReviewDate() {
        return review_date;
    }

    public void setReviewDate(Timestamp date) {
        this.review_date= date;
    }
    public void setUser(User user) {
        this.user = user;
    }

    public User getUser() {
        return this.user;
    }
    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public String getReleaseYear() {
        return releaseYear;
    }

    public void setReleaseYear(String releaseYear) {
        this.releaseYear = releaseYear;
    }
    public String getMovieImage() {
        return movieImage;
    }
    
    public void setMovieImage(String movieImage) {
        this.movieImage = movieImage;
    }
    
}
