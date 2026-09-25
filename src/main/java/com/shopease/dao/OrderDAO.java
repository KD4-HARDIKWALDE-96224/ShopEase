package com.shopease.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.shopease.model.CartItem;
import com.shopease.model.Order;
import com.shopease.model.OrderItem;
import com.shopease.util.DBConnection;

public class OrderDAO {

    // =========================================================
    // CREATE ORDER
    // =========================================================

    public int createOrder(
            Order order,
            List<CartItem> cart) {

        String orderSql =
                "INSERT INTO orders " +
                "(user_id, total_amount, order_status, shipping_address, " +
                "razorpay_order_id, razorpay_payment_id, payment_status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        String itemSql =
                "INSERT INTO order_items " +
                "(order_id, product_id, quantity, price) " +
                "VALUES (?, ?, ?, ?)";

        String stockSql =
                "UPDATE products " +
                "SET stock_quantity = stock_quantity - ? " +
                "WHERE product_id = ? " +
                "AND stock_quantity >= ?";

        try (Connection connection =
                     DBConnection.getConnection()) {

            connection.setAutoCommit(false);

            try (
                PreparedStatement orderStatement =
                        connection.prepareStatement(
                                orderSql,
                                java.sql.Statement.RETURN_GENERATED_KEYS
                        );

                PreparedStatement itemStatement =
                        connection.prepareStatement(itemSql);

                PreparedStatement stockStatement =
                        connection.prepareStatement(stockSql)
            ) {

                // -------------------------------------------------
                // Insert Order
                // -------------------------------------------------

                orderStatement.setInt(
                        1,
                        order.getUserId()
                );

                orderStatement.setDouble(
                        2,
                        order.getTotalAmount()
                );

                orderStatement.setString(
                        3,
                        order.getOrderStatus()
                );

                orderStatement.setString(
                        4,
                        order.getShippingAddress()
                );

                orderStatement.setString(
                        5,
                        order.getRazorpayOrderId()
                );

                orderStatement.setString(
                        6,
                        order.getRazorpayPaymentId()
                );

                orderStatement.setString(
                        7,
                        order.getPaymentStatus()
                );

                int orderRows =
                        orderStatement.executeUpdate();

                if (orderRows != 1) {

                    connection.rollback();

                    return -1;
                }

                int orderId;

                try (ResultSet generatedKeys =
                             orderStatement.getGeneratedKeys()) {

                    if (!generatedKeys.next()) {

                        connection.rollback();

                        return -1;
                    }

                    orderId =
                            generatedKeys.getInt(1);
                }


                // -------------------------------------------------
                // Insert Order Items + Reduce Stock
                // -------------------------------------------------

                for (CartItem cartItem : cart) {

                    if (cartItem == null ||
                        cartItem.getProduct() == null ||
                        cartItem.getQuantity() <= 0) {

                        connection.rollback();

                        return -1;
                    }

                    int productId =
                            cartItem.getProduct().getProductId();

                    int quantity =
                            cartItem.getQuantity();

                    double price =
                            cartItem.getProduct().getPrice();


                    // Insert order item

                    itemStatement.setInt(
                            1,
                            orderId
                    );

                    itemStatement.setInt(
                            2,
                            productId
                    );

                    itemStatement.setInt(
                            3,
                            quantity
                    );

                    itemStatement.setDouble(
                            4,
                            price
                    );

                    itemStatement.addBatch();


                    // Reduce stock

                    stockStatement.setInt(
                            1,
                            quantity
                    );

                    stockStatement.setInt(
                            2,
                            productId
                    );

                    stockStatement.setInt(
                            3,
                            quantity
                    );

                    int stockRows =
                            stockStatement.executeUpdate();

                    if (stockRows != 1) {

                        connection.rollback();

                        return -1;
                    }
                }


                // Execute order item inserts

                itemStatement.executeBatch();


                connection.commit();

                return orderId;

            } catch (Exception e) {

                connection.rollback();

                e.printStackTrace();

                return -1;
            }

        } catch (Exception e) {

            e.printStackTrace();

            return -1;
        }
    }


    // =========================================================
    // GET ORDERS BY USER
    // =========================================================

    public List<Order> getOrdersByUser(int userId) {

        List<Order> orders =
                new ArrayList<>();

        String sql =
                "SELECT order_id, user_id, total_amount, " +
                "order_status, shipping_address, order_date, " +
                "razorpay_order_id, razorpay_payment_id, payment_status " +
                "FROM orders " +
                "WHERE user_id = ? " +
                "ORDER BY order_date DESC";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setInt(
                    1,
                    userId
            );

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Order order =
                            mapOrder(resultSet);

                    orders.add(order);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return orders;
    }


    // =========================================================
    // GET ORDER ITEMS
    // =========================================================

    public List<OrderItem> getOrderItemsByOrderId(
            int orderId) {

        List<OrderItem> items =
                new ArrayList<>();

        String sql =
                "SELECT oi.order_item_id, " +
                "oi.order_id, " +
                "oi.product_id, " +
                "oi.quantity, " +
                "oi.price, " +
                "p.product_name " +
                "FROM order_items oi " +
                "JOIN products p " +
                "ON oi.product_id = p.product_id " +
                "WHERE oi.order_id = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setInt(
                    1,
                    orderId
            );

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    OrderItem item =
                            new OrderItem();

                    item.setOrderItemId(
                            resultSet.getInt(
                                    "order_item_id"
                            )
                    );

                    item.setOrderId(
                            resultSet.getInt(
                                    "order_id"
                            )
                    );

                    item.setProductId(
                            resultSet.getInt(
                                    "product_id"
                            )
                    );

                    item.setQuantity(
                            resultSet.getInt(
                                    "quantity"
                            )
                    );

                    item.setPrice(
                            resultSet.getDouble(
                                    "price"
                            )
                    );

                    item.setProductName(
                            resultSet.getString(
                                    "product_name"
                            )
                    );

                    items.add(item);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return items;
    }


    // =========================================================
    // GET ALL ORDERS - ADMIN
    // =========================================================

    public List<Order> getAllOrders() {

        List<Order> orders =
                new ArrayList<>();

        String sql =
                "SELECT order_id, user_id, total_amount, " +
                "order_status, shipping_address, order_date, " +
                "razorpay_order_id, razorpay_payment_id, payment_status " +
                "FROM orders " +
                "ORDER BY order_date DESC";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            ResultSet resultSet =
                    statement.executeQuery()
        ) {

            while (resultSet.next()) {

                Order order =
                        mapOrder(resultSet);

                orders.add(order);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return orders;
    }


    // =========================================================
    // UPDATE ORDER STATUS - ADMIN
    // =========================================================

    public boolean updateOrderStatus(
            int orderId,
            String orderStatus) {

        String sql =
                "UPDATE orders " +
                "SET order_status = ? " +
                "WHERE order_id = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    orderStatus
            );

            statement.setInt(
                    2,
                    orderId
            );

            return statement.executeUpdate() == 1;

        } catch (SQLException e) {

            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // GET ORDER BY ID
    // =========================================================

    public Order getOrderById(int orderId) {

        String sql =
                "SELECT order_id, user_id, total_amount, " +
                "order_status, shipping_address, order_date, " +
                "razorpay_order_id, razorpay_payment_id, payment_status " +
                "FROM orders " +
                "WHERE order_id = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setInt(
                    1,
                    orderId
            );

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    return mapOrder(resultSet);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // CANCEL ORDER - CUSTOMER
    // =========================================================

    public boolean cancelOrder(int orderId) {

        String getItemsSql =
                "SELECT product_id, quantity " +
                "FROM order_items " +
                "WHERE order_id = ?";

        String updateOrderSql =
                "UPDATE orders " +
                "SET order_status = 'CANCELLED' " +
                "WHERE order_id = ? " +
                "AND order_status = 'PLACED'";

        String updateStockSql =
                "UPDATE products " +
                "SET stock_quantity = stock_quantity + ? " +
                "WHERE product_id = ?";


        try (
            Connection connection =
                    DBConnection.getConnection()
        ) {

            connection.setAutoCommit(false);

            try (
                PreparedStatement getItemsStatement =
                        connection.prepareStatement(
                                getItemsSql
                        );

                PreparedStatement updateOrderStatement =
                        connection.prepareStatement(
                                updateOrderSql
                        );

                PreparedStatement updateStockStatement =
                        connection.prepareStatement(
                                updateStockSql
                        )
            ) {


                // -------------------------------------------------
                // Get all products from the order
                // -------------------------------------------------

                getItemsStatement.setInt(
                        1,
                        orderId
                );

                try (ResultSet resultSet =
                             getItemsStatement.executeQuery()) {

                    while (resultSet.next()) {

                        int productId =
                                resultSet.getInt(
                                        "product_id"
                                );

                        int quantity =
                                resultSet.getInt(
                                        "quantity"
                                );


                        // Restore stock

                        updateStockStatement.setInt(
                                1,
                                quantity
                        );

                        updateStockStatement.setInt(
                                2,
                                productId
                        );

                        updateStockStatement.executeUpdate();
                    }
                }


                // -------------------------------------------------
                // Change order status to CANCELLED
                // -------------------------------------------------

                updateOrderStatement.setInt(
                        1,
                        orderId
                );

                int rowsUpdated =
                        updateOrderStatement.executeUpdate();


                if (rowsUpdated != 1) {

                    connection.rollback();

                    return false;
                }


                connection.commit();

                return true;


            } catch (Exception e) {

                connection.rollback();

                e.printStackTrace();

                return false;
            }


        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // MAP RESULTSET TO ORDER
    // =========================================================

    private Order mapOrder(
            ResultSet resultSet)
            throws SQLException {

        Order order =
                new Order();

        order.setOrderId(
                resultSet.getInt(
                        "order_id"
                )
        );

        order.setUserId(
                resultSet.getInt(
                        "user_id"
                )
        );

        order.setTotalAmount(
                resultSet.getDouble(
                        "total_amount"
                )
        );

        order.setOrderStatus(
                resultSet.getString(
                        "order_status"
                )
        );

        order.setShippingAddress(
                resultSet.getString(
                        "shipping_address"
                )
        );


        Timestamp orderTimestamp =
                resultSet.getTimestamp(
                        "order_date"
                );

        if (orderTimestamp != null) {

            order.setOrderDate(
                    orderTimestamp.toLocalDateTime()
            );
        }


        order.setRazorpayOrderId(
                resultSet.getString(
                        "razorpay_order_id"
                )
        );

        order.setRazorpayPaymentId(
                resultSet.getString(
                        "razorpay_payment_id"
                )
        );

        order.setPaymentStatus(
                resultSet.getString(
                        "payment_status"
                )
        );


        return order;
    }
}