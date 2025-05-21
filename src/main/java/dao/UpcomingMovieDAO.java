package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.moviereview.controller.dao.UpcomingMovie;

public class UpcomingMovieDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/cinecritique";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private static final String SELECT_ALL_MOVIES = "SELECT * FROM upcoming_movies ORDER BY release_date";

    protected Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<UpcomingMovie> getAllUpcomingMovies() {
        List<UpcomingMovie> movies = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_MOVIES)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UpcomingMovie movie = new UpcomingMovie(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getString("release_date"),
                    rs.getString("poster_url")
                );
                movies.add(movie);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movies;
    }
}
