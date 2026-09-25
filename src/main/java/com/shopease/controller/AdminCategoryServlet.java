package com.shopease.controller;

import java.io.IOException;
import java.util.List;

import com.shopease.dao.CategoryDAO;
import com.shopease.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/categories")
public class AdminCategoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categories =
                categoryDAO.getAllCategories();

        request.setAttribute(
                "categories",
                categories
        );

        request.getRequestDispatcher(
                "/admin-categories.jsp"
        ).forward(
                request,
                response
        );
    }
}