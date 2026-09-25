package com.shopease.controller;

import java.io.IOException;

import com.shopease.dao.CategoryDAO;
import com.shopease.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/categories/add")
public class AdminAddCategoryServlet extends HttpServlet {

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

        request.getRequestDispatcher(
                "/admin-add-category.jsp"
        ).forward(
                request,
                response
        );
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String categoryName =
                request.getParameter("categoryName");

        String description =
                request.getParameter("description");

        Category category =
                new Category();

        category.setCategoryName(
                categoryName
        );

        category.setDescription(
                description
        );

        boolean success =
                categoryDAO.addCategory(
                        category
                );

        if (success) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/categories"
            );

        } else {

            request.setAttribute(
                    "error",
                    "Unable to add category."
            );

            request.getRequestDispatcher(
                    "/admin-add-category.jsp"
            ).forward(
                    request,
                    response
            );
        }
    }
}