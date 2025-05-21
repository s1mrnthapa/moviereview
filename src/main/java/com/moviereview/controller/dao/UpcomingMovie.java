package com.moviereview.controller.dao;



public class UpcomingMovie {
    private int id;
    private String title;
    private String description;
    private String releaseDate;
    private String posterUrl;

    public UpcomingMovie(int id, String title, String description, String releaseDate, String posterUrl) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.releaseDate = releaseDate;
        this.posterUrl = posterUrl;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getReleaseDate() {
        return releaseDate;
    }

    public String getPosterUrl() {
        return posterUrl;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setReleaseDate(String releaseDate) {
        this.releaseDate = releaseDate;
    }

    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }
}
