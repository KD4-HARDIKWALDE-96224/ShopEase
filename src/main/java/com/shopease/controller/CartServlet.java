package com.shopease.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.shopease.model.CartItem;
import com.shopease.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

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

        if (cart == null) {

            cart = new ArrayList<>();

            session.setAttribute(
                    "cart",
                    cart
            );
        }

        double cartTotal = 0;

        int cartItemCount = 0;

        for (CartItem item : cart) {

            cartTotal += item.getTotalPrice();

            cartItemCount += item.getQuantity();
        }

        request.setAttribute(
                "cart",
                cart
        );

        request.setAttribute(
                "cartTotal",
                cartTotal
        );

        request.setAttribute(
                "cartItemCount",
                cartItemCount
        );

        request.getRequestDispatcher(
                "/cart.jsp"
        ).forward(
                request,
                response
        );
    }
}