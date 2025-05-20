package com.moviereview.controller.servlet;

import com.moviereview.controller.dao.MovieDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.Movies;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.util.List;

@MultipartConfig
@WebServlet("/EditMovieServlet")
public class EditMovieServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int movieID = Integer.parseInt(request.getParameter("movieID"));
            MovieDAO dao = new MovieDAO();

            Movies movie = dao.getMovieByID(movieID);
            if (movie != null) {
                List<String> castList = dao.getCastFromMovieTable(movieID);
                String castString = String.join(", ", castList);
                request.setAttribute("castString", castString);

                List<String> genreList = dao.getGenresByMovieId(movieID);
                movie.setGenre(genreList);
                request.setAttribute("selectedGenres", genreList);

                List<String> allGenres = dao.getAllGenres();
                request.setAttribute("allGenres", allGenres);

                request.setAttribute("movie", movie);
                request.getRequestDispatcher("/pages/EditMovie.jsp").forward(request, response);
            } else {
                response.sendRedirect("AdminMoviesServlet?error=movienotfound");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminMoviesServlet?error=exception");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            MovieDAO dao = new MovieDAO();
            String movieIDStr = request.getParameter("movieID");
            if (movieIDStr == null || movieIDStr.trim().isEmpty()) {
                request.setAttribute("error", "missingMovieID");
                RequestDispatcher rd = request.getRequestDispatcher("/pages/EditMovie.jsp");
                rd.forward(request, response);
                return;
            }

            int movieID = Integer.parseInt(movieIDStr);
            String title = request.getParameter("title");
            String duration = request.getParameter("duration");
            String releaseDate = request.getParameter("releaseDate");
            String country = request.getParameter("country");
            String director = request.getParameter("director");
            String description = request.getParameter("description");
            String cast = request.getParameter("cast");

            String[] genres = request.getParameterValues("genres");

            Part imagePart = request.getPart("imageFile");
            String imagePath = null;
            boolean hasImage = imagePart != null && imagePart.getSize() > 0;

            if (hasImage) {
                String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                String filePath = uploadPath + File.separator + fileName;
                imagePart.write(filePath);

                imagePath = "uploads/" + fileName;
            }

            try (Connection conn = DatabaseConnection.getConnection()) {
                StringBuilder sql = new StringBuilder("UPDATE movie SET title=?, duration=?, release_date=?, country=?, director=?, description=?, cast=?");
                if (hasImage) {
                    sql.append(", image_path=?");
                }
                sql.append(" WHERE movieID=?");

                try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
                    ps.setString(1, title);
                    ps.setString(2, duration);
                    ps.setDate(3, Date.valueOf(releaseDate));
                    ps.setString(4, country);
                    ps.setString(5, director);
                    ps.setString(6, description);
                    ps.setString(7, cast);

                    int paramIndex = 8;
                    if (hasImage) {
                        ps.setString(paramIndex++, imagePath);
                    }

                    ps.setInt(paramIndex, movieID);
                    ps.executeUpdate();
                }

                // Update genre table (delete old and insert new)
                try (PreparedStatement deleteStmt = conn.prepareStatement("DELETE FROM movie_genre_table WHERE movieID=?")) {
                    deleteStmt.setInt(1, movieID);
                    deleteStmt.executeUpdate();
                }

                if (genres != null) {
                    try (PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO movie_genre_table (movieID, genreID) VALUES (?, ?)")) {
                        for (String genreName : genres) {
                        	int genreID = dao.getGenreIDByName(genreName);
                            insertStmt.setInt(1, movieID);
                            insertStmt.setInt(2, genreID);
                            insertStmt.addBatch();
                        }
                        insertStmt.executeBatch();
                    }
                }
            }

            response.sendRedirect("AdminMoviesServlet?success=updated");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("pages/EditMovie.jsp?error=exception");
        }
    }
}
