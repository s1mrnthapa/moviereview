package com.moviereview.controller.servlet;

import com.moviereview.controller.dao.*;
import com.moviereview.model.Admin;
import java.io.IOException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin-profile")
public class AdminProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer adminId = (Integer) session.getAttribute("adminId");
        
        if (adminId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        AdminDAO adminDAO = new AdminDAO();
        Admin admin = adminDAO.getAdminById(adminId);
        
        if (admin != null) {
            // Format dates for display
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            
            session.setAttribute("name", admin.getName());
            session.setAttribute("email", admin.getEmail());
            session.setAttribute("username", admin.getUsername());
            session.setAttribute("role", admin.getRole());
            session.setAttribute("joined", dateFormat.format(admin.getJoinedDate()));
            session.setAttribute("lastLogin", dateFormat.format(admin.getLastLogin()));
            
            try {
                session.setAttribute("moviesCount", adminDAO.getMoviesAddedCount(adminId));
                session.setAttribute("reviewsCount", adminDAO.getReviewsModeratedCount(adminId));
                session.setAttribute("usersCount", adminDAO.getUsersManagedCount(adminId));
            } catch (Exception e) {
                e.printStackTrace();
                // Set default values if there's an error
                session.setAttribute("moviesCount", 0);
                session.setAttribute("reviewsCount", 0);
                session.setAttribute("usersCount", 0);
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/pages/adminprofile.jsp");
    }
}