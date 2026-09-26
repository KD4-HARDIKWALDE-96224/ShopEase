package com.shopease.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://gateway01.ap-southeast-1.prod.aws.tidbcloud.com:4000/shopease_db"
            + "?sslMode=VERIFY_IDENTITY";

    private static final String USER =
            System.getenv("TIDB_USER");

    private static final String PASSWORD =
            System.getenv("TIDB_PASSWORD");

    public static Connection getConnection() throws SQLException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}