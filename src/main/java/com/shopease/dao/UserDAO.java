package com.shopease.dao;

import java.sql.Connection;

import java.util.ArrayList;
import java.util.List;


import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.shopease.model.User;
import com.shopease.util.DBConnection;

public class UserDAO {

    // Register a new user
    public boolean registerUser(User user) {

        String sql = """
                INSERT INTO users
                (full_name, email, password, phone, address, role)
                VALUES (?, ?, ?, ?, ?, ?)
                """;

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(1, user.getFullName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());
            statement.setString(4, user.getPhone());
            statement.setString(5, user.getAddress());
            statement.setString(6, user.getRole());

            int rows =
                    statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // Find user by email
    public User getUserByEmail(String email) {

        User user = null;

        String sql =
                "SELECT * FROM users WHERE email = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(1, email);

            try (ResultSet resultSet =
                    statement.executeQuery()) {

                if (resultSet.next()) {

                    user = new User();

                    user.setUserId(
                            resultSet.getInt("user_id")
                    );

                    user.setFullName(
                            resultSet.getString("full_name")
                    );

                    user.setEmail(
                            resultSet.getString("email")
                    );

                    user.setPassword(
                            resultSet.getString("password")
                    );

                    user.setPhone(
                            resultSet.getString("phone")
                    );

                    user.setAddress(
                            resultSet.getString("address")
                    );

                    user.setRole(
                            resultSet.getString("role")
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return user;
    }
    
    public List<User> getAllUsers() {

        List<User> users = new ArrayList<>();

        String sql = """
                SELECT *
                FROM users
                ORDER BY user_id
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

                User user = new User();

                user.setUserId(
                        resultSet.getInt("user_id")
                );

                user.setFullName(
                        resultSet.getString("full_name")
                );

                user.setEmail(
                        resultSet.getString("email")
                );

                user.setPassword(
                        resultSet.getString("password")
                );

                user.setPhone(
                        resultSet.getString("phone")
                );

                user.setAddress(
                        resultSet.getString("address")
                );

                user.setRole(
                        resultSet.getString("role")
                );

                users.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }
    
    public boolean updateUserRole(
            int userId,
            String role) {

        String sql = """
                UPDATE users
                SET role = ?
                WHERE user_id = ?
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(1, role);
            statement.setInt(2, userId);

            int rows = statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    public boolean deleteUser(int userId) {

        String sql = """
                DELETE FROM users
                WHERE user_id = ?
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, userId);

            int rows = statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}