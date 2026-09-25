package com.shopease.controller;

import java.io.IOException;
import java.util.List;

import com.shopease.dao.ProductDAO;
import com.shopease.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {

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

        List<Product> products =
                productDAO.getAllProducts();

        request.setAttribute(
                "products",
                products
        );

        request.getRequestDispatcher(
                "/admin-products.jsp"
        ).forward(
                request,
                response
        );
    }
}