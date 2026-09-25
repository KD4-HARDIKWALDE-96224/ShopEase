package com.shopease.controller;

import java.io.IOException;
import java.util.List;

import com.shopease.dao.OrderDAO;
import com.shopease.model.Order;
import com.shopease.model.OrderItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/orders/details")
public class AdminOrderDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdParameter =
                request.getParameter("orderId");

        if (orderIdParameter == null
                || orderIdParameter.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Order ID is required"
            );

            return;
        }

        try {

            int orderId =
                    Integer.parseInt(orderIdParameter);

            Order order =
                    orderDAO.getOrderById(orderId);

            if (order == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Order not found"
                );

                return;
            }

            List<OrderItem> orderItems =
                    orderDAO.getOrderItemsByOrderId(
                            orderId
                    );

            request.setAttribute(
                    "order",
                    order
            );

            request.setAttribute(
                    "orderItems",
                    orderItems
            );

            request.getRequestDispatcher(
                    "/admin-order-details.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid order ID"
            );
        }
    }
}