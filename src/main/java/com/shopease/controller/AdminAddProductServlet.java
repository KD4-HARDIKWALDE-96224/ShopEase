package com.shopease.controller;

import java.io.IOException;

import com.shopease.dao.ProductDAO;
import com.shopease.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/products/add")
public class AdminAddProductServlet extends HttpServlet {

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

        request.getRequestDispatcher(
                "/admin-add-product.jsp"
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

        try {

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

            product.setProductName(productName);
            product.setDescription(description);
            product.setPrice(price);
            product.setDiscount(discount);
            product.setStockQuantity(stockQuantity);
            product.setImageUrl(imageUrl);
            product.setCategoryId(categoryId);

            boolean success =
                    productDAO.addProduct(product);

            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/products"
                );

            } else {

                request.setAttribute(
                        "error",
                        "Unable to add product."
                );

                request.getRequestDispatcher(
                        "/admin-add-product.jsp"
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
                    "/admin-add-product.jsp"
            ).forward(
                    request,
                    response
            );
        }
    }
}