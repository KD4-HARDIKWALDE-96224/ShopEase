package com.shopease.controller;

import java.io.IOException;

import com.shopease.dao.ProductDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/products/delete")
public class AdminDeleteProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String productIdParameter =
                request.getParameter("productId");

        if (productIdParameter == null
                || productIdParameter.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Product ID is required"
            );

            return;
        }

        try {

            int productId =
                    Integer.parseInt(
                            productIdParameter
                    );

            boolean success =
                    productDAO.deleteProduct(
                            productId
                    );

            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/products"
                );

            } else {

                request.setAttribute(
                        "error",
                        "Unable to delete product."
                );

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/products"
                );
            }

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID"
            );
        }
    }
}