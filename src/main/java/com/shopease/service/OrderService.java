package com.shopease.service;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;

import com.razorpay.RazorpayClient;
import com.shopease.dao.OrderDAO;
import com.shopease.model.CartItem;
import com.shopease.model.Order;
import com.shopease.model.OrderDetails;
import com.shopease.model.OrderItem;
import com.shopease.util.RazorpayUtil;

public class OrderService {

    private OrderDAO orderDAO;

    public OrderService() {
        orderDAO = new OrderDAO();
    }

    // ---------------------------------------------------------
    // Place normal order
    // ---------------------------------------------------------
    public int placeOrder(
            int userId,
            String shippingAddress,
            List<CartItem> cart) {

        if (cart == null || cart.isEmpty()) {
            throw new IllegalArgumentException("Cart is empty.");
        }

        if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
            throw new IllegalArgumentException("Shipping address is required.");
        }

        double totalAmount = 0;

        for (CartItem item : cart) {

            if (item == null || item.getProduct() == null) {
                throw new IllegalArgumentException("Invalid cart item.");
            }

            if (item.getQuantity() <= 0) {
                throw new IllegalArgumentException("Invalid product quantity.");
            }

            totalAmount += item.getTotalPrice();
        }

        Order order = new Order();

        order.setUserId(userId);
        order.setTotalAmount(totalAmount);
        order.setOrderStatus("PLACED");
        order.setShippingAddress(shippingAddress.trim());
        order.setPaymentStatus("PENDING");

        return orderDAO.createOrder(order, cart);
    }

    // ---------------------------------------------------------
    // Place Razorpay paid order
    // ---------------------------------------------------------
    public int placeRazorpayOrder(
            int userId,
            String shippingAddress,
            List<CartItem> cart,
            String razorpayOrderId,
            String razorpayPaymentId) {

        if (cart == null || cart.isEmpty()) {
            throw new IllegalArgumentException("Cart is empty.");
        }

        if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
            throw new IllegalArgumentException("Shipping address is required.");
        }

        if (razorpayOrderId == null || razorpayOrderId.trim().isEmpty()) {
            throw new IllegalArgumentException("Razorpay order ID is required.");
        }

        if (razorpayPaymentId == null || razorpayPaymentId.trim().isEmpty()) {
            throw new IllegalArgumentException("Razorpay payment ID is required.");
        }

        double totalAmount = 0;

        for (CartItem item : cart) {

            if (item == null || item.getProduct() == null) {
                throw new IllegalArgumentException("Invalid cart item.");
            }

            if (item.getQuantity() <= 0) {
                throw new IllegalArgumentException("Invalid product quantity.");
            }

            totalAmount += item.getTotalPrice();
        }

        Order order = new Order();

        order.setUserId(userId);
        order.setTotalAmount(totalAmount);
        order.setOrderStatus("PLACED");
        order.setShippingAddress(shippingAddress.trim());

        order.setRazorpayOrderId(razorpayOrderId);
        order.setRazorpayPaymentId(razorpayPaymentId);
        order.setPaymentStatus("PAID");

        return orderDAO.createOrder(order, cart);
    }

    // ---------------------------------------------------------
    // Get orders of a particular user
    // ---------------------------------------------------------
    public List<Order> getOrdersByUser(int userId) {

        return orderDAO.getOrdersByUser(userId);
    }

    // ---------------------------------------------------------
    // Get order items
    // ---------------------------------------------------------
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {

        return orderDAO.getOrderItemsByOrderId(orderId);
    }

    // ---------------------------------------------------------
    // Get complete order details for user
    // ---------------------------------------------------------
    public List<OrderDetails> getOrderDetailsByUser(int userId) {

        List<Order> orders = orderDAO.getOrdersByUser(userId);

        List<OrderDetails> orderDetailsList =
                new ArrayList<>();

        for (Order order : orders) {

            List<OrderItem> items =
                    orderDAO.getOrderItemsByOrderId(
                            order.getOrderId());

            orderDetailsList.add(
                    new OrderDetails(order, items)
            );
        }

        return orderDetailsList;
    }

    // ---------------------------------------------------------
    // Get single order details for a particular user
    // ---------------------------------------------------------
    public OrderDetails getOrderDetailsByOrderIdAndUser(
            int orderId,
            int userId) {

        Order order = orderDAO.getOrderById(orderId);

        if (order == null) {
            return null;
        }

        // Security check
        if (order.getUserId() != userId) {
            return null;
        }

        List<OrderItem> items =
                orderDAO.getOrderItemsByOrderId(orderId);

        return new OrderDetails(order, items);
    }

    // ---------------------------------------------------------
    // Get all orders - Admin
    // ---------------------------------------------------------
    public List<Order> getAllOrders() {

        return orderDAO.getAllOrders();
    }

    // ---------------------------------------------------------
    // Get order by ID
    // ---------------------------------------------------------
    public Order getOrderById(int orderId) {

        return orderDAO.getOrderById(orderId);
    }

    // ---------------------------------------------------------
    // Update order status - Admin
    // ---------------------------------------------------------
    public boolean updateOrderStatus(
            int orderId,
            String orderStatus) {

        if (orderStatus == null ||
                orderStatus.trim().isEmpty()) {

            return false;
        }

        return orderDAO.updateOrderStatus(
                orderId,
                orderStatus.trim()
        );
    }

    // ---------------------------------------------------------
    // Cancel order - Customer
    // ---------------------------------------------------------
    public boolean cancelOrder(
            int orderId,
            int userId) {

        Order order = orderDAO.getOrderById(orderId);

        // Order does not exist
        if (order == null) {
            return false;
        }

        // Make sure order belongs to logged-in customer
        if (order.getUserId() != userId) {
            return false;
        }

        // Only PLACED orders can be cancelled
        if (!"PLACED".equals(order.getOrderStatus())) {
            return false;
        }

        // -----------------------------------------------------
        // Razorpay refund for paid order
        // -----------------------------------------------------
        if ("PAID".equals(order.getPaymentStatus())) {

            String paymentId =
                    order.getRazorpayPaymentId();

            // Payment ID is required for refund
            if (paymentId == null ||
                    paymentId.trim().isEmpty()) {

                return false;
            }

            try {

                RazorpayClient razorpayClient =
                        RazorpayUtil.getClient();

                JSONObject refundRequest =
                        new JSONObject();

                /*
                 * Razorpay uses paise.
                 *
                 * Example:
                 * ₹1,999 = 199900 paise
                 */
                long amountInPaise =
                        Math.round(
                                order.getTotalAmount() * 100
                        );

                refundRequest.put(
                        "amount",
                        amountInPaise
                );

                // Create Razorpay refund
                razorpayClient.payments.refund(
                        paymentId,
                        refundRequest
                );

            } catch (Exception e) {

                e.printStackTrace();

                // If refund fails, do not cancel order
                return false;
            }
        }

        // -----------------------------------------------------
        // Cancel order and restore stock
        // -----------------------------------------------------
        return orderDAO.cancelOrder(orderId);
    }
}