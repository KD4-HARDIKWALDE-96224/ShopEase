<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>ShopEase - Online Shopping</title>

    <link rel="stylesheet"
        href="${pageContext.request.contextPath}/css/style.css">

    <style>

        /* Product image container */
        .product-image {
            display: block;
            overflow: hidden;
        }

        /* Real product images */
        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

    </style>

</head>

<body>

    <!-- ================= NAVBAR ================= -->

    <nav class="navbar">

        <div class="logo">
            Shop<span>Ease</span>
        </div>


        <!-- SEARCH -->

        <form
            class="search-container"
            action="${pageContext.request.contextPath}/products"
            method="get">

            <input
                type="text"
                name="keyword"
                placeholder="Search for products, brands and more..."
                autocomplete="off">

            <button type="submit">
                🔍
            </button>

        </form>


        <!-- NAVIGATION -->

        <div class="nav-actions">

            <c:choose>

                <c:when test="${not empty sessionScope.loggedInUser}">

                    <span class="welcome-user">
                        Hello,
                        ${sessionScope.loggedInUser.fullName}
                    </span>

                    <a href="${pageContext.request.contextPath}/products">
                        Products
                    </a>

                    <a href="${pageContext.request.contextPath}/orders">
                        Orders
                    </a>

                    <a
                        href="${pageContext.request.contextPath}/cart"
                        class="cart">

                        🛒 Cart

                        <c:choose>

                            <c:when test="${not empty sessionScope.cart}">

                                (

                                <c:set
                                    var="homeCartCount"
                                    value="0" />

                                <c:forEach
                                    var="cartItem"
                                    items="${sessionScope.cart}">

                                    <c:set
                                        var="homeCartCount"
                                        value="${homeCartCount + cartItem.quantity}" />

                                </c:forEach>

                                ${homeCartCount}

                                )

                            </c:when>

                            <c:otherwise>
                                (0)
                            </c:otherwise>

                        </c:choose>

                    </a>

                    <a href="${pageContext.request.contextPath}/logout">
                        Logout
                    </a>

                </c:when>


                <c:otherwise>

                    <a href="${pageContext.request.contextPath}/login.jsp">
                        Login
                    </a>

                    <a href="${pageContext.request.contextPath}/register.jsp">
                        Register
                    </a>

                    <a href="${pageContext.request.contextPath}/login.jsp">
                        Orders
                    </a>

                    <a
                        href="${pageContext.request.contextPath}/cart"
                        class="cart">

                        🛒 Cart (0)

                    </a>

                </c:otherwise>

            </c:choose>

        </div>

    </nav>


    <!-- ================= CATEGORY BAR ================= -->

    <div class="categories-bar">

        <a href="${pageContext.request.contextPath}/products">
            Electronics
        </a>

        <a href="${pageContext.request.contextPath}/products?categoryId=1">
            Mobiles
        </a>

        <a href="${pageContext.request.contextPath}/products?categoryId=2">
            Laptops
        </a>

        <a href="${pageContext.request.contextPath}/products?categoryId=3">
            Fashion
        </a>

        <a href="${pageContext.request.contextPath}/products?categoryId=5">
            Home
        </a>

        <a href="${pageContext.request.contextPath}/products?categoryId=6">
            Books
        </a>

        <a href="${pageContext.request.contextPath}/products?categoryId=7">
            Sports
        </a>

    </div>


    <!-- ================= HERO ================= -->

    <section class="hero">

        <div class="hero-content">

            <div class="hero-small">
                Summer Mega Sale
            </div>

            <h1>
                Everything you need.
                <span>
                    All in one place.
                </span>
            </h1>

            <p>
                Discover premium products, amazing deals
                and a shopping experience designed for you.
            </p>


            <div class="hero-buttons">

                <a
                    href="${pageContext.request.contextPath}/products"
                    class="btn-primary">

                    Shop Now

                </a>


                <a
                    href="${pageContext.request.contextPath}/products?sort=priceAsc"
                    class="btn-secondary">

                    Explore Deals

                </a>

            </div>

        </div>


        <div class="hero-product">
            🛍️
        </div>

    </section>


    <!-- ================= FEATURES ================= -->

    <div class="features">

        <div class="feature">

            <div class="feature-icon">
                🚚
            </div>

            <div>

                <h3>
                    Free Delivery
                </h3>

                <p>
                    On orders above ₹499
                </p>

            </div>

        </div>


        <div class="feature">

            <div class="feature-icon">
                🔒
            </div>

            <div>

                <h3>
                    Secure Payment
                </h3>

                <p>
                    100% secure checkout
                </p>

            </div>

        </div>


        <div class="feature">

            <div class="feature-icon">
                🔄
            </div>

            <div>

                <h3>
                    Easy Returns
                </h3>

                <p>
                    7 days return policy
                </p>

            </div>

        </div>


        <div class="feature">

            <div class="feature-icon">
                🎧
            </div>

            <div>

                <h3>
                    24/7 Support
                </h3>

                <p>
                    We're here to help
                </p>

            </div>

        </div>

    </div>


    <!-- ================= CATEGORIES ================= -->

    <section class="section">

        <div class="section-heading">

            <h2>
                Shop by Category
            </h2>

            <a
                href="${pageContext.request.contextPath}/products">

                View All →

            </a>

        </div>


        <div class="category-grid">


            <a
                href="${pageContext.request.contextPath}/products?categoryId=1"
                class="category-card">

                <div class="category-icon">
                    📱
                </div>

                <h3>
                    Mobiles
                </h3>

            </a>


            <a
                href="${pageContext.request.contextPath}/products?categoryId=2"
                class="category-card">

                <div class="category-icon">
                    💻
                </div>

                <h3>
                    Laptops
                </h3>

            </a>


            <a
                href="${pageContext.request.contextPath}/products?categoryId=3"
                class="category-card">

                <div class="category-icon">
                    👕
                </div>

                <h3>
                    Fashion
                </h3>

            </a>


            <a
                href="${pageContext.request.contextPath}/products?categoryId=4"
                class="category-card">

                <div class="category-icon">
                    🎧
                </div>

                <h3>
                    Accessories
                </h3>

            </a>


            <a
                href="${pageContext.request.contextPath}/products?categoryId=5"
                class="category-card">

                <div class="category-icon">
                    🏠
                </div>

                <h3>
                    Home
                </h3>

            </a>


            <a
                href="${pageContext.request.contextPath}/products?categoryId=6"
                class="category-card">

                <div class="category-icon">
                    📚
                </div>

                <h3>
                    Books
                </h3>

            </a>

        </div>

    </section>


    <!-- ================= PRODUCTS ================= -->

    <section class="section">

        <div class="section-heading">

            <h2>
                Trending Products
            </h2>

            <a
                href="${pageContext.request.contextPath}/products">

                View All →

            </a>

        </div>


        <div class="product-grid">


            <!-- PRODUCT 1 : SMARTPHONE -->

            <div class="product-card">

                <a
                    href="${pageContext.request.contextPath}/product-details?productId=1"
                    class="product-image">

                    <img
                        src="https://images.unsplash.com/photo-1767978139637-fe09cbcd13fc?auto=format&fit=crop&w=800&q=80"
                        alt="Smartphone Pro">

                </a>


                <div class="product-info">

                    <h3>

                        <a
                            href="${pageContext.request.contextPath}/product-details?productId=1">

                            Smartphone Pro

                        </a>

                    </h3>


                    <div class="rating">
                        ★★★★★
                    </div>


                    <span class="price">
                        ₹29,999
                    </span>

                    <span class="old-price">
                        ₹34,999
                    </span>

                    <span class="discount">
                        14% OFF
                    </span>


                    <form
                        action="${pageContext.request.contextPath}/add-to-cart"
                        method="post">

                        <input
                            type="hidden"
                            name="productId"
                            value="1">

                        <button
                            type="submit"
                            class="add-cart">

                            Add to Cart

                        </button>

                    </form>

                </div>

            </div>


            <!-- PRODUCT 2 : LAPTOP -->

            <div class="product-card">

                <a
                    href="${pageContext.request.contextPath}/product-details?productId=2"
                    class="product-image">

                    <img
                        src="https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&w=800&q=80"
                        alt="Ultra Laptop">

                </a>


                <div class="product-info">

                    <h3>

                        <a
                            href="${pageContext.request.contextPath}/product-details?productId=2">

                            Ultra Laptop

                        </a>

                    </h3>


                    <div class="rating">
                        ★★★★☆
                    </div>


                    <span class="price">
                        ₹59,999
                    </span>

                    <span class="old-price">
                        ₹69,999
                    </span>

                    <span class="discount">
                        14% OFF
                    </span>


                    <form
                        action="${pageContext.request.contextPath}/add-to-cart"
                        method="post">

                        <input
                            type="hidden"
                            name="productId"
                            value="2">

                        <button
                            type="submit"
                            class="add-cart">

                            Add to Cart

                        </button>

                    </form>

                </div>

            </div>


            <!-- PRODUCT 3 : HEADPHONES -->

            <div class="product-card">

                <a
                    href="${pageContext.request.contextPath}/product-details?productId=3"
                    class="product-image">

                    <img
                        src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=800&q=80"
                        alt="Wireless Headphones">

                </a>


                <div class="product-info">

                    <h3>

                        <a
                            href="${pageContext.request.contextPath}/product-details?productId=3">

                            Wireless Headphones

                        </a>

                    </h3>


                    <div class="rating">
                        ★★★★★
                    </div>


                    <span class="price">
                        ₹2,499
                    </span>

                    <span class="old-price">
                        ₹3,999
                    </span>

                    <span class="discount">
                        37% OFF
                    </span>


                    <form
                        action="${pageContext.request.contextPath}/add-to-cart"
                        method="post">

                        <input
                            type="hidden"
                            name="productId"
                            value="3">

                        <button
                            type="submit"
                            class="add-cart">

                            Add to Cart

                        </button>

                    </form>

                </div>

            </div>


            <!-- PRODUCT 4 : RUNNING SHOES -->

            <div class="product-card">

                <a
                    href="${pageContext.request.contextPath}/product-details?productId=4"
                    class="product-image">

                    <img
                        src="https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=800&q=80"
                        alt="Running Shoes">

                </a>


                <div class="product-info">

                    <h3>

                        <a
                            href="${pageContext.request.contextPath}/product-details?productId=4">

                            Running Shoes

                        </a>

                    </h3>


                    <div class="rating">
                        ★★★★☆
                    </div>


                    <span class="price">
                        ₹1,999
                    </span>

                    <span class="old-price">
                        ₹2,999
                    </span>

                    <span class="discount">
                        33% OFF
                    </span>


                    <form
                        action="${pageContext.request.contextPath}/add-to-cart"
                        method="post">

                        <input
                            type="hidden"
                            name="productId"
                            value="4">

                        <button
                            type="submit"
                            class="add-cart">

                            Add to Cart

                        </button>

                    </form>

                </div>

            </div>


        </div>

    </section>


    <!-- ================= NEWSLETTER ================= -->

    <section class="newsletter">

        <h2>
            Stay Updated
        </h2>

        <p>
            Subscribe to get updates about new products
            and exclusive offers.
        </p>


        <form
            action="#"
            method="post"
            onsubmit="return false;">

            <input
                type="email"
                id="email"
                placeholder="Enter your email address">

            <button
                type="button"
                onclick="subscribe()">

                Subscribe

            </button>

        </form>

    </section>


    <!-- ================= FOOTER ================= -->

    <footer class="footer">

        <div class="footer-grid">


            <div>

                <h3>
                    ShopEase
                </h3>

                <p>
                    Your trusted destination for
                    quality products and great deals.
                </p>

            </div>


            <div>

                <h3>
                    Quick Links
                </h3>

                <a
                    href="${pageContext.request.contextPath}/">

                    Home

                </a>

                <a
                    href="${pageContext.request.contextPath}/products">

                    Products

                </a>

                <a
                    href="${pageContext.request.contextPath}/login.jsp">

                    About Us

                </a>

                <a
                    href="${pageContext.request.contextPath}/login.jsp">

                    Contact

                </a>

            </div>


            <div>

                <h3>
                    Customer Service
                </h3>

                <a
                    href="${pageContext.request.contextPath}/products">

                    FAQ

                </a>

                <a
                    href="${pageContext.request.contextPath}/products">

                    Shipping

                </a>

                <a
                    href="${pageContext.request.contextPath}/products">

                    Returns

                </a>

                <a
                    href="${pageContext.request.contextPath}/products">

                    Privacy Policy

                </a>

            </div>


            <div>

                <h3>
                    Follow Us
                </h3>

                <a href="#">
                    Instagram
                </a>

                <a href="#">
                    Facebook
                </a>

                <a href="#">
                    LinkedIn
                </a>

                <a href="#">
                    YouTube
                </a>

            </div>


        </div>


        <div class="copyright">

            © 2026 ShopEase. All Rights Reserved.

        </div>

    </footer>


</body>

</html>