package com.shopease.controller;

import java.io.IOException;

import com.shopease.model.User;
import com.shopease.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cancel-order")
public class CancelOrderServlet extends HttpServlet {

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
                    (User) session.getAttribute("loggedInUser");
        }

        // User must be logged in
        if (loggedInUser == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );

            return;
        }

        String orderIdParam =
                request.getParameter("orderId");

        if (orderIdParam == null ||
            orderIdParam.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Order ID is required."
            );

            return;
        }

        int orderId;

        try {

            orderId =
                    Integer.parseInt(orderIdParam);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid Order ID."
            );

            return;
        }

        boolean cancelled =
                orderService.cancelOrder(
                        orderId,
                        loggedInUser.getUserId()
                );

        if (cancelled) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/orders"
            );

        } else {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Order cannot be cancelled."
            );
        }
    }
}