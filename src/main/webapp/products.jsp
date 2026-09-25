<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="jakarta.tags.core"%>

<%@ taglib prefix="fmt"
    uri="jakarta.tags.fmt"%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>ShopEase - Products</title>

    <link rel="stylesheet"
        href="${pageContext.request.contextPath}/css/style.css">


    <style>

        /* =====================================================
           PRODUCTS PAGE
           ===================================================== */

        .products-page {
            background: #f5f7fb;
            min-height: calc(100vh - 280px);
            padding-bottom: 60px;
        }


        /* =====================================================
           CATEGORY BAR
           ===================================================== */

        .categories-bar a {
            transition: all 0.2s ease;
        }

        .categories-bar a:hover {
            color: #ff7900;
        }

        .categories-bar a.active {
            color: #ff7900;
            font-weight: 800;
        }


        /* =====================================================
           PRODUCTS HEADER
           ===================================================== */

        .products-header {
            max-width: 1350px;
            margin: 0 auto;
            padding: 45px 40px 25px;

            display: flex;
            justify-content: space-between;
            align-items: flex-end;

            gap: 30px;
        }


        .products-header-content {
            flex: 1;
        }


        .products-header h1 {
            margin: 0 0 8px;

            color: #172033;

            font-size: 36px;
            font-weight: 800;

            line-height: 1.2;
        }


        .products-header p {
            margin: 0;

            color: #667085;

            font-size: 16px;

            line-height: 1.6;
        }


        .products-header strong {
            color: #172033;
        }


        /* =====================================================
           CATEGORY TITLE BADGE
           ===================================================== */

        .category-label {
            display: inline-flex;

            align-items: center;
            gap: 7px;

            margin-bottom: 12px;

            padding: 7px 13px;

            background: #fff3e8;

            color: #f47700;

            border-radius: 20px;

            font-size: 13px;

            font-weight: 700;
        }


        /* =====================================================
           SORT
           ===================================================== */

        .sort-form {
            flex-shrink: 0;
        }


        .sort-select {
            min-width: 195px;

            height: 48px;

            padding: 0 15px;

            background: #ffffff;

            border: 1px solid #d9dee7;

            border-radius: 8px;

            color: #172033;

            font-size: 14px;

            font-weight: 600;

            outline: none;

            cursor: pointer;

            transition:
                border-color 0.2s ease,
                box-shadow 0.2s ease;
        }


        .sort-select:hover {
            border-color: #ff7900;
        }


        .sort-select:focus {
            border-color: #ff7900;

            box-shadow:
                0 0 0 3px rgba(255, 121, 0, 0.12);
        }


        /* =====================================================
           PRODUCTS SECTION
           ===================================================== */

        .products-section {
            max-width: 1350px;

            margin: 0 auto;

            padding: 20px 40px 60px;
        }


        /* =====================================================
           PRODUCT GRID
           ===================================================== */

        .products-section .product-grid {
            width: 100%;
        }


        /* =====================================================
           EMPTY PRODUCTS - FULL WIDTH HORIZONTAL
           ===================================================== */

        .empty-products-wrapper {

            width: 100%;

            /*
             * IMPORTANT:
             * Make the empty state span all columns
             * of the product grid.
             */
            grid-column: 1 / -1;

            display: flex;

            justify-content: center;

            align-items: center;

            padding: 25px 0 40px;
        }


        .empty-products-card {

            width: 100%;

            max-width: 1100px;

            background: #ffffff;

            border: 1px solid #e5e9f0;

            border-radius: 18px;

            padding: 30px 35px;

            box-shadow:
                0 8px 30px rgba(23, 32, 51, 0.06);

            /*
             * Horizontal layout:
             * icon on left,
             * content on right.
             */
            display: grid;

            grid-template-columns: 110px 1fr;

            column-gap: 28px;

            align-items: center;

            text-align: left;
        }


        /* =====================================================
           EMPTY ICON
           ===================================================== */

        .empty-products-icon {

            width: 88px;

            height: 88px;

            margin: 0;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #fff4e8;

            border-radius: 50%;

            font-size: 40px;

            box-shadow:
                0 8px 20px rgba(255, 121, 0, 0.10);

            /*
             * Keep the icon on the left
             * side of the card.
             */
            grid-row: 1 / span 5;
        }


        /* =====================================================
           EMPTY TITLE
           ===================================================== */

        .empty-products-card h2 {

            margin: 0 0 8px;

            color: #172033;

            font-size: 26px;

            font-weight: 800;
        }


        /* =====================================================
           EMPTY DESCRIPTION
           ===================================================== */

        .empty-products-card p {

            max-width: none;

            margin: 0 0 18px;

            color: #667085;

            font-size: 15px;

            line-height: 1.6;
        }


        .empty-products-card p strong {

            color: #172033;
        }


        /* =====================================================
           EMPTY ACTION
           ===================================================== */

        .empty-products-actions {

            display: flex;

            justify-content: flex-start;

            align-items: center;

            gap: 12px;

            margin: 0 0 18px;
        }


        .browse-products-btn {

            display: inline-flex;

            align-items: center;

            justify-content: center;

            min-width: 190px;

            padding: 12px 22px;

            background: #ff7900;

            color: #ffffff;

            border-radius: 8px;

            font-size: 14px;

            font-weight: 700;

            text-decoration: none;

            transition: all 0.2s ease;

            box-shadow:
                0 5px 15px rgba(255, 121, 0, 0.18);
        }


        .browse-products-btn:hover {

            background: #e96c00;

            color: #ffffff;

            transform: translateY(-1px);

            box-shadow:
                0 7px 18px rgba(255, 121, 0, 0.25);
        }


        /* =====================================================
           EXPLORE CATEGORIES
           ===================================================== */

        .explore-title {

            margin: 0 0 10px;

            color: #172033;

            font-size: 13px;

            font-weight: 700;
        }


        .explore-categories {

            display: flex;

            justify-content: flex-start;

            align-items: center;

            flex-wrap: wrap;

            gap: 8px;
        }


        .explore-category {

            display: inline-flex;

            align-items: center;

            justify-content: center;

            padding: 8px 13px;

            background: #f7f8fa;

            border: 1px solid #e5e7eb;

            border-radius: 20px;

            color: #475467;

            font-size: 12px;

            font-weight: 600;

            text-decoration: none;

            transition: all 0.2s ease;
        }


        .explore-category:hover {

            background: #fff3e8;

            border-color: #ffbd85;

            color: #f47700;
        }


        /* =====================================================
           PRODUCT IMAGES
           ===================================================== */

        .product-image img {

            width: 100%;

            height: 100%;

            object-fit: cover;

            display: block;

            border-radius: inherit;
        }


        /* =====================================================
           RESPONSIVE - TABLET
           ===================================================== */

        @media (max-width: 900px) {

            .products-header {

                padding: 35px 25px 20px;

                align-items: flex-start;

                flex-direction: column;
            }


            .products-section {

                padding: 15px 25px 45px;
            }


            .sort-form {

                width: 100%;
            }


            .sort-select {

                width: 100%;
            }

        }


        /* =====================================================
           RESPONSIVE - MOBILE
           ===================================================== */

        @media (max-width: 700px) {

            .empty-products-card {

                grid-template-columns: 1fr;

                text-align: center;

                padding: 35px 22px;
            }


            .empty-products-icon {

                grid-row: auto;

                margin: 0 auto 20px;
            }


            .empty-products-card h2 {

                font-size: 23px;
            }


            .empty-products-card p {

                font-size: 14px;
            }


            .empty-products-actions {

                justify-content: center;
            }


            .explore-categories {

                justify-content: center;
            }


            .browse-products-btn {

                width: 100%;
            }

        }


        @media (max-width: 600px) {

            .products-header {

                padding: 30px 18px 15px;
            }


            .products-header h1 {

                font-size: 29px;
            }


            .products-header p {

                font-size: 14px;
            }


            .products-section {

                padding: 10px 18px 40px;
            }


            .empty-products-card {

                border-radius: 14px;
            }

        }

    </style>

</head>


<body>


    <!-- ================= NAVBAR ================= -->

    <nav class="navbar">

        <div class="logo">

            Shop<span>Ease</span>

        </div>


        <!-- SEARCH BAR -->

        <form
            class="search-container"
            action="${pageContext.request.contextPath}/products"
            method="get">

            <input
                type="text"
                name="keyword"
                value="${searchKeyword}"
                placeholder="Search for products..."
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


                    <a
                        href="${pageContext.request.contextPath}/orders">

                        Orders

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/cart"
                        class="cart">

                        🛒 Cart (${cartItemCount})

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/logout">

                        Logout

                    </a>

                </c:when>


                <c:otherwise>

                    <a
                        href="${pageContext.request.contextPath}/login.jsp">

                        Login

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/register.jsp">

                        Register

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/login.jsp">

                        Orders

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/cart"
                        class="cart">

                        🛒 Cart (${cartItemCount})

                    </a>

                </c:otherwise>

            </c:choose>

        </div>

    </nav>


    <!-- ================= CATEGORY BAR ================= -->

    <div class="categories-bar">

        <a
            href="${pageContext.request.contextPath}/products"
            class="${empty selectedCategoryId ? 'active' : ''}">

            All

        </a>


        <a
            href="${pageContext.request.contextPath}/products?categoryId=1"
            class="${selectedCategoryId == 1 ? 'active' : ''}">

            Mobiles

        </a>


        <a
            href="${pageContext.request.contextPath}/products?categoryId=2"
            class="${selectedCategoryId == 2 ? 'active' : ''}">

            Laptops

        </a>


        <a
            href="${pageContext.request.contextPath}/products?categoryId=3"
            class="${selectedCategoryId == 3 ? 'active' : ''}">

            Fashion

        </a>


        <a
            href="${pageContext.request.contextPath}/products?categoryId=4"
            class="${selectedCategoryId == 4 ? 'active' : ''}">

            Accessories

        </a>


        <a
            href="${pageContext.request.contextPath}/products?categoryId=5"
            class="${selectedCategoryId == 5 ? 'active' : ''}">

            Home

        </a>


        <a
            href="${pageContext.request.contextPath}/products?categoryId=6"
            class="${selectedCategoryId == 6 ? 'active' : ''}">

            Books

        </a>


        <a
            href="${pageContext.request.contextPath}/products?categoryId=7"
            class="${selectedCategoryId == 7 ? 'active' : ''}">

            Sports

        </a>

    </div>


    <!-- ================= CATEGORY INFORMATION ================= -->

    <c:set
        var="categoryName"
        value="All Products" />

    <c:set
        var="categoryIcon"
        value="🛍️" />


    <c:choose>

        <c:when test="${selectedCategoryId == 1}">

            <c:set
                var="categoryName"
                value="Mobiles" />

            <c:set
                var="categoryIcon"
                value="📱" />

        </c:when>


        <c:when test="${selectedCategoryId == 2}">

            <c:set
                var="categoryName"
                value="Laptops" />

            <c:set
                var="categoryIcon"
                value="💻" />

        </c:when>


        <c:when test="${selectedCategoryId == 3}">

            <c:set
                var="categoryName"
                value="Fashion" />

            <c:set
                var="categoryIcon"
                value="👕" />

        </c:when>


        <c:when test="${selectedCategoryId == 4}">

            <c:set
                var="categoryName"
                value="Accessories" />

            <c:set
                var="categoryIcon"
                value="🎧" />

        </c:when>


        <c:when test="${selectedCategoryId == 5}">

            <c:set
                var="categoryName"
                value="Home" />

            <c:set
                var="categoryIcon"
                value="🏠" />

        </c:when>


        <c:when test="${selectedCategoryId == 6}">

            <c:set
                var="categoryName"
                value="Books" />

            <c:set
                var="categoryIcon"
                value="📚" />

        </c:when>


        <c:when test="${selectedCategoryId == 7}">

            <c:set
                var="categoryName"
                value="Sports" />

            <c:set
                var="categoryIcon"
                value="⚽" />

        </c:when>

    </c:choose>


    <!-- ================= PAGE HEADER ================= -->

    <section class="products-header">

        <div class="products-header-content">

            <c:choose>

                <c:when test="${not empty searchKeyword}">

                    <div class="category-label">

                        🔎 Search

                    </div>


                    <h1>

                        Search Results

                    </h1>


                    <p>

                        Showing results for

                        "<strong>${searchKeyword}</strong>"

                    </p>

                </c:when>


                <c:otherwise>

                    <c:if test="${not empty selectedCategoryId}">

                        <div class="category-label">

                            ${categoryIcon}

                            ${categoryName}

                        </div>

                    </c:if>


                    <h1>

                        ${categoryName}

                    </h1>


                    <c:choose>

                        <c:when test="${not empty selectedCategoryId}">

                            <p>

                                Explore our
                                ${categoryName}
                                collection and discover great deals.

                            </p>

                        </c:when>


                        <c:otherwise>

                            <p>

                                Explore our latest products
                                and best deals.

                            </p>

                        </c:otherwise>

                    </c:choose>

                </c:otherwise>

            </c:choose>

        </div>


        <!-- ================= SORT ================= -->

        <form
            class="sort-form"
            action="${pageContext.request.contextPath}/products"
            method="get">


            <c:if test="${not empty searchKeyword}">

                <input
                    type="hidden"
                    name="keyword"
                    value="${searchKeyword}">

            </c:if>


            <c:if test="${not empty selectedCategoryId}">

                <input
                    type="hidden"
                    name="categoryId"
                    value="${selectedCategoryId}">

            </c:if>


            <select
                class="sort-select"
                name="sort"
                onchange="this.form.submit()">


                <option value="">

                    Sort by

                </option>


                <option
                    value="priceAsc"
                    ${selectedSort == 'priceAsc' ? 'selected' : ''}>

                    Price: Low to High

                </option>


                <option
                    value="priceDesc"
                    ${selectedSort == 'priceDesc' ? 'selected' : ''}>

                    Price: High to Low

                </option>


                <option
                    value="newest"
                    ${selectedSort == 'newest' ? 'selected' : ''}>

                    Newest

                </option>

            </select>

        </form>

    </section>


    <!-- ================= PRODUCTS ================= -->

    <section class="products-page">

        <section class="products-section">

            <div class="product-grid">


                <!-- ================= NO PRODUCTS ================= -->

                <c:if test="${empty products}">

                    <div class="empty-products-wrapper">


                        <div class="empty-products-card">


                            <!-- ICON -->

                            <div class="empty-products-icon">

                                <c:choose>

                                    <c:when test="${not empty searchKeyword}">

                                        🔎

                                    </c:when>


                                    <c:otherwise>

                                        ${categoryIcon}

                                    </c:otherwise>

                                </c:choose>

                            </div>


                            <!-- TITLE -->

                            <c:choose>

                                <c:when test="${not empty searchKeyword}">

                                    <h2>

                                        No Products Found

                                    </h2>

                                </c:when>


                                <c:otherwise>

                                    <h2>

                                        No Products in
                                        ${categoryName}
                                        Yet

                                    </h2>

                                </c:otherwise>

                            </c:choose>


                            <!-- DESCRIPTION -->

                            <c:choose>

                                <c:when test="${not empty searchKeyword}">

                                    <p>

                                        We couldn't find any products
                                        matching
                                        "<strong>${searchKeyword}</strong>".

                                        Try searching with a different
                                        product name or keyword.

                                    </p>

                                </c:when>


                                <c:otherwise>

                                    <p>

                                        We don't have any products available
                                        in the
                                        <strong>${categoryName}</strong>
                                        category right now.

                                        Please explore our other categories
                                        or browse all products.

                                    </p>

                                </c:otherwise>

                            </c:choose>


                            <!-- ACTION BUTTON -->

                            <div class="empty-products-actions">

                                <a
                                    href="${pageContext.request.contextPath}/products"
                                    class="browse-products-btn">

                                    Browse All Products

                                </a>

                            </div>


                            <!-- OTHER CATEGORIES -->

                            <p class="explore-title">

                                Explore other categories

                            </p>


                            <div class="explore-categories">


                                <a
                                    href="${pageContext.request.contextPath}/products?categoryId=1"
                                    class="explore-category">

                                    📱 Mobiles

                                </a>


                                <a
                                    href="${pageContext.request.contextPath}/products?categoryId=2"
                                    class="explore-category">

                                    💻 Laptops

                                </a>


                                <a
                                    href="${pageContext.request.contextPath}/products?categoryId=4"
                                    class="explore-category">

                                    🎧 Accessories

                                </a>


                                <a
                                    href="${pageContext.request.contextPath}/products?categoryId=7"
                                    class="explore-category">

                                    ⚽ Sports

                                </a>

                            </div>

                        </div>

                    </div>

                </c:if>


                <!-- ================= PRODUCT LOOP ================= -->

                <c:forEach
                    var="product"
                    items="${products}">


                    <div class="product-card">


                        <!-- PRODUCT IMAGE -->

                        <a
                            href="${pageContext.request.contextPath}/product-details?productId=${product.productId}"
                            class="product-image">


                            <c:choose>

                                <c:when test="${product.productId == 1}">

                                    <img
                                        src="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&w=600&q=80"
                                        alt="Smartphone">

                                </c:when>


                                <c:when test="${product.productId == 2}">

                                    <img
                                        src="https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&w=600&q=80"
                                        alt="Laptop">

                                </c:when>


                                <c:when test="${product.productId == 3}">

                                    <img
                                        src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=600&q=80"
                                        alt="Wireless Headphones">

                                </c:when>


                                <c:when test="${product.productId == 4}">

                                    <img
                                        src="https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=600&q=80"
                                        alt="Running Shoes">

                                </c:when>

                            </c:choose>


                            <!-- DISCOUNT -->

                            <span class="discount-badge">

                                ${product.discount}% OFF

                            </span>

                        </a>


                        <!-- PRODUCT INFORMATION -->

                        <div class="product-info">


                            <!-- PRODUCT NAME -->

                            <h3>

                                <a
                                    href="${pageContext.request.contextPath}/product-details?productId=${product.productId}">

                                    ${product.productName}

                                </a>

                            </h3>


                            <!-- DESCRIPTION -->

                            <p class="product-description">

                                ${product.description}

                            </p>


                            <!-- PRICE -->

                            <div class="price-section">

                                <span class="product-price">

                                    ₹

                                    <fmt:formatNumber
                                        value="${product.price}"
                                        type="number"
                                        maxFractionDigits="0"/>

                                </span>

                            </div>


                            <!-- STOCK -->

                            <p class="stock">

                                <c:choose>

                                    <c:when
                                        test="${product.stockQuantity > 0}">

                                        In Stock

                                    </c:when>


                                    <c:otherwise>

                                        Out of Stock

                                    </c:otherwise>

                                </c:choose>

                            </p>


                            <!-- ADD TO CART -->

                            <form
                                action="${pageContext.request.contextPath}/add-to-cart"
                                method="post">


                                <input
                                    type="hidden"
                                    name="productId"
                                    value="${product.productId}">


                                <c:choose>

                                    <c:when
                                        test="${product.stockQuantity > 0}">

                                        <button
                                            type="submit"
                                            class="add-cart">

                                            Add to Cart

                                        </button>

                                    </c:when>


                                    <c:otherwise>

                                        <button
                                            type="button"
                                            class="add-cart"
                                            disabled>

                                            Out of Stock

                                        </button>

                                    </c:otherwise>

                                </c:choose>

                            </form>


                        </div>

                    </div>


                </c:forEach>

            </div>

        </section>

    </section>


    <!-- ================= FOOTER ================= -->

    <footer class="footer">

        <p>

            © 2026 ShopEase. All Rights Reserved.

        </p>

    </footer>


</body>

</html>