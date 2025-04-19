package com.moviereview.controller.dao;
import com.moviereview.model.moviereview;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

public class MovieDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3308/moviereview";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    public List<moviereview> getAllMovies() {
        List<moviereview> movieList = new ArrayList<>();
        String query = "SELECT * FROM movies";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String director = rs.getString("director");
                String genre = rs.getString("genre");
                int releaseYear = rs.getInt("releaseYear");

                moviereview movie = new moviereview(id, title, director, genre, releaseYear);
                movieList.add(movie);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movieList;
    }
}
