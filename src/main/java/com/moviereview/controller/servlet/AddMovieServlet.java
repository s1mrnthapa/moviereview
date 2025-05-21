package com.moviereview.controller.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.moviereview.controller.dao.MovieDAO;
import com.moviereview.model.Movies;

@WebServlet("/AddMovieServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,   // 2MB threshold before writing to disk
    maxFileSize = 1024 * 1024 * 10,        // 10MB max file size for the poster
    maxRequestSize = 1024 * 1024 * 50      // 50MB max request size for all files in a form
)
public class AddMovieServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MovieDAO movieDAO;

    private static final String UPLOAD_DIR = "uploads";

    public AddMovieServlet() {
        super();
    }

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            movieDAO = new MovieDAO();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException("Failed to initialize MovieDAO", e);
        } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Validate title (required)
        String title = request.getParameter("title");
        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Movie title is required.");
            request.getRequestDispatcher("/pages/addMovie.jsp").forward(request, response);
            return;
        }

        // Parse and validate other fields
        String releaseDateStr = request.getParameter("release_date");
        java.sql.Date releaseDate = null;
        if (releaseDateStr != null && !releaseDateStr.isEmpty()) {
            try {
                releaseDate = java.sql.Date.valueOf(releaseDateStr);
            } catch (IllegalArgumentException e) {
                request.setAttribute("errorMessage", "Invalid release date format.");
                request.getRequestDispatcher("/pages/addMovie.jsp").forward(request, response);
                return;
            }
        }

        String duration = request.getParameter("duration");
        String country = request.getParameter("country");
        String director = request.getParameter("director");
        String description = request.getParameter("description");

        // Genres from checkboxes
        String[] selectedGenres = request.getParameterValues("genre");
        List<String> genre = (selectedGenres != null) ? Arrays.asList(selectedGenres) : new ArrayList<>();

        // Cast list (comma-separated)
        String castInput = request.getParameter("cast");
        List<String> cast = new ArrayList<>();
        if (castInput != null && !castInput.trim().isEmpty()) {
            String[] castArray = castInput.split("\\s*,\\s*");
            for (String castName : castArray) {
                if (!castName.isEmpty()) {
                    cast.add(castName);
                }
            }
        }

        // Handle file upload
        Part filePart = request.getPart("image");
        String fileName = extractFileName(filePart);

        // Prepare upload directory
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        Movies movies = new Movies();
        movies.setTitle(title.trim());
        movies.setReleaseDate(releaseDate);
        movies.setDuration(duration != null ? duration.trim() : "");
        movies.setCountry(country != null ? country.trim() : "");
        movies.setDirector(director != null ? director.trim() : "");
        movies.setDescription(description != null ? description.trim() : "");
        movies.setGenre(genre);
        movies.setCast(cast);

        if (fileName != null && !fileName.isEmpty()) {
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
            movies.setImagePath(UPLOAD_DIR + "/" + fileName);
        } else {
            movies.setImagePath(""); // or set default image path here
        }

        boolean isMovieAdded = false;
        try {
            isMovieAdded = movieDAO.addMovie(movies);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error while adding movie.");
            request.getRequestDispatcher("/pages/addMovie.jsp").forward(request, response);
            return;
        }

        if (isMovieAdded) {
            request.setAttribute("successMessage", "Movie added successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to add movie.");
        }
        request.getRequestDispatcher("/pages/addMovie.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Movies> movieList = movieDAO.getAllMovies();
		request.setAttribute("movieList", movieList);
		request.getRequestDispatcher("/pages/Movies.jsp").forward(request, response);
    }

    // Utility method to extract filename safely from the Part
    private String extractFileName(Part part) {
        if (part == null) return "";
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) return "";
        for (String content : contentDisp.split(";")) {
            if (content.trim().startsWith("filename")) {
                String fileName = content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.isEmpty() ? "" : fileName;
            }
        }
        return "";
    }
}