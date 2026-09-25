package com.shopease.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.shopease.dao.ProductDAO;
import com.shopease.model.CartItem;
import com.shopease.model.Product;
import com.shopease.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
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

            Product product =
                    productDAO.getProductById(productId);

            if (product == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product not found"
                );

                return;
            }

            HttpSession session =
                    request.getSession(false);

            User loggedInUser = null;

            if (session != null) {

                loggedInUser =
                        (User) session.getAttribute(
                                "loggedInUser"
                        );
            }

            // User must be logged in
            if (loggedInUser == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/login.jsp"
                );

                return;
            }

            // Check stock availability
            if (product.getStockQuantity() <= 0) {

                session.setAttribute(
                        "cartError",
                        "Sorry, "
                        + product.getProductName()
                        + " is currently out of stock."
                );

                response.sendRedirect(
                        request.getContextPath()
                        + "/products"
                );

                return;
            }

            List<CartItem> cart =
                    (List<CartItem>)
                    session.getAttribute("cart");

            if (cart == null) {

                cart = new ArrayList<>();

                session.setAttribute(
                        "cart",
                        cart
                );
            }

            boolean productExists = false;

            for (CartItem cartItem : cart) {

                if (cartItem.getProduct()
                        .getProductId() == productId) {

                    int currentQuantity =
                            cartItem.getQuantity();

                    // Do not allow quantity above stock
                    if (currentQuantity
                            < product.getStockQuantity()) {

                        cartItem.setQuantity(
                                currentQuantity + 1
                        );

                        session.removeAttribute(
                                "cartError"
                        );

                    } else {

                        session.setAttribute(
                                "cartError",
                                "Only "
                                + product.getStockQuantity()
                                + " units of "
                                + product.getProductName()
                                + " are available."
                        );
                    }

                    productExists = true;

                    break;
                }
            }

            // Product is not already in cart
            if (!productExists) {

                CartItem cartItem =
                        new CartItem(
                                product,
                                1
                        );

                cart.add(cartItem);

                session.removeAttribute(
                        "cartError"
                );
            }

            response.sendRedirect(
                    request.getContextPath()
                    + "/products"
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID"
            );
        }
    }
}