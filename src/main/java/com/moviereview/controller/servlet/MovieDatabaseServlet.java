package com.moviereview.controller.servlet;

import com.moviereview.controller.dao.MovieDAO;
import com.moviereview.model.Movies;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/MovieDatabase")
public class MovieDatabaseServlet extends HttpServlet {
    private MovieDAO movieDAO;

    @Override
    public void init() throws ServletException {
        try {
            movieDAO = new MovieDAO();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize MovieDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<Movies> movies = movieDAO.getAllMovies();
            req.setAttribute("movies", movies); // Consistent with JSP: ${movies}
            req.getRequestDispatcher("/pages/MovieDatabase.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException("Error retrieving movies", e);
        }
    }
}
