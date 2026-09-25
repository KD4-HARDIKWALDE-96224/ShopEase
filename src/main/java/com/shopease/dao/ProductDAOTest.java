package com.shopease.dao;

import java.util.List;

import com.shopease.model.Product;

public class ProductDAOTest {

    public static void main(String[] args) {

        ProductDAO productDAO = new ProductDAO();

        List<Product> products = productDAO.getAllProducts();

        for (Product product : products) {

            System.out.println(
                product.getProductId()
                + " | "
                + product.getProductName()
                + " | ₹"
                + product.getPrice()
                + " | Stock: "
                + product.getStockQuantity()
            );
        }
    }
}