package com.shopease.controller;

import java.io.IOException;
import java.util.List;

import org.json.JSONObject;

import com.razorpay.Utils;
import com.shopease.model.CartItem;
import com.shopease.model.User;
import com.shopease.service.OrderService;
import com.shopease.util.RazorpayUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/verify-razorpay-payment")
public class VerifyRazorpayPaymentServlet extends HttpServlet {

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

        // User must be logged in
        if (session == null
                || session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp"
            );
            return;
        }

        User loggedInUser =
                (User) session.getAttribute(
                        "loggedInUser"
                );

        // Get Razorpay payment details
        String paymentId =
                request.getParameter(
                        "razorpay_payment_id"
                );

        String razorpayOrderId =
                request.getParameter(
                        "razorpay_order_id"
                );

        String signature =
                request.getParameter(
                        "razorpay_signature"
                );

        String shippingAddress =
                request.getParameter(
                        "shippingAddress"
                );

        // Validate required payment information
        if (paymentId == null
                || paymentId.trim().isEmpty()
                || razorpayOrderId == null
                || razorpayOrderId.trim().isEmpty()
                || signature == null
                || signature.trim().isEmpty()
                || shippingAddress == null
                || shippingAddress.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid payment information"
            );
            return;
        }

        // Get trusted Razorpay order ID from session
        String sessionRazorpayOrderId =
                (String) session.getAttribute(
                        "razorpayOrderId"
                );

        if (sessionRazorpayOrderId == null
                || !sessionRazorpayOrderId.equals(
                        razorpayOrderId
                )) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid Razorpay order"
            );
            return;
        }

        // Get cart from session
        @SuppressWarnings("unchecked")
        List<CartItem> cart =
                (List<CartItem>) session.getAttribute(
                        "cart"
                );

        if (cart == null || cart.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/cart"
            );
            return;
        }

        // Validate cart products and stock
        for (CartItem item : cart) {

            if (item.getProduct() == null) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid product in cart"
                );
                return;
            }

            int quantity =
                    item.getQuantity();

            int availableStock =
                    item.getProduct()
                            .getStockQuantity();

            if (quantity <= 0) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid product quantity"
                );
                return;
            }

            if (quantity > availableStock) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Insufficient stock for "
                        + item.getProduct()
                                .getProductName()
                );
                return;
            }
        }

        try {

            /*
             * Prepare payment details
             * for Razorpay signature verification.
             */
            JSONObject paymentAttributes =
                    new JSONObject();

            paymentAttributes.put(
                    "razorpay_order_id",
                    razorpayOrderId
            );

            paymentAttributes.put(
                    "razorpay_payment_id",
                    paymentId
            );

            paymentAttributes.put(
                    "razorpay_signature",
                    signature
            );

            /*
             * Verify Razorpay payment signature.
             */
            boolean signatureValid =
                    Utils.verifyPaymentSignature(
                            paymentAttributes,
                            RazorpayUtil.getKeySecret()
                    );

            if (!signatureValid) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Payment verification failed"
                );
                return;
            }

            /*
             * Payment is successfully verified.
             *
             * Now create the ShopEase order
             * using the existing OrderService.
             */
            int orderId =
                    orderService.placeRazorpayOrder(
                            loggedInUser.getUserId(),
                            shippingAddress.trim(),
                            cart,
                            razorpayOrderId,
                            paymentId
                    );

            if (orderId > 0) {

                // Clear cart
                session.removeAttribute(
                        "cart"
                );

                // Clear Razorpay session data
                session.removeAttribute(
                        "razorpayOrderId"
                );

                session.removeAttribute(
                        "razorpayOrderAmount"
                );

                // Store last order ID
                session.setAttribute(
                        "lastOrderId",
                        orderId
                );

                // Redirect to order success page
                response.sendRedirect(
                        request.getContextPath()
                        + "/order-success.jsp"
                );

        
            } else {

                response.sendError(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Payment verified but order could not be created"
                );
            }

        } catch (Exception e) {

        	
            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to verify payment"
            );
        }
    }
}