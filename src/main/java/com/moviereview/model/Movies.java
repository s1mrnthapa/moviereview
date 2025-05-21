package com.moviereview.model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Movies {
    private int movieID;
    private String title;
    private Date releaseDate;
    private String duration;
    private String country;
    private String director;
    private String description;
    private List<Review> reviews;
    private double averageRating;
    
    // Lists to hold associated genre and casts
    private List<String> genre;
    private List<String> cast;

    // Field for image path
    private String imagePath;
    
    // No-argument constructor
    public Movies() {
        this.genre = new ArrayList<>();
        this.cast = new ArrayList<>();
    }

    // Constructor to initialize a movie object with image path
    public Movies(String title, Date releaseDate, String duration, String country, String director, String description, String castString, String imagePath) {
        this.title = title;
        this.releaseDate = releaseDate;
        this.duration = duration;
        this.country = country;
        this.director = director;
        this.description = description;
        this.genre = new ArrayList<>();
        this.cast = splitCastString(castString);
        this.imagePath = imagePath;
    }

    // Constructor to initialize a movie object with image path
    public Movies(int movieID, String title, Date releaseDate, String duration, String country, String director, String description, String castString, String imagePath) {
        this.movieID = movieID;
        this.title = title;
        this.releaseDate = releaseDate;
        this.duration = duration;
        this.country = country;
        this.director = director;
        this.description = description;
        this.genre = new ArrayList<>();
        this.cast = splitCastString(castString);
        this.imagePath = imagePath;
    }
    public Movies(int movieID, String title, Date releaseDate, String duration, String country, String director, String description, String castString, String genreString, String imagePath, List<Review> reviews) {
        this.movieID = movieID;
        this.title = title;
        this.releaseDate = releaseDate;
        this.duration = duration;
        this.country = country;
        this.director = director;
        this.description = description;
        this.cast = splitCastString(castString);
        this.genre = splitGenreString(genreString);
        this.imagePath = imagePath;
        this.reviews = reviews;
    }

    
    private List<String> splitCastString(String castString) {
        if (castString != null && !castString.trim().isEmpty()) {
            return Arrays.asList(castString.split("\\s*,\\s*"));
        } else {
            return new ArrayList<>();
        }
    }

    // Getters and Setters
    public int getMovieID() {
        return movieID;
    }

    public void setMovieID(int movieID) {
        this.movieID = movieID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<String> getGenre() {
        return genre;
    }

    public void setGenre(List<String> genre) {
        this.genre = genre;
    }

    public List<String> getCast() {
        return cast;
    }

    public void setCast(List<String> cast) {
        this.cast = cast;
    }

    // Getter and Setter for imagePath
    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    public List<Review> getReviews() {
        return reviews;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }

    // Utility methods for genres and cast
    public void addGenre(String genre) {
        this.genre.add(genre);
    }

    public void addCast(String castMember) {
        this.cast.add(castMember);
    }
    public double getAverageRating() {
        return averageRating;
    }
    public void setAverageRating(double averageRating) {
        this.averageRating = averageRating;
    }
    private List<String> splitGenreString(String genreString) {
        if (genreString != null && !genreString.trim().isEmpty()) {
            return Arrays.asList(genreString.split("\\s*,\\s*"));
        } else {
            return new ArrayList<>();
        }
    }

    @Override
    public String toString() {
        return "Movies [movieID=" + movieID + ", title=" + title + ", releaseDate=" + releaseDate + ", duration=" + duration
                + ", country=" + country + ", director=" + director + ", description=" + description + ", genre=" + genre
                + ", cast=" + cast + ", imagePath=" + imagePath + "]";
    }
}