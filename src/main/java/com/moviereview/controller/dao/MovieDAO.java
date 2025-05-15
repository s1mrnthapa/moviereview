package com.moviereview.controller.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.Movies;

public class MovieDAO {
    private Connection conn;
    private PreparedStatement ps;

    // Constructor: Establishes database connection when MovieDAO is created
    public MovieDAO() throws SQLException, ClassNotFoundException {
        this.conn = DatabaseConnection.getConnection();  // Assuming DatabaseConnection provides a getConnection method
    }

    public boolean addMovie(Movies movie) {
        boolean isMovieAdded = false;

        String queryMovie = "INSERT INTO movie (title, release_date, duration, country, director, description, cast, image_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(queryMovie, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, movie.getTitle());
            ps.setDate(2, movie.getReleaseDate());
            ps.setString(3, movie.getDuration());
            ps.setString(4, movie.getCountry());
            ps.setString(5, movie.getDirector());
            ps.setString(6, movie.getDescription());

            String castString = String.join(", ", movie.getCast());
            ps.setString(7, castString);
            ps.setString(8, movie.getImagePath());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int movieID = generatedKeys.getInt(1);
                        movie.setMovieID(movieID);
                        insertGenres(conn, movie);
                        isMovieAdded = true;
                    }
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return isMovieAdded;
    }


    // Insert genres into the movie_genre junction table (Foreign Key Reference)
    private void insertGenres(Connection conn, Movies movie) {
        String queryGenre = "INSERT INTO movie_genre_table (movieID, genreID) VALUES (?, ?)";
        try {
            ps = conn.prepareStatement(queryGenre);
            for (String genreID : movie.getGenre()) {
                // Ensure genreID exists in the genre table before insertion
                // Assuming genreID is an integer and present in the genre table
                if (isValidGenre(genreID)) {
                    ps.setInt(1, movie.getMovieID());
                    ps.setInt(2, Integer.parseInt(genreID));  // Convert genreID to integer
                    ps.addBatch();  // Add the insert statement to the batch
                }
            }
            ps.executeBatch();  // Execute the batch insert for genres
        } catch (SQLException e) {
            e.printStackTrace();  // Log the error
        }
    }

    // Helper method to check if the genreID exists in the genre table (for foreign key validation)
    private boolean isValidGenre(String genreID) {
        String query = "SELECT COUNT(*) FROM genre WHERE genreID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, Integer.parseInt(genreID));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;  // Return true if genre exists
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private List<String> getGenresByMovieId(int movieId) throws SQLException {
        List<String> genres = new ArrayList<>();
        String sql = "SELECT g.genre FROM movie_genre_table mg JOIN genre g ON mg.genreID = g.genreID WHERE mg.movieID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, movieId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    genres.add(rs.getString("genre"));
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return genres;
    }

    private List<String> getCastFromMovieTable(int movieId) throws SQLException {
        List<String> castList = new ArrayList<>();
        String sql = "SELECT cast FROM movie WHERE movieID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, movieId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String castString = rs.getString("cast");
                    if (castString != null && !castString.isEmpty()) {
                        String[] castArray = castString.split("\\s*,\\s*"); // Split by commas
                        for (String castMember : castArray) {
                            castList.add(castMember);
                        }
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return castList;
    }
    public Movies getMovieById(int movieId) {
        Movies movie = null;
        String sql = "SELECT * FROM movie WHERE movieID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, movieId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    movie = new Movies();
                    movie.setMovieID(rs.getInt("movieID"));
                    movie.setTitle(rs.getString("title"));
                    movie.setDescription(rs.getString("description"));
                    movie.setDuration(rs.getString("duration"));
                    movie.setReleaseDate(rs.getDate("release_date"));
                    movie.setCountry(rs.getString("country"));
                    movie.setDirector(rs.getString("director"));
                    movie.setImagePath(rs.getString("image_path"));

                    // Fetch and set genres and cast
                    movie.setGenre(getGenresByMovieId(movieId));
                    movie.setCast(getCastFromMovieTable(movieId));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return movie;
    }

    public List<Movies> getAllMovies() throws SQLException {
        List<Movies> movies = new ArrayList<>();
        String sql = "SELECT * FROM movie"; // Select all movies from the movie table

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Movies movie = new Movies();  // Create an instance of Movies
                movie.setMovieID(rs.getInt("movieID"));
                movie.setTitle(rs.getString("title"));
                movie.setDescription(rs.getString("description"));
                movie.setDuration(rs.getString("duration"));
                movie.setReleaseDate(rs.getDate("release_date"));
                movie.setCountry(rs.getString("country"));
                movie.setDirector(rs.getString("director"));
                movie.setImagePath(rs.getString("image_path"));  // Get image path from database

                // Fetch and set genres and cast
                movie.setGenre(getGenresByMovieId(movie.getMovieID())); // Set genre
                movie.setCast(getCastFromMovieTable(movie.getMovieID()));   // Set cast

                movies.add(movie);  // Add movie to the list
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return movies;  // Return the list of movies
    }
}
