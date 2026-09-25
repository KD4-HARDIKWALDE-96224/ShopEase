package com.shopease.controller;

import java.io.IOException;

import com.shopease.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/users/update-role")
public class AdminUpdateUserRoleServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int userId =
                    Integer.parseInt(
                            request.getParameter("userId")
                    );

            String role =
                    request.getParameter("role");

            if (role == null
                    || (!"CUSTOMER".equalsIgnoreCase(role)
                    && !"ADMIN".equalsIgnoreCase(role))) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid user role"
                );

                return;
            }

            userDAO.updateUserRole(
                    userId,
                    role.toUpperCase()
            );

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/users"
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid user ID"
            );
        }
    }
}