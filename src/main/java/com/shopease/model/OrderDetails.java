package com.shopease.model;

import java.util.List;

public class OrderDetails {

    private Order order;
    private List<OrderItem> items;

    public OrderDetails() {
    }

    public OrderDetails(
            Order order,
            List<OrderItem> items) {

        this.order = order;
        this.items = items;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
}