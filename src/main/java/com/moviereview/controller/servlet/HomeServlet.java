package com.moviereview.controller.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.moviereview.controller.dao.MovieDAO;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int totalMovies = 0;

        try {
            // Create an instance of MovieDAO to get the total number of movies
            MovieDAO movieDAO = new MovieDAO();
            totalMovies = movieDAO.getTotalMovies();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Set the totalMoviesAlt attribute to be accessible in home.jsp
        request.setAttribute("totalMoviesAlt", totalMovies);
        System.out.print("Total movies =" + totalMovies);

        // Forward the request to home.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("pages/Home.jsp");
        dispatcher.forward(request, response);
    }
}
