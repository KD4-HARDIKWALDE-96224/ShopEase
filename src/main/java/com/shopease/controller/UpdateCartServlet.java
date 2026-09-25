package com.shopease.controller;

import java.io.IOException;
import java.util.List;

import com.shopease.model.CartItem;
import com.shopease.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/update-cart")
public class UpdateCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

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

        try {

            int productId =
                    Integer.parseInt(
                            request.getParameter("productId")
                    );

            String action =
                    request.getParameter("action");

            List<CartItem> cart =
                    (List<CartItem>)
                    session.getAttribute("cart");

            if (cart != null) {

                for (int i = 0; i < cart.size(); i++) {

                    CartItem item = cart.get(i);

                    if (item.getProduct()
                            .getProductId() == productId) {

                        // Increase quantity
                        if ("increase".equals(action)) {

                            int currentQuantity =
                                    item.getQuantity();

                            int availableStock =
                                    item.getProduct()
                                            .getStockQuantity();

                            if (currentQuantity
                                    < availableStock) {

                                item.setQuantity(
                                        currentQuantity + 1
                                );

                                session.removeAttribute(
                                        "cartError"
                                );

                            } else {

                                session.setAttribute(
                                        "cartError",
                                        "Only "
                                        + availableStock
                                        + " units of "
                                        + item.getProduct()
                                                .getProductName()
                                        + " are available."
                                );
                            }
                        }

                        // Decrease quantity
                        else if ("decrease".equals(action)) {

                            if (item.getQuantity() > 1) {

                                item.setQuantity(
                                        item.getQuantity() - 1
                                );

                            } else {

                                cart.remove(i);
                            }

                            session.removeAttribute(
                                    "cartError"
                            );
                        }

                        // Remove item
                        else if ("remove".equals(action)) {

                            cart.remove(i);

                            session.removeAttribute(
                                    "cartError"
                            );
                        }

                        break;
                    }
                }
            }

            response.sendRedirect(
                    request.getContextPath()
                    + "/cart"
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID"
            );
        }
    }
}