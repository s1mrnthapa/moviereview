package com.moviereview.controller.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*") // Filter ALL requests
public class AuthenticationFilter implements Filter {
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// Initialization code if required (for example: reading init parameters)
		System.out.println("AuthenticationFilter initialized");
	}
	@Override
	public void destroy() {
		// Cleanup code if required
		System.out.println("AuthenticationFilter destroyed");
	}
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		String uri = req.getRequestURI();
		
		// Check if logged in
		HttpSession session = req.getSession(false);
		boolean loggedIn = session != null && (session.getAttribute("user") != null || session.getAttribute("Admin") != null);
		boolean isAdminPage = uri.contains("adminprofile");

		if (!loggedIn && (uri.endsWith("Register.jsp") || uri.endsWith("RegisterController") || uri.endsWith("Login.jsp") || uri.endsWith("LogInController") || uri.endsWith("background.mp4") || uri.endsWith("logo.png")|| uri.endsWith("photo2.jpg"))) {
			chain.doFilter(request, response);
			return;
		}
		// Skipping filter for login page and login controller
		if (loggedIn) {
			// 🚫 If a normal user tries to access an admin-only page
            if (isAdminPage && session.getAttribute("Admin") == null) {
                res.sendRedirect(req.getContextPath() + "/pages/Unauthorized.jsp");
                return;
            }
	        chain.doFilter(request, response); // proceed to requested resource
	    } else {
	        // 🚨 Only try to setAttribute if session is not null, else create one
	        if (session == null) {
	            session = req.getSession(); // now we create it
	        }
	        session.setAttribute("error", "Please login first");
	        res.sendRedirect(req.getContextPath() + "/pages/Login.jsp");
	    }
		
	}
}
