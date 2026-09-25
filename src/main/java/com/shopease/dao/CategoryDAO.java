package com.shopease.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.shopease.model.Category;
import com.shopease.util.DBConnection;

public class CategoryDAO {

    public List<Category> getAllCategories() {

        List<Category> categories =
                new ArrayList<>();

        String sql = """
                SELECT *
                FROM categories
                ORDER BY category_id
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

                Category category =
                        new Category();

                category.setCategoryId(
                        resultSet.getInt("category_id")
                );

                category.setCategoryName(
                        resultSet.getString("category_name")
                );

                category.setDescription(
                        resultSet.getString("description")
                );

                categories.add(category);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return categories;
    }
    
    public boolean addCategory(Category category) {

        String sql = """
                INSERT INTO categories
                (category_name, description)
                VALUES (?, ?)
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    category.getCategoryName()
            );

            statement.setString(
                    2,
                    category.getDescription()
            );

            int rows =
                    statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
    
    public boolean updateCategory(Category category) {

        String sql = """
                UPDATE categories
                SET category_name = ?,
                    description = ?
                WHERE category_id = ?
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    category.getCategoryName()
            );

            statement.setString(
                    2,
                    category.getDescription()
            );

            statement.setInt(
                    3,
                    category.getCategoryId()
            );

            int rows =
                    statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
    
    public boolean deleteCategory(int categoryId) {

        String sql = """
                DELETE FROM categories
                WHERE category_id = ?
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, categoryId);

            int rows = statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    } 
    
    public Category getCategoryById(int categoryId) {

        Category category = null;

        String sql = """
                SELECT *
                FROM categories
                WHERE category_id = ?
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

                if (resultSet.next()) {

                    category = new Category();

                    category.setCategoryId(
                            resultSet.getInt("category_id")
                    );

                    category.setCategoryName(
                            resultSet.getString("category_name")
                    );

                    category.setDescription(
                            resultSet.getString("description")
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return category;
    }
}