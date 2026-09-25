package com.shopease.controller;

import java.io.IOException;

import com.shopease.dao.CategoryDAO;
import com.shopease.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/categories/edit")
public class AdminEditCategoryServlet extends HttpServlet {

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

        String categoryIdParameter =
                request.getParameter("categoryId");

        if (categoryIdParameter == null
                || categoryIdParameter.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Category ID is required"
            );

            return;
        }

        try {

            int categoryId =
                    Integer.parseInt(
                            categoryIdParameter
                    );

            Category category =
                    categoryDAO.getCategoryById(
                            categoryId
                    );

            if (category == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Category not found"
                );

                return;
            }

            request.setAttribute(
                    "category",
                    category
            );

            request.getRequestDispatcher(
                    "/admin-edit-category.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid category ID"
            );
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int categoryId =
                    Integer.parseInt(
                            request.getParameter("categoryId")
                    );

            String categoryName =
                    request.getParameter("categoryName");

            String description =
                    request.getParameter("description");

            Category category =
                    new Category();

            category.setCategoryId(categoryId);
            category.setCategoryName(categoryName);
            category.setDescription(description);

            boolean success =
                    categoryDAO.updateCategory(
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
                        "Unable to update category."
                );

                request.setAttribute(
                        "category",
                        category
                );

                request.getRequestDispatcher(
                        "/admin-edit-category.jsp"
                ).forward(
                        request,
                        response
                );
            }

        } catch (NumberFormatException e) {

            request.setAttribute(
                    "error",
                    "Invalid category ID."
            );

            request.getRequestDispatcher(
                    "/admin-categories.jsp"
            ).forward(
                    request,
                    response
            );
        }
    }
}