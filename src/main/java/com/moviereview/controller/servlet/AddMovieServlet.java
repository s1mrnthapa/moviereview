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
        
        // Handle form fields
        String title = request.getParameter("title");
        String releaseDateStr = request.getParameter("release_date");
        java.sql.Date releaseDate = null;
        if (releaseDateStr != null && !releaseDateStr.isEmpty()) {
            releaseDate = java.sql.Date.valueOf(releaseDateStr);
        }
        String duration = request.getParameter("duration");
        String country = request.getParameter("country");
        String director = request.getParameter("director");
        String description = request.getParameter("description");

        // Handle genre checkboxes
        String[] selectedGenres = request.getParameterValues("genre");
        List<String> genre = new ArrayList<>();
        if (selectedGenres != null) {
            for (String genreID : selectedGenres) {
                genre.add(genreID);
            }
        }

        // Handle cast input
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

        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); // Create uploads folder if it doesn't exist
        }

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // Now create Movies object
        Movies movies = new Movies();
        movies.setTitle(title);
        movies.setReleaseDate(releaseDate);
        movies.setDuration(duration);
        movies.setCountry(country);
        movies.setDirector(director);
        movies.setDescription(description);
        movies.setGenre(genre);
        movies.setCast(cast);
        movies.setImagePath(UPLOAD_DIR + "/" + fileName); // Save relative path

        boolean isMovieAdded = false;
        isMovieAdded = movieDAO.addMovie(movies);

        if (isMovieAdded) {
            request.setAttribute("successMessage", "Movie added successfully!");
            request.getRequestDispatcher("/pages/addMovie.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Failed to add movie.");
            request.getRequestDispatcher("/pages/addMovie.jsp").forward(request, response);
        }
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
