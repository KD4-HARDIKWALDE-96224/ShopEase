package com.shopease.controller;

import java.io.IOException;

import com.shopease.dao.ProductDAO;
import com.shopease.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/products/edit")
public class AdminEditProductServlet extends HttpServlet {

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
                    Integer.parseInt(productIdParameter);

            Product product =
                    productDAO.getProductById(productId);

            if (product == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product not found"
                );

                return;
            }

            request.setAttribute(
                    "product",
                    product
            );

            request.getRequestDispatcher(
                    "/admin-edit-product.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID"
            );
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int productId =
                    Integer.parseInt(
                            request.getParameter("productId")
                    );

            String productName =
                    request.getParameter("productName");

            String description =
                    request.getParameter("description");

            double price =
                    Double.parseDouble(
                            request.getParameter("price")
                    );

            double discount =
                    Double.parseDouble(
                            request.getParameter("discount")
                    );

            int stockQuantity =
                    Integer.parseInt(
                            request.getParameter("stockQuantity")
                    );

            int categoryId =
                    Integer.parseInt(
                            request.getParameter("categoryId")
                    );

            String imageUrl =
                    request.getParameter("imageUrl");

            Product product = new Product();

            product.setProductId(productId);
            product.setProductName(productName);
            product.setDescription(description);
            product.setPrice(price);
            product.setDiscount(discount);
            product.setStockQuantity(stockQuantity);
            product.setImageUrl(imageUrl);
            product.setCategoryId(categoryId);

            boolean success =
                    productDAO.updateProduct(product);

            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/products"
                );

            } else {

                request.setAttribute(
                        "error",
                        "Unable to update product."
                );

                request.setAttribute(
                        "product",
                        product
                );

                request.getRequestDispatcher(
                        "/admin-edit-product.jsp"
                ).forward(
                        request,
                        response
                );
            }

        } catch (NumberFormatException e) {

            request.setAttribute(
                    "error",
                    "Please enter valid numeric values."
            );

            request.getRequestDispatcher(
                    "/admin-edit-product.jsp"
            ).forward(
                    request,
                    response
            );
        }
    }
}