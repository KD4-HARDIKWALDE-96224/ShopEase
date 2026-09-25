package com.shopease.controller;

import java.io.IOException;

import com.shopease.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/users/delete")
public class AdminDeleteUserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String userIdParameter =
                request.getParameter("userId");

        if (userIdParameter == null
                || userIdParameter.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "User ID is required"
            );

            return;
        }

        try {

            int userId =
                    Integer.parseInt(userIdParameter);

            boolean success =
                    userDAO.deleteUser(userId);

            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/users"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/users"
                );
            }

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid user ID"
            );
        }
    }
}