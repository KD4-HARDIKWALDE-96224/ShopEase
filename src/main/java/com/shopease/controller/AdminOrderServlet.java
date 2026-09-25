package com.shopease.controller;

import java.io.IOException;
import java.util.List;

import com.shopease.dao.OrderDAO;
import com.shopease.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {

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

        List<Order> orders =
                orderDAO.getAllOrders();

        request.setAttribute(
                "orders",
                orders
        );

        request.getRequestDispatcher(
                "/admin-orders.jsp"
        ).forward(
                request,
                response
        );
    }
}