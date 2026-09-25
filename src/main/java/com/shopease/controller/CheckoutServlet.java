package com.shopease.controller;

import java.io.IOException;
import java.util.List;

import com.shopease.model.CartItem;
import com.shopease.model.User;
import com.shopease.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
    }

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

        List<CartItem> cart =
                (List<CartItem>)
                session.getAttribute("cart");

        // Cart must not be empty
        if (cart == null || cart.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/cart"
            );

            return;
        }

        String shippingAddress =
                request.getParameter("shippingAddress");

        // Validate shipping address
        if (shippingAddress == null
                || shippingAddress.trim().isEmpty()) {

            request.setAttribute(
                    "error",
                    "Please enter your shipping address."
            );

            request.getRequestDispatcher(
                    "/checkout.jsp"
            ).forward(
                    request,
                    response
            );

            return;
        }

        // Validate cart quantities against stock
        for (CartItem item : cart) {

            if (item.getProduct() == null) {

                request.setAttribute(
                        "error",
                        "Invalid product in cart."
                );

                request.getRequestDispatcher(
                        "/cart.jsp"
                ).forward(
                        request,
                        response
                );

                return;
            }

            int quantity =
                    item.getQuantity();

            int availableStock =
                    item.getProduct()
                            .getStockQuantity();

            if (quantity <= 0) {

                request.setAttribute(
                        "error",
                        "Invalid product quantity."
                );

                request.getRequestDispatcher(
                        "/cart.jsp"
                ).forward(
                        request,
                        response
                );

                return;
            }

            if (quantity > availableStock) {

                request.setAttribute(
                        "error",
                        "Only "
                        + availableStock
                        + " units of "
                        + item.getProduct()
                                .getProductName()
                        + " are available."
                );

                request.getRequestDispatcher(
                        "/cart.jsp"
                ).forward(
                        request,
                        response
                );

                return;
            }
        }

        // Place order
        int orderId =
                orderService.placeOrder(
                        loggedInUser.getUserId(),
                        shippingAddress.trim(),
                        cart
                );

        if (orderId > 0) {

            // Clear cart after successful order
            session.removeAttribute("cart");

            // Store last order ID
            session.setAttribute(
                    "lastOrderId",
                    orderId
            );

            response.sendRedirect(
                    request.getContextPath()
                    + "/order-success.jsp"
            );

        } else {

            request.setAttribute(
                    "error",
                    "Unable to place the order. "
                    + "Please check product availability "
                    + "and try again."
            );

            request.getRequestDispatcher(
                    "/cart.jsp"
            ).forward(
                    request,
                    response
            );
        }
    }
}