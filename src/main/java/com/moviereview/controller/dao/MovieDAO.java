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

    // Constructor
    public MovieDAO() throws SQLException, ClassNotFoundException {
        this.conn = DatabaseConnection.getConnection();
    }

    // Add a movie and insert genres
    public boolean addMovie(Movies movie) {
        boolean isMovieAdded = false;
        String queryMovie = "INSERT INTO movie (title, release_date, duration, country, director, description, cast, image_path) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

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

    // Insert genres into junction table
    private void insertGenres(Connection conn, Movies movie) {
        String queryGenre = "INSERT INTO movie_genre_table (movieID, genreID) VALUES (?, ?)";
        try {
            ps = conn.prepareStatement(queryGenre);
            for (String genreID : movie.getGenre()) {
                if (isValidGenre(genreID)) {
                    ps.setInt(1, movie.getMovieID());
                    ps.setInt(2, Integer.parseInt(genreID));
                    ps.addBatch();
                }
            }
            ps.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Validate genre ID
    private boolean isValidGenre(String genreID) {
        String query = "SELECT COUNT(*) FROM genre WHERE genreID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, Integer.parseInt(genreID));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get genres by movie ID
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

    // Get cast by movie ID
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
                        String[] castArray = castString.split("\\s*,\\s*");
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

    // Get movie by ID
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
                    movie.setGenre(getGenresByMovieId(movieId));
                    movie.setCast(getCastFromMovieTable(movieId));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return movie;
    }

    // Get all movies
    public List<Movies> getAllMovies() throws SQLException {
        List<Movies> movies = new ArrayList<>();
        String sql = "SELECT * FROM movie";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Movies movie = new Movies();
                movie.setMovieID(rs.getInt("movieID"));
                movie.setTitle(rs.getString("title"));
                movie.setDescription(rs.getString("description"));
                movie.setDuration(rs.getString("duration"));
                movie.setReleaseDate(rs.getDate("release_date"));
                movie.setCountry(rs.getString("country"));
                movie.setDirector(rs.getString("director"));
                movie.setImagePath(rs.getString("image_path"));
                movie.setGenre(getGenresByMovieId(movie.getMovieID()));
                movie.setCast(getCastFromMovieTable(movie.getMovieID()));
                movies.add(movie);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return movies;
    }

    // Get movies by year and genre filters
    public List<Movies> getMoviesByFilter(String yearPrefix, String genre) throws SQLException {
        List<Movies> moviesList = new ArrayList<>();
        String sql = "SELECT DISTINCT m.* FROM movie m " +
                     "JOIN movie_genre_table mg ON m.movieID = mg.movieID " +
                     "JOIN genre g ON mg.genreID = g.genreID " +
                     "WHERE (? IS NULL OR YEAR(m.release_date) LIKE ?) " +
                     "AND (? IS NULL OR g.genre = ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String yearLike = (yearPrefix != null && !yearPrefix.isEmpty()) ? yearPrefix + "%" : null;
            String genreVal = (genre != null && !genre.isEmpty()) ? genre : null;

            stmt.setString(1, yearLike);
            stmt.setString(2, yearLike);
            stmt.setString(3, genreVal);
            stmt.setString(4, genreVal);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Movies movie = new Movies(
                    rs.getInt("movieID"),
                    rs.getString("title"),
                    rs.getDate("release_date"),
                    rs.getString("duration"),
                    rs.getString("country"),
                    rs.getString("director"),
                    rs.getString("description"),
                    rs.getString("cast"),
                    rs.getString("image_path")
                );
                movie.setGenre(getGenresByMovieId(movie.getMovieID()));
                movie.setCast(getCastFromMovieTable(movie.getMovieID()));
                moviesList.add(movie);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return moviesList;
    }

    // Get upcoming movies after a given year
    public List<Movies> getUpcomingMoviesAfterYear(int year) throws SQLException {
        List<Movies> movies = new ArrayList<>();
        String query = "SELECT * FROM movie WHERE YEAR(release_date) > ? ORDER BY release_date ASC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, year);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Movies movie = new Movies();
                    movie.setMovieID(resultSet.getInt("movieID"));
                    movie.setTitle(resultSet.getString("title"));
                    movie.setDescription(resultSet.getString("description"));
                    movie.setDuration(resultSet.getString("duration"));
                    movie.setReleaseDate(resultSet.getDate("release_date"));
                    movie.setCountry(resultSet.getString("country"));
                    movie.setDirector(resultSet.getString("director"));
                    movie.setImagePath(resultSet.getString("image_path"));
                    movie.setGenre(getGenresByMovieId(movie.getMovieID()));
                    movie.setCast(getCastFromMovieTable(movie.getMovieID()));
                    movies.add(movie);
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return movies;
    }
}
