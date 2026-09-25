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

    <title>Shopping Cart - ShopEase</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>


<nav class="navbar">

    <div class="logo">
        Shop<span>Ease</span>
    </div>


    <div class="nav-actions">

        <span class="welcome-user">
            Hello, ${sessionScope.loggedInUser.fullName}
        </span>


        <a href="${pageContext.request.contextPath}/products">
            Products
        </a>


        <a href="${pageContext.request.contextPath}/orders">
            Orders
        </a>


        <a href="${pageContext.request.contextPath}/cart"
           class="cart">

            🛒 Cart (${cartItemCount})

        </a>


        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </div>

</nav>


<section class="cart-section">

    <div class="cart-container">


        <h1>Your Shopping Cart</h1>

        <p class="cart-subtitle">
            Review your items before checkout.
        </p>


        <c:if test="${not empty error}">

            <div class="cart-error">
                ${error}
            </div>

        </c:if>


        <c:if test="${not empty sessionScope.cartError}">

            <div class="cart-error">
                ${sessionScope.cartError}
            </div>

            <c:remove
                var="cartError"
                scope="session"/>

        </c:if>


        <c:choose>


            <c:when test="${empty cart}">

                <div class="empty-cart">

                    <div class="empty-cart-icon">
                        🛒
                    </div>

                    <h2>Your Cart is Empty</h2>

                    <p>
                        You haven't added any products to your cart yet.
                    </p>

                    <a
                        href="${pageContext.request.contextPath}/products"
                        class="continue-shopping-btn">

                        Continue Shopping

                    </a>

                </div>

            </c:when>


            <c:otherwise>

                <div class="cart-content">


                    <div class="cart-items">


                        <c:forEach
                            var="item"
                            items="${cart}">


                            <div class="cart-item">


                                <div class="cart-item-image">

                                    <c:choose>

                                        <c:when
                                            test="${item.product.productId == 1}">

                                            <img
                                                src="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&w=300&q=80"
                                                alt="Smartphone">

                                        </c:when>


                                        <c:when
                                            test="${item.product.productId == 2}">

                                            <img
                                                src="https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&w=300&q=80"
                                                alt="Laptop">

                                        </c:when>


                                        <c:when
                                            test="${item.product.productId == 3}">

                                            <img
                                                src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=300&q=80"
                                                alt="Wireless Headphones">

                                        </c:when>


                                        <c:when
                                            test="${item.product.productId == 4}">

                                            <img
                                                src="https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=300&q=80"
                                                alt="Running Shoes">

                                        </c:when>

                                    </c:choose>

                                </div>


                                <div class="cart-item-info">

                                    <h3>
                                        ${item.product.productName}
                                    </h3>

                                    <p>
                                        ${item.product.description}
                                    </p>

                                    <div class="cart-item-price">

                                        ₹

                                        <fmt:formatNumber
                                            value="${item.product.price}"
                                            type="number"
                                            minFractionDigits="2"
                                            maxFractionDigits="2"/>

                                    </div>

                                </div>


                                <div class="cart-quantity">


                                    <form
                                        action="${pageContext.request.contextPath}/update-cart"
                                        method="post">

                                        <input
                                            type="hidden"
                                            name="productId"
                                            value="${item.product.productId}">

                                        <input
                                            type="hidden"
                                            name="action"
                                            value="decrease">

                                        <button
                                            type="submit"
                                            class="quantity-btn">

                                            −

                                        </button>

                                    </form>


                                    <span class="quantity">
                                        ${item.quantity}
                                    </span>


                                    <form
                                        action="${pageContext.request.contextPath}/update-cart"
                                        method="post">

                                        <input
                                            type="hidden"
                                            name="productId"
                                            value="${item.product.productId}">

                                        <input
                                            type="hidden"
                                            name="action"
                                            value="increase">

                                        <button
                                            type="submit"
                                            class="quantity-btn">

                                            +

                                        </button>

                                    </form>


                                </div>


                                <div class="cart-item-total">

                                    ₹

                                    <fmt:formatNumber
                                        value="${item.totalPrice}"
                                        type="number"
                                        minFractionDigits="2"
                                        maxFractionDigits="2"/>

                                </div>


                                <form
                                    action="${pageContext.request.contextPath}/update-cart"
                                    method="post">

                                    <input
                                        type="hidden"
                                        name="productId"
                                        value="${item.product.productId}">

                                    <input
                                        type="hidden"
                                        name="action"
                                        value="remove">

                                    <button
                                        type="submit"
                                        class="remove-btn">

                                        Remove

                                    </button>

                                </form>


                            </div>


                        </c:forEach>


                    </div>


                    <div class="cart-summary">


                        <h2>
                            Order Summary
                        </h2>


                        <div class="summary-row">

                            <span>
                                Items
                            </span>

                            <span>
                                ${cartItemCount}
                            </span>

                        </div>


                        <div class="summary-row">

                            <span>
                                Subtotal
                            </span>

                            <span>

                                ₹

                                <fmt:formatNumber
                                    value="${cartTotal}"
                                    type="number"
                                    minFractionDigits="2"
                                    maxFractionDigits="2"/>

                            </span>

                        </div>


                        <div class="summary-row">

                            <span>
                                Shipping
                            </span>

                            <span>
                                Free
                            </span>

                        </div>


                        <div class="summary-divider">
                        </div>


                        <div class="summary-total">

                            <span>
                                Total
                            </span>

                            <strong>

                                ₹

                                <fmt:formatNumber
                                    value="${cartTotal}"
                                    type="number"
                                    minFractionDigits="2"
                                    maxFractionDigits="2"/>

                            </strong>

                        </div>


                        <a
                            href="${pageContext.request.contextPath}/checkout.jsp"
                            class="checkout-btn">

                            Proceed to Checkout

                        </a>


                    </div>


                </div>

            </c:otherwise>


        </c:choose>


    </div>

</section>


<footer class="footer">

    <p>
        © 2026 ShopEase. All Rights Reserved.
    </p>

</footer>


</body>

</html>