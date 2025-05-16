package com.moviereview.controller.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.moviereview.controller.dao.UserDAO;
import com.moviereview.controller.database.DatabaseConnection;
import com.moviereview.model.User;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
    	HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // 1. First try to get user from session
        if (user == null) {
            // 2. If not in session, try to load from database using userId parameter
            String userId = request.getParameter("userId");
            if (userId != null) {
                try (Connection conn = DatabaseConnection.getConnection()) {
                    UserDAO userDAO = new UserDAO(conn);
                    user = userDAO.getUserById(Integer.parseInt(userId));
                    
                    if (user != null) {
                        // Store in session for future requests
                        session.setAttribute("user", user);
                        session.setAttribute("userProfile", user);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/pages/Login.jsp?error=db_error");
                    return;
                }
            }
        }

        // 3. Final check - if still no user, redirect to login
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
            return;
        }

        // 4. Handle error messages
        if (request.getParameter("error") != null) {
            request.setAttribute("error", request.getParameter("error"));
        }

        // 5. Forward to profile page with user data
        request.setAttribute("userProfile", user);
        request.getRequestDispatcher("/pages/UserProfile.jsp").forward(request, response);
    }
}
