package com.moviereview.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Review {
    private int reviewID;
    private int movieID;
    private int userID;
    private String reviewDescription;
    private int rating;
    private Timestamp review_date;
    private User user;
    
 // Constructors
    public Review() {}

    public Review(int movieID, int userID, String reviewDescription, int rating) {
        this.movieID = movieID;
        this.userID = userID;
        this.reviewDescription = reviewDescription;
        this.rating = rating;
    }

    public Review(int reviewID, int movieID, int userID, String reviewDescription, int rating, Timestamp review_date) {
        this.reviewID = reviewID;
        this.movieID = movieID;
        this.userID = userID;
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
    public String getUsername() {
        return user != null ? user.getUsername() : null; // Return username from User object
    }

    public void setUser(User user) {
        this.user = user;
    }

	public void setTitle(String string) {
		// TODO Auto-generated method stub
		
	}
}

