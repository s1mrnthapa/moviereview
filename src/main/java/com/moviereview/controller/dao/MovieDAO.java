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

    // Add a new movie to the database
    public boolean addMovie(Movies movie) {
        boolean isMovieAdded = false;

        // SQL query to insert the movie data into the movie table
        String queryMovie = "INSERT INTO movie (title, release_date, duration, country, director, description, cast, image_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        if (conn != null) {
            try {
                // Insert movie into the movie table
                ps = conn.prepareStatement(queryMovie, PreparedStatement.RETURN_GENERATED_KEYS);
                ps.setString(1, movie.getTitle());
                ps.setDate(2, movie.getReleaseDate());
                ps.setString(3, movie.getDuration());
                ps.setString(4, movie.getCountry());
                ps.setString(5, movie.getDirector());
                ps.setString(6, movie.getDescription());

                // Join the cast list into a comma-separated String
                String castString = String.join(", ", movie.getCast());
                ps.setString(7, castString);

                // Set the image path
                ps.setString(8, movie.getImagePath());  // Set the image path (from the form or file upload)

                int affectedRows = ps.executeUpdate();  // Execute the query to insert the movie

                if (affectedRows > 0) {
                    // Get the generated movieID
                    ResultSet generatedKeys = ps.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int movieID = generatedKeys.getInt(1);
                        movie.setMovieID(movieID);  // Set the movieID for the movie object

                        // Insert genres into the movie_genre junction table
                        insertGenres(movie);

                        isMovieAdded = true;  // Movie added successfully
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();  // Log the error
            }
        }
        return isMovieAdded;
    }

    // Insert genres into the movie_genre junction table (Foreign Key Reference)
    private void insertGenres(Movies movie) {
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
    
    public List<String> getAllGenres() throws SQLException {
        List<String> genres = new ArrayList<>();
        String sql = "SELECT genre_name FROM genre";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                genres.add(rs.getString("genre_name"));
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return genres;
    }


    public List<String> getGenresByMovieId(int movieId) throws SQLException {
        List<String> genres = new ArrayList<>();
        String sql = "SELECT g.genre_name FROM movie_genre_table mg JOIN genre g ON mg.genreID = g.genreID WHERE mg.movieID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, movieId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    genres.add(rs.getString("genre_name"));
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return genres;
    }

    public List<String> getCastFromMovieTable(int movieId) throws SQLException {
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
    public List<Movies> searchMoviesByTitle(String keyword, Connection conn) {
    	List<Movies> movies = new ArrayList<>();
    	String sql = "SELECT * FROM movie WHERE LOWER(title) LIKE ? ORDER BY title ASC";
    	try (PreparedStatement ps = conn.prepareStatement(sql)) {
    	    ps.setString(1, "%" + keyword.toLowerCase() + "%");
    	    ResultSet rs = ps.executeQuery();
    	    
    	    while (rs.next()) {
    	        int movieID = rs.getInt("movieID");
    	        String title = rs.getString("title");
    	        java.sql.Date releaseDate = rs.getDate("release_date");
    	        String duration = rs.getString("duration");
    	        String country = rs.getString("country");
    	        String director = rs.getString("director");
    	        String description = rs.getString("description");
    	        String castString = rs.getString("cast");
    	        String imagePath = rs.getString("image_path");

    	        // Optional: fetch genres via another query if genre string is not directly in 'movie' table
    	        // Here we assume genre is stored in another table and needs to be fetched elsewhere

    	        Movies movie = new Movies(movieID, title, releaseDate, duration, country, director, description, castString, imagePath);
    	        movies.add(movie);
    	    }
    	} catch (SQLException e) {
    	    e.printStackTrace();
    	}

    	return movies;
    }
    public Movies getMovieByID(int movieID) {
        Movies movie = null;
        String sql = "SELECT * FROM movie WHERE movieID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, movieID);
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
                    movie.setGenre(getGenresByMovieId(movieID));
                    movie.setCast(getCastFromMovieTable(movieID));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return movie;
    }
    public void deleteGenresByMovieID(int movieID) {
        String sql = "DELETE FROM movie_genre_table WHERE movieID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, movieID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public int getGenreIDByName(String genreName) throws Exception {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT genreID FROM genre WHERE genre_name = ?")) {
            ps.setString(1, genreName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("genreID");
                } else {
                    throw new Exception("Genre not found: " + genreName);
                }
            }
        }
    }

    public boolean updateMovie(Movies movie) {
        String sql = "UPDATE movie SET title = ?, release_date = ?, duration = ?, country = ?, director = ?, description = ?, cast = ?, image_path = ? WHERE movieID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, movie.getTitle());
            ps.setDate(2, movie.getReleaseDate());
            ps.setString(3, movie.getDuration());
            ps.setString(4, movie.getCountry());
            ps.setString(5, movie.getDirector());
            ps.setString(6, movie.getDescription());
            ps.setString(7, String.join(", ", movie.getCast()));
            ps.setString(8, movie.getImagePath());
            ps.setInt(9, movie.getMovieID());

            int updated = ps.executeUpdate();

            if (updated > 0) {
                // First delete old genres, then insert new ones
                deleteGenresByMovieID(movie.getMovieID());
                insertGenres(movie);
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteMovie(int movieID) {
        String deleteGenreSQL = "DELETE FROM movie_genre_table WHERE movieID = ?";
        String deleteMovieSQL = "DELETE FROM movie WHERE movieID = ?";

        try (PreparedStatement ps1 = conn.prepareStatement(deleteGenreSQL);
             PreparedStatement ps2 = conn.prepareStatement(deleteMovieSQL)) {

            // First delete the related genres from junction table
            ps1.setInt(1, movieID);
            ps1.executeUpdate();

            // Then delete the movie
            ps2.setInt(1, movieID);
            int affectedRows = ps2.executeUpdate();

            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    
    // Method to get the total number of movies
    public int getTotalMovies() {
        String sql = "SELECT COUNT(*) FROM movie";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Return 0 if there's an error or no movies found
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
    
    
    public List<Movies> getTopRatedMovies(int limit) {
        List<Movies> topMovies = new ArrayList<>();
        String sql = "SELECT m.movieID, m.title, AVG(r.rating) as avgRating " +
                     "FROM movie m JOIN review r ON m.movieID = r.movieID " +
                     "GROUP BY m.movieID, m.title " +
                     "ORDER BY avgRating DESC LIMIT ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Movies movie = new Movies();
                movie.setMovieID(rs.getInt("movieID"));
                movie.setTitle(rs.getString("title"));
                movie.setAverageRating(rs.getDouble("avgRating"));
                topMovies.add(movie);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return topMovies;
    }
    
    public List<Movies> getUpcomingMovies() {
        List<Movies> upcomingMovies = new ArrayList<>();
        String sql = "SELECT * FROM movie WHERE release_date > CURDATE() ORDER BY release_date ASC LIMIT 10";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Movies movie = new Movies();
                movie.setMovieID(rs.getInt("movieID"));
                movie.setTitle(rs.getString("title"));
                movie.setReleaseDate(rs.getDate("release_date"));
                movie.setImagePath(rs.getString("image_path"));
                upcomingMovies.add(movie);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return upcomingMovies;
    }
    
    

}