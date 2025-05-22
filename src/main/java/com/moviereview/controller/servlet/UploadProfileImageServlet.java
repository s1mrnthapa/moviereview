package com.moviereview.controller.servlet;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UploadProfileImageServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 15    // 15MB
)
public class UploadProfileImageServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "/uploads";
    private static final String USER_IMAGES_DIR = "user_images";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/pages/Login.jsp?error=session_expired");
            return;
        }

        // Get user from session
        com.moviereview.model.User user = (com.moviereview.model.User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/pages/Login.jsp?error=usernotfound");
            return;
        }

        Part filePart = request.getPart("profileImage");

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = getSubmittedFileName(filePart);

            // Create unique file name
            String uniqueFileName = System.currentTimeMillis() + "_" + fileName;

            // Save to /uploads directory under webapp
            String uploadPath = getServletContext().getRealPath(UPLOAD_DIR);
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String filePath = uploadPath + File.separator + uniqueFileName;
            filePart.write(filePath);

            // Store relative path in session
            String relativePath = request.getContextPath() + UPLOAD_DIR + "/" + uniqueFileName;
            session.setAttribute("profileImage", relativePath);

            // Persist this path for this user (store in a user-specific file)
            saveUserProfileImagePath(user.getUsername(), uniqueFileName, getServletContext());
        }

        response.sendRedirect(request.getContextPath() + "/AdminProfileServlet");
    }

    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return new File(filename).getName();
            }
        }
        return null;
    }

    private void saveUserProfileImagePath(String username, String filename, javax.servlet.ServletContext context) {
        try {
            String userImageDirPath = context.getRealPath("/") + USER_IMAGES_DIR;
            File userImageDir = new File(userImageDirPath);
            if (!userImageDir.exists()) userImageDir.mkdirs();

            File userFile = new File(userImageDir, username + ".txt");
            try (PrintWriter pw = new PrintWriter(userFile)) {
                pw.println(filename);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}