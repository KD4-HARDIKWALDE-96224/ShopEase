package com.shopease.service;

import com.shopease.dao.UserDAO;
import com.shopease.model.User;
import com.shopease.util.PasswordUtil;

public class UserService {

    private UserDAO userDAO;

    public UserService() {
        userDAO = new UserDAO();
    }

    public boolean registerUser(User user) {

        User existingUser =
                userDAO.getUserByEmail(user.getEmail());

        if (existingUser != null) {
            return false;
        }

        user.setRole("CUSTOMER");

        String hashedPassword =
                PasswordUtil.hashPassword(
                        user.getPassword()
                );

        user.setPassword(hashedPassword);

        return userDAO.registerUser(user);
    }

    public User loginUser(
            String email,
            String password) {

        User user =
                userDAO.getUserByEmail(email);

        if (user == null) {
            return null;
        }

        boolean passwordMatches =
                PasswordUtil.checkPassword(
                        password,
                        user.getPassword()
                );

        if (passwordMatches) {
            return user;
        }

        return null;
    }
}