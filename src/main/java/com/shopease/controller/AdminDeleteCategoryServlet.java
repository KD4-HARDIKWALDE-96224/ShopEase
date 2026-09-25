package com.shopease.controller;

import java.io.IOException;

import com.shopease.dao.CategoryDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/categories/delete")
public class AdminDeleteCategoryServlet extends HttpServlet {

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

            boolean success =
                    categoryDAO.deleteCategory(
                            categoryId
                    );

            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/categories"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/categories"
                );
            }

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid category ID"
            );
        }
    }
}