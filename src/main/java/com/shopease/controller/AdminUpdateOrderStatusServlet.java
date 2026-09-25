package com.shopease.controller;

import java.io.IOException;

import com.shopease.dao.OrderDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/orders/update-status")
public class AdminUpdateOrderStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int orderId =
                    Integer.parseInt(
                            request.getParameter("orderId")
                    );

            String orderStatus =
                    request.getParameter("orderStatus");

            if (orderStatus == null
                    || orderStatus.trim().isEmpty()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/orders"
                );

                return;
            }

            orderDAO.updateOrderStatus(
                    orderId,
                    orderStatus
            );

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/orders"
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid order ID"
            );
        }
    }
}