package com.moviereview.controller.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
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
    
    // Set your upload directory
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
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String releaseDateStr = request.getParameter("release_date");
        String duration = request.getParameter("duration");
        String country = request.getParameter("country");
        String director = request.getParameter("director");
        String description = request.getParameter("description");

        List<String> errors = new ArrayList<>();

        // Basic validations
        if (title == null || title.trim().isEmpty()) errors.add("Title is required.");
        if (releaseDateStr == null || releaseDateStr.trim().isEmpty()) errors.add("Release date is required.");
        if (duration == null || duration.trim().isEmpty()) errors.add("Duration is required.");
        if (country == null || country.trim().isEmpty()) {
            errors.add("Country is required.");
        } else if (!country.matches("[a-zA-Z\\s]+")) {
            errors.add("Country should contain only alphabets.");
        }

        if (director == null || director.trim().isEmpty()) {
            errors.add("Director is required.");
        } else if (!director.matches("[a-zA-Z\\s]+")) {
            errors.add("Director name should not contain numbers or special characters.");
        }

        if (description == null || description.trim().isEmpty()) errors.add("Description is required.");

        // Validate release date format
        java.sql.Date releaseDate = null;
        try {
            if (releaseDateStr != null && !releaseDateStr.isEmpty()) {
                releaseDate = java.sql.Date.valueOf(releaseDateStr);
            }
        } catch (IllegalArgumentException e) {
            errors.add("Invalid release date format. Use yyyy-MM-dd.");
        }

        // Validate genre (must not be empty)
        String[] selectedGenres = request.getParameterValues("genre");
        List<String> genre = new ArrayList<>();
        if (selectedGenres == null || selectedGenres.length == 0) {
            errors.add("At least one genre must be selected.");
        } else {
            for (String genreID : selectedGenres) {
                genre.add(genreID);
            }
        }

        // Validate cast: comma-separated
        String castInput = request.getParameter("cast");
        List<String> cast = new ArrayList<>();
        if (castInput == null || castInput.trim().isEmpty()) {
            errors.add("Cast field is required.");
        } else {
            String[] castArray = castInput.split("\\s*,\\s*");
            for (String castName : castArray) {
                if (!castName.matches("[a-zA-Z\\s]+")) {
                    errors.add("Each cast name should be comma seperated & only contain letters and spaces.");
                    break;
                }
                cast.add(castName);
            }
        }

        // Handle file upload
        Part filePart = request.getPart("image");
        String fileName = extractFileName(filePart);

        if (fileName == null || fileName.isEmpty()) {
            errors.add("Poster image is required.");
        } else {
            String fileExt = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
            if (!fileExt.matches("jpg|jpeg|png|webp")) {
                errors.add("Only JPG, JPEG, PNG, and WEBP image formats are allowed.");
            }
        }

        // If errors exist, return to form
        if (!errors.isEmpty()) {
            request.setAttribute("errorMessages", errors);
            request.getRequestDispatcher("/pages/addMovie.jsp").forward(request, response);
            return;
        }

        // Save file
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // Create movie
        Movies movies = new Movies();
        movies.setTitle(title);
        movies.setReleaseDate(releaseDate);
        movies.setDuration(duration);
        movies.setCountry(country);
        movies.setDirector(director);
        movies.setDescription(description);
        movies.setGenre(genre);
        movies.setCast(cast);
        movies.setImagePath(UPLOAD_DIR + "/" + fileName);

        boolean isMovieAdded = movieDAO.addMovie(movies);

        if (isMovieAdded) {
            request.setAttribute("successMessage", "Movie added successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to add movie.");
        }

        request.getRequestDispatcher("/pages/addMovie.jsp").forward(request, response);
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Movies> movieList = movieDAO.getAllMovies();
            request.setAttribute("movieList", movieList);
            request.getRequestDispatcher("/pages/Movies.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error occurred while fetching movies.");
            request.getRequestDispatcher("/pages/Movies.jsp").forward(request, response);
        }
    }

    // Utility method to get file name from file part
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String content : contentDisp.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length()-1);
            }
        }
        return "";
    }
}
