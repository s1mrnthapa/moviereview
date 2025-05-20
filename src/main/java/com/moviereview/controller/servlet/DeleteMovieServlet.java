package com.moviereview.controller.servlet;

import com.moviereview.controller.dao.MovieDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteMovieServlet")
public class DeleteMovieServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String movieIDParam = request.getParameter("movieID");

        try {
            int movieID = Integer.parseInt(movieIDParam);
            MovieDAO dao = new MovieDAO();
            boolean isDeleted = dao.deleteMovie(movieID);

            if (isDeleted) {
                response.sendRedirect("AdminMoviesServlet?success=deleted");
            } else {
                response.sendRedirect("AdminMoviesServlet?error=notdeleted");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminMoviesServlet?error=exception");
        }
    }
}
