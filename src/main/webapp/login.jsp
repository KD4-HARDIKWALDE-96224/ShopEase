<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>ShopEase - Login</title>

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

            <a href="${pageContext.request.contextPath}/register.jsp">
                Register
            </a>

        </div>

    </nav>


    <section class="auth-section">

        <div class="auth-card">

            <h1>Welcome Back</h1>

            <p class="auth-subtitle">
                Login to your ShopEase account.
            </p>


            <% if (request.getAttribute("error") != null) { %>

                <div class="auth-error">
                    <%= request.getAttribute("error") %>
                </div>

            <% } %>


            <form
                action="${pageContext.request.contextPath}/login"
                method="post">


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


                <button
                    type="submit"
                    class="auth-btn">

                    Login

                </button>

            </form>


            <p class="auth-footer">

                Don't have an account?

                <a href="${pageContext.request.contextPath}/register.jsp">
                    Create Account
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