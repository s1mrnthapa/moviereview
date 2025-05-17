package controller;

import dao.UpcomingMovieDAO;
import model.UpcomingMovie;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class UpcomingMovieServlet extends HttpServlet {
    private UpcomingMovieDAO movieDAO;

    @Override
    public void init() {
        movieDAO = new UpcomingMovieDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        List<UpcomingMovie> movies = movieDAO.getAllUpcomingMovies();
        request.setAttribute("movies", movies);
        RequestDispatcher dispatcher = request.getRequestDispatcher("upcoming_movies.jsp");
        dispatcher.forward(request, response);
    }
}
