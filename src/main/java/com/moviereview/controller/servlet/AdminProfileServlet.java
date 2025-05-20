package com.moviereview.controller.servlet;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.moviereview.model.User;

/**
 * Servlet implementation class AdminProfileServlet
 */
@WebServlet("/AdminProfileServlet")
public class AdminProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(AdminProfileServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


            HttpSession session = request.getSession(false);

            User user = (User) session.getAttribute("user");


            if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/pages/Login.jsp?error=session_expired");
                return;
            }

//            UserDAO userDAO = new UserDAO(conn);
//            User user = userDAO.getUserByUsername(username);

            if (user != null) {
                String role = user.getRole();

                if ("Admin".equalsIgnoreCase(role)) {
                    request.setAttribute("adminProfile", user);
                    request.getRequestDispatcher("/pages/adminprofile.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/pages/Login.jsp?error=unauthorized");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/Login.jsp?error=usernotfound");
            }


    }
}
