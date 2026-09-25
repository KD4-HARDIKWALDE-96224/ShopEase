package com.shopease.controller;

import java.io.IOException;
import java.util.List;

import com.shopease.model.OrderDetails;
import com.shopease.model.User;
import com.shopease.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/orders")
public class OrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderService orderService;

    @Override
    public void init() throws ServletException {

        orderService = new OrderService();
    }

    @Override
    protected void doGet(
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

        // Get orders with their items
        List<OrderDetails> orderDetailsList =
                orderService.getOrderDetailsByUser(
                        loggedInUser.getUserId()
                );

        request.setAttribute(
                "orderDetailsList",
                orderDetailsList
        );

        request.getRequestDispatcher(
                "/orders.jsp"
        ).forward(request, response);
    }
}