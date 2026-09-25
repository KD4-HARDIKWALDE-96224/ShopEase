<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>ShopEase - Register</title>

    <link rel="stylesheet"
        href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

    <nav class="navbar">

        <div class="logo">
            Shop<span>Ease</span>
        </div>

        <div class="nav-actions">

            <a href="${pageContext.request.contextPath}/products">
                Products
            </a>

            <a href="${pageContext.request.contextPath}/login.jsp">
                Login
            </a>

        </div>

    </nav>


    <section class="auth-section">

        <div class="auth-card">

            <h1>Create Account</h1>

            <p class="auth-subtitle">
                Join ShopEase and start shopping today.
            </p>


            <% if (request.getAttribute("error") != null) { %>

                <div class="auth-error">
                    <%= request.getAttribute("error") %>
                </div>

            <% } %>


            <form
                action="${pageContext.request.contextPath}/register"
                method="post">


                <div class="form-group">

                    <label for="fullName">
                        Full Name
                    </label>

                    <input
                        type="text"
                        id="fullName"
                        name="fullName"
                        placeholder="Enter your full name"
                        required>

                </div>


                <div class="form-group">

                    <label for="email">
                        Email
                    </label>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="Enter your email"
                        required>

                </div>


                <div class="form-group">

                    <label for="password">
                        Password
                    </label>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Enter your password"
                        required>

                </div>


                <div class="form-group">

                    <label for="phone">
                        Phone
                    </label>

                    <input
                        type="tel"
                        id="phone"
                        name="phone"
                        placeholder="Enter your phone number">

                </div>


                <div class="form-group">

                    <label for="address">
                        Address
                    </label>

                    <textarea
                        id="address"
                        name="address"
                        placeholder="Enter your address"
                        rows="3"></textarea>

                </div>


                <button
                    type="submit"
                    class="auth-btn">

                    Create Account

                </button>

            </form>


            <p class="auth-footer">

                Already have an account?

                <a href="${pageContext.request.contextPath}/login.jsp">
                    Login
                </a>

            </p>

        </div>

    </section>


    <footer class="footer">

        <p>
            © 2026 ShopEase. All Rights Reserved.
        </p>

    </footer>

</body>

</html>