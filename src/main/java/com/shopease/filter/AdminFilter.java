package com.shopease.filter;

import java.io.IOException;

import com.shopease.model.User;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest =
                (HttpServletRequest) request;

        HttpServletResponse httpResponse =
                (HttpServletResponse) response;

        HttpSession session =
                httpRequest.getSession(false);

        User loggedInUser = null;

        if (session != null) {

            loggedInUser =
                    (User) session.getAttribute(
                            "loggedInUser"
                    );
        }

        // User is not logged in
        if (loggedInUser == null) {

            httpResponse.sendRedirect(
                    httpRequest.getContextPath()
                    + "/login.jsp"
            );

            return;
        }

        // User is logged in but is not an ADMIN
        if (!"ADMIN".equalsIgnoreCase(
                loggedInUser.getRole())) {

            httpResponse.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Access Denied"
            );

            return;
        }

        // User is ADMIN
        chain.doFilter(
                request,
                response
        );
    }
}