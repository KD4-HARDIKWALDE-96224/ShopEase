package com.shopease.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.shopease.model.Product;
import com.shopease.util.DBConnection;

public class ProductDAO {

    public List<Product> getAllProducts() {

        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT *
                FROM products
                ORDER BY product_id
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql);

                ResultSet resultSet =
                        statement.executeQuery()
        ) {

            while (resultSet.next()) {

                Product product = new Product();

                product.setProductId(
                        resultSet.getInt("product_id")
                );

                product.setProductName(
                        resultSet.getString("product_name")
                );

                product.setDescription(
                        resultSet.getString("description")
                );

                product.setPrice(
                        resultSet.getDouble("price")
                );

                product.setDiscount(
                        resultSet.getDouble("discount")
                );

                product.setStockQuantity(
                        resultSet.getInt("stock_quantity")
                );

                product.setImageUrl(
                        resultSet.getString("image_url")
                );

                product.setCategoryId(
                        resultSet.getInt("category_id")
                );

                products.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }
    
    public boolean addProduct(Product product) {

        String sql = """
                INSERT INTO products
                (product_name, description, price, discount,
                 stock_quantity, image_url, category_id)
                VALUES (?, ?, ?, ?, ?, ?, ?)
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    product.getProductName()
            );

            statement.setString(
                    2,
                    product.getDescription()
            );

            statement.setDouble(
                    3,
                    product.getPrice()
            );

            statement.setDouble(
                    4,
                    product.getDiscount()
            );

            statement.setInt(
                    5,
                    product.getStockQuantity()
            );

            statement.setString(
                    6,
                    product.getImageUrl()
            );

            statement.setInt(
                    7,
                    product.getCategoryId()
            );

            int rows =
                    statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    public Product getProductById(int productId) {

        Product product = null;

        String sql = """
                SELECT *
                FROM products
                WHERE product_id = ?
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, productId);

            try (ResultSet resultSet =
                    statement.executeQuery()) {

                if (resultSet.next()) {

                    product = new Product();

                    product.setProductId(
                            resultSet.getInt("product_id")
                    );

                    product.setProductName(
                            resultSet.getString("product_name")
                    );

                    product.setDescription(
                            resultSet.getString("description")
                    );

                    product.setPrice(
                            resultSet.getDouble("price")
                    );

                    product.setDiscount(
                            resultSet.getDouble("discount")
                    );

                    product.setStockQuantity(
                            resultSet.getInt("stock_quantity")
                    );

                    product.setImageUrl(
                            resultSet.getString("image_url")
                    );

                    product.setCategoryId(
                            resultSet.getInt("category_id")
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return product;
    }


    public List<Product> searchProducts(String keyword) {

        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT *
                FROM products
                WHERE LOWER(product_name) LIKE ?
                   OR LOWER(description) LIKE ?
                ORDER BY product_id
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            String searchKeyword =
                    "%" + keyword.toLowerCase().trim() + "%";

            statement.setString(1, searchKeyword);
            statement.setString(2, searchKeyword);

            try (ResultSet resultSet =
                    statement.executeQuery()) {

                while (resultSet.next()) {

                    Product product = new Product();

                    product.setProductId(
                            resultSet.getInt("product_id")
                    );

                    product.setProductName(
                            resultSet.getString("product_name")
                    );

                    product.setDescription(
                            resultSet.getString("description")
                    );

                    product.setPrice(
                            resultSet.getDouble("price")
                    );

                    product.setDiscount(
                            resultSet.getDouble("discount")
                    );

                    product.setStockQuantity(
                            resultSet.getInt("stock_quantity")
                    );

                    product.setImageUrl(
                            resultSet.getString("image_url")
                    );

                    product.setCategoryId(
                            resultSet.getInt("category_id")
                    );

                    products.add(product);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }
    
    public List<Product> getProductsByCategory(int categoryId) {

        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT *
                FROM products
                WHERE category_id = ?
                ORDER BY product_id
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, categoryId);

            try (ResultSet resultSet =
                    statement.executeQuery()) {

                while (resultSet.next()) {

                    Product product = new Product();

                    product.setProductId(
                            resultSet.getInt("product_id")
                    );

                    product.setProductName(
                            resultSet.getString("product_name")
                    );

                    product.setDescription(
                            resultSet.getString("description")
                    );

                    product.setPrice(
                            resultSet.getDouble("price")
                    );

                    product.setDiscount(
                            resultSet.getDouble("discount")
                    );

                    product.setStockQuantity(
                            resultSet.getInt("stock_quantity")
                    );

                    product.setImageUrl(
                            resultSet.getString("image_url")
                    );

                    product.setCategoryId(
                            resultSet.getInt("category_id")
                    );

                    products.add(product);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }
    
    public List<Product> getProductsSortedByPriceAsc() {

        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT *
                FROM products
                ORDER BY price ASC
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql);

                ResultSet resultSet =
                        statement.executeQuery()
        ) {

            while (resultSet.next()) {

                Product product = new Product();

                product.setProductId(
                        resultSet.getInt("product_id")
                );

                product.setProductName(
                        resultSet.getString("product_name")
                );

                product.setDescription(
                        resultSet.getString("description")
                );

                product.setPrice(
                        resultSet.getDouble("price")
                );

                product.setDiscount(
                        resultSet.getDouble("discount")
                );

                product.setStockQuantity(
                        resultSet.getInt("stock_quantity")
                );

                product.setImageUrl(
                        resultSet.getString("image_url")
                );

                product.setCategoryId(
                        resultSet.getInt("category_id")
                );

                products.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    public List<Product> getProductsSortedByPriceDesc() {

        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT *
                FROM products
                ORDER BY price DESC
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql);

                ResultSet resultSet =
                        statement.executeQuery()
        ) {

            while (resultSet.next()) {

                Product product = new Product();

                product.setProductId(
                        resultSet.getInt("product_id")
                );

                product.setProductName(
                        resultSet.getString("product_name")
                );

                product.setDescription(
                        resultSet.getString("description")
                );

                product.setPrice(
                        resultSet.getDouble("price")
                );

                product.setDiscount(
                        resultSet.getDouble("discount")
                );

                product.setStockQuantity(
                        resultSet.getInt("stock_quantity")
                );

                product.setImageUrl(
                        resultSet.getString("image_url")
                );

                product.setCategoryId(
                        resultSet.getInt("category_id")
                );

                products.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    public List<Product> getProductsSortedByNewest() {

        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT *
                FROM products
                ORDER BY product_id DESC
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql);

                ResultSet resultSet =
                        statement.executeQuery()
        ) {

            while (resultSet.next()) {

                Product product = new Product();

                product.setProductId(
                        resultSet.getInt("product_id")
                );

                product.setProductName(
                        resultSet.getString("product_name")
                );

                product.setDescription(
                        resultSet.getString("description")
                );

                product.setPrice(
                        resultSet.getDouble("price")
                );

                product.setDiscount(
                        resultSet.getDouble("discount")
                );

                product.setStockQuantity(
                        resultSet.getInt("stock_quantity")
                );

                product.setImageUrl(
                        resultSet.getString("image_url")
                );

                product.setCategoryId(
                        resultSet.getInt("category_id")
                );

                products.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }
    
    public List<Product> searchProducts(
            String keyword,
            Integer categoryId,
            String sort) {

        List<Product> products = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
                SELECT *
                FROM products
                WHERE 1 = 1
                """);

        List<Object> parameters = new ArrayList<>();

        if (keyword != null
                && !keyword.trim().isEmpty()) {

            sql.append("""
                    AND (
                        LOWER(product_name) LIKE ?
                        OR LOWER(description) LIKE ?
                    )
                    """);

            String searchKeyword =
                    "%" + keyword.toLowerCase().trim() + "%";

            parameters.add(searchKeyword);
            parameters.add(searchKeyword);
        }

        if (categoryId != null) {

            sql.append("""
                    AND category_id = ?
                    """);

            parameters.add(categoryId);
        }

        if ("priceAsc".equals(sort)) {

            sql.append("""
                    ORDER BY price ASC
                    """);

        } else if ("priceDesc".equals(sort)) {

            sql.append("""
                    ORDER BY price DESC
                    """);

        } else if ("newest".equals(sort)) {

            sql.append("""
                    ORDER BY product_id DESC
                    """);

        } else {

            sql.append("""
                    ORDER BY product_id
                    """);
        }

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(
                                sql.toString()
                        )
        ) {

            for (int i = 0;
                    i < parameters.size();
                    i++) {

                statement.setObject(
                        i + 1,
                        parameters.get(i)
                );
            }

            try (ResultSet resultSet =
                    statement.executeQuery()) {

                while (resultSet.next()) {

                    Product product = new Product();

                    product.setProductId(
                            resultSet.getInt("product_id")
                    );

                    product.setProductName(
                            resultSet.getString("product_name")
                    );

                    product.setDescription(
                            resultSet.getString("description")
                    );

                    product.setPrice(
                            resultSet.getDouble("price")
                    );

                    product.setDiscount(
                            resultSet.getDouble("discount")
                    );

                    product.setStockQuantity(
                            resultSet.getInt("stock_quantity")
                    );

                    product.setImageUrl(
                            resultSet.getString("image_url")
                    );

                    product.setCategoryId(
                            resultSet.getInt("category_id")
                    );

                    products.add(product);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }
    
    public boolean updateProduct(Product product) {

        String sql = """
                UPDATE products
                SET product_name = ?,
                    description = ?,
                    price = ?,
                    discount = ?,
                    stock_quantity = ?,
                    image_url = ?,
                    category_id = ?
                WHERE product_id = ?
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    product.getProductName()
            );

            statement.setString(
                    2,
                    product.getDescription()
            );

            statement.setDouble(
                    3,
                    product.getPrice()
            );

            statement.setDouble(
                    4,
                    product.getDiscount()
            );

            statement.setInt(
                    5,
                    product.getStockQuantity()
            );

            statement.setString(
                    6,
                    product.getImageUrl()
            );

            statement.setInt(
                    7,
                    product.getCategoryId()
            );

            statement.setInt(
                    8,
                    product.getProductId()
            );

            int rows =
                    statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
    
    public boolean deleteProduct(int productId) {

        String sql = """
                DELETE FROM products
                WHERE product_id = ?
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, productId);

            int rows =
                    statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
}