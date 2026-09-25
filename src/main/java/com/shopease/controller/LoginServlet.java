package com.shopease.controller;

import java.io.IOException;

import com.shopease.model.User;
import com.shopease.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        User user =
                userService.loginUser(
                        email,
                        password
                );

        if (user != null) {

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "loggedInUser",
                    user
            );

            if ("ADMIN".equalsIgnoreCase(
                    user.getRole())) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/dashboard"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/products"
                );
            }

        } else {

            request.setAttribute(
                    "error",
                    "Invalid email or password."
            );

            request.getRequestDispatcher(
                    "/login.jsp"
            ).forward(
                    request,
                    response
            );
        }
    }
}