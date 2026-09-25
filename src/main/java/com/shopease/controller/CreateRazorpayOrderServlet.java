package com.shopease.controller;

import java.io.IOException;
import java.util.List;

import org.json.JSONObject;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.shopease.model.CartItem;
import com.shopease.util.RazorpayUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/create-razorpay-order")
public class CreateRazorpayOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("loggedInUser") == null) {

            response.sendError(
                    HttpServletResponse.SC_UNAUTHORIZED,
                    "Please login first"
            );
            return;
        }

        @SuppressWarnings("unchecked")
        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Cart is empty"
            );
            return;
        }

        double totalAmount = 0;

        for (CartItem item : cart) {
            totalAmount += item.getTotalPrice();
        }

        long amountInPaise =
                Math.round(totalAmount * 100);

        try {

            RazorpayClient razorpayClient =
                    RazorpayUtil.getClient();

            JSONObject orderRequest =
                    new JSONObject();

            orderRequest.put(
                    "amount",
                    amountInPaise
            );

            orderRequest.put(
                    "currency",
                    "INR"
            );

            orderRequest.put(
                    "receipt",
                    "SHOP_" + System.currentTimeMillis()
            );

            Order razorpayOrder =
                    razorpayClient.orders.create(orderRequest);

            String razorpayOrderId =
                    (String) razorpayOrder.get("id");

            // Store Razorpay order details in session
            session.setAttribute(
                    "razorpayOrderId",
                    razorpayOrderId
            );

            session.setAttribute(
                    "razorpayOrderAmount",
                    amountInPaise
            );

            JSONObject result =
                    new JSONObject();

            result.put(
                    "orderId",
                    razorpayOrderId
            );

            result.put(
                    "amount",
                    amountInPaise
            );

            result.put(
                    "currency",
                    "INR"
            );

            result.put(
                    "keyId",
                    RazorpayUtil.getKeyId()
            );

            response.setContentType(
                    "application/json"
            );

            response.getWriter().write(
                    result.toString()
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to create Razorpay order"
            );
        }
    }
}