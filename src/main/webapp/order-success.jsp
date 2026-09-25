<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>ShopEase - Order Successful</title>

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

            <a href="${pageContext.request.contextPath}/orders">
                Orders
            </a>

            <a href="${pageContext.request.contextPath}/logout">
                Logout
            </a>

        </div>

    </nav>


    <section class="order-success-section">

        <div class="order-success-card">

            <div class="success-icon">
                ✓
            </div>

            <h1>
                Order Placed Successfully!
            </h1>

            <p>
                Thank you for shopping with ShopEase.
            </p>

            <p class="order-number">

                Your Order ID:

                <strong>
                    #${sessionScope.lastOrderId}
                </strong>

            </p>

            <div class="success-actions">

                <a
                    href="${pageContext.request.contextPath}/products"
                    class="continue-shopping-btn">

                    Continue Shopping

                </a>

                <a
                    href="${pageContext.request.contextPath}/orders"
                    class="view-orders-btn">

                    View Orders

                </a>

            </div>

        </div>

    </section>


    <footer class="footer">

        <p>
            © 2026 ShopEase. All Rights Reserved.
        </p>

    </footer>

</body>

</html>