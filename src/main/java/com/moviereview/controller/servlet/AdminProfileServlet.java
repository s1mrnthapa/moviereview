package com.moviereview.controller.servlet;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.moviereview.model.User;

@WebServlet("/AdminProfileServlet")
public class AdminProfileServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "/uploads";
    private static final String USER_IMAGES_DIR = "user_images";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/pages/Login.jsp?error=session_expired");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null || user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pages/Login.jsp?error=usernotfound");
            return;
        }

        // Load saved profile image path for this user if not in session
        if (session.getAttribute("profileImage") == null) {
            String savedImage = loadUserProfileImagePath(user.getUsername(), getServletContext());
            if (savedImage != null) {
                String relativePath = request.getContextPath() + UPLOAD_DIR + "/" + savedImage;
                session.setAttribute("profileImage", relativePath);
            }
        }

        // Pass user data to JSP
        request.setAttribute("adminProfile", user);

        // Forward to JSP
        request.getRequestDispatcher("/pages/adminprofile.jsp").forward(request, response);
    }

    private String loadUserProfileImagePath(String username, javax.servlet.ServletContext context) {
        try {
            String userImageDirPath = context.getRealPath("/") + USER_IMAGES_DIR;
            File userFile = new File(userImageDirPath, username + ".txt");
            if (!userFile.exists()) return null;

            try (BufferedReader br = new BufferedReader(new FileReader(userFile))) {
                String filename = br.readLine();
                return filename;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
