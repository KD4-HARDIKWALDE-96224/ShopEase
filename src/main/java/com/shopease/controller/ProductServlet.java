package com.shopease.controller;

import java.io.IOException;
import java.util.List;

import com.shopease.dao.ProductDAO;
import com.shopease.model.CartItem;
import com.shopease.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

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

        String keyword =
                request.getParameter("keyword");

        String categoryIdParameter =
                request.getParameter("categoryId");

        String sort =
                request.getParameter("sort");

        Integer categoryId = null;

        // Convert category ID
        if (categoryIdParameter != null
                && !categoryIdParameter.trim().isEmpty()) {

            try {

                categoryId =
                        Integer.parseInt(
                                categoryIdParameter
                        );

            } catch (NumberFormatException e) {

                categoryId = null;
            }
        }

        // Get products using search + category + sorting
        List<Product> products =
                productDAO.searchProducts(
                        keyword,
                        categoryId,
                        sort
                );

        // Search keyword
        if (keyword != null
                && !keyword.trim().isEmpty()) {

            request.setAttribute(
                    "searchKeyword",
                    keyword.trim()
            );
        }

        // Selected category
        if (categoryId != null) {

            request.setAttribute(
                    "selectedCategoryId",
                    categoryId
            );
        }

        // Selected sorting option
        if (sort != null
                && !sort.trim().isEmpty()) {

            request.setAttribute(
                    "selectedSort",
                    sort
            );
        }

        // Products
        request.setAttribute(
                "products",
                products
        );

        // Cart count
        HttpSession session =
                request.getSession();

        List<CartItem> cart =
                (List<CartItem>)
                session.getAttribute("cart");

        int cartItemCount = 0;

        if (cart != null) {

            for (CartItem item : cart) {

                cartItemCount +=
                        item.getQuantity();
            }
        }

        request.setAttribute(
                "cartItemCount",
                cartItemCount
        );

        // Forward to products page
        request.getRequestDispatcher(
                "/products.jsp"
        ).forward(
                request,
                response
        );
    }
}