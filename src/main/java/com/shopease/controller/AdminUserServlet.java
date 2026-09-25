package com.shopease.controller;

import java.io.IOException;
import java.util.List;

import com.shopease.dao.UserDAO;
import com.shopease.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

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

        List<User> users =
                userDAO.getAllUsers();

        request.setAttribute(
                "users",
                users
        );

        request.getRequestDispatcher(
                "/admin-users.jsp"
        ).forward(
                request,
                response
        );
    }
}