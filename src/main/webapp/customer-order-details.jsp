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

    <title>Order Details - ShopEase</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        .order-details-page {
            padding: 40px 20px;
        }

        .order-details-container {
            max-width: 1000px;
            margin: 0 auto;
        }

        .order-details-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .order-details-header h1 {
            margin: 0;
        }

        .back-orders-btn {
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 6px;
        }

        .order-info-card {
            margin-bottom: 25px;
        }

        .payment-info-card {
            margin-bottom: 25px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .info-item {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .info-item span {
            font-size: 14px;
            color: #777;
        }

        .info-item strong {
            word-break: break-word;
        }

        .payment-status-paid {
            color: green;
        }

        .payment-status-failed {
            color: red;
        }

        .payment-status-pending {
            color: orange;
        }

        .order-products {
            margin-top: 25px;
        }

        .product-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 18px 0;
            border-bottom: 1px solid #eee;
        }

        .product-info {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .product-price {
            text-align: right;
        }

        .order-total {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 20px;
            font-size: 20px;
        }

        .order-progress {
            display: flex;
            align-items: flex-start;
            width: 100%;
            margin-top: 30px;
        }

        .progress-step {
            flex: 1;
            text-align: center;
        }

        .progress-icon {
            font-size: 30px;
            margin-bottom: 8px;
        }

        .progress-step strong {
            display: block;
        }

        .progress-check {
            color: green;
            margin-top: 5px;
            font-size: 18px;
        }

        .progress-line {
            flex: 1;
            border-top: 2px solid #ddd;
            margin-top: 15px;
        }

        .cancelled-order {
            text-align: center;
            padding: 20px;
        }

        .cancelled-order-icon {
            font-size: 40px;
        }

        .cancelled-order h3 {
            color: red;
        }

        .cancel-order-container {
            margin-top: 25px;
            text-align: right;
        }

        .cancel-order-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
        }

        .cancel-order-btn:hover {
            opacity: 0.9;
        }

        @media (max-width: 768px) {

            .order-details-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .product-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .product-price {
                text-align: left;
            }

            .order-progress {
                flex-direction: column;
                align-items: stretch;
                gap: 10px;
            }

            .progress-step {
                text-align: left;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .progress-icon {
                margin-bottom: 0;
            }

            .progress-check {
                margin-top: 0;
            }

            .progress-line {
                display: none;
            }

            .cancel-order-container {
                text-align: left;
            }

        }

    </style>

</head>

<body>


<nav class="navbar">

    <div class="logo">

        Shop<span>Ease</span>

    </div>


    <div class="nav-actions">

        <span class="welcome-user">

            Hello,
            ${sessionScope.loggedInUser.fullName}

        </span>


        <a href="${pageContext.request.contextPath}/products">
            Products
        </a>


        <a href="${pageContext.request.contextPath}/cart"
           class="cart">

            🛒 Cart

        </a>


        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </div>

</nav>


<section class="order-details-page">

    <div class="order-details-container">


        <div class="order-details-header">

            <h1>
                Order #${orderDetails.order.orderId}
            </h1>


            <a
                href="${pageContext.request.contextPath}/orders"
                class="continue-shopping-btn back-orders-btn">

                ← Back to My Orders

            </a>

        </div>


        <!-- Order Information -->

        <div class="order-card order-info-card">

            <h2>
                Order Information
            </h2>


            <div class="info-grid">


                <div class="info-item">

                    <span>
                        Order ID
                    </span>

                    <strong>
                        #${orderDetails.order.orderId}
                    </strong>

                </div>


                <div class="info-item">

                    <span>
                        Order Status
                    </span>

                    <strong>

                        <c:choose>

                            <c:when test="${orderDetails.order.orderStatus == 'PLACED'}">

                                <span style="color: orange;">
                                    PLACED
                                </span>

                            </c:when>


                            <c:when test="${orderDetails.order.orderStatus == 'CONFIRMED'}">

                                <span style="color: blue;">
                                    CONFIRMED
                                </span>

                            </c:when>


                            <c:when test="${orderDetails.order.orderStatus == 'SHIPPED'}">

                                <span style="color: #6f42c1;">
                                    SHIPPED
                                </span>

                            </c:when>


                            <c:when test="${orderDetails.order.orderStatus == 'DELIVERED'}">

                                <span style="color: green;">
                                    DELIVERED
                                </span>

                            </c:when>


                            <c:when test="${orderDetails.order.orderStatus == 'CANCELLED'}">

                                <span style="color: red;">
                                    CANCELLED
                                </span>

                            </c:when>


                            <c:otherwise>

                                ${orderDetails.order.orderStatus}

                            </c:otherwise>

                        </c:choose>

                    </strong>

                </div>


                <div class="info-item">

                    <span>
                        Order Date
                    </span>

                    <strong>
                        ${orderDetails.order.orderDate}
                    </strong>

                </div>


                <div class="info-item">

                    <span>
                        Total Amount
                    </span>

                    <strong>

                        ₹

                        <fmt:formatNumber
                            value="${orderDetails.order.totalAmount}"
                            type="number"
                            minFractionDigits="2"
                            maxFractionDigits="2"/>

                    </strong>

                </div>


                <div class="info-item">

                    <span>
                        Shipping Address
                    </span>

                    <strong>
                        ${orderDetails.order.shippingAddress}
                    </strong>

                </div>

            </div>


            <!-- Cancel Order -->

            <c:if test="${orderDetails.order.orderStatus == 'PLACED'}">

                <div class="cancel-order-container">

                    <form
                        action="${pageContext.request.contextPath}/cancel-order"
                        method="post"
                        onsubmit="return confirm('Are you sure you want to cancel this order?');">

                        <input
                            type="hidden"
                            name="orderId"
                            value="${orderDetails.order.orderId}">

                        <button
                            type="submit"
                            class="cancel-order-btn">

                            Cancel Order

                        </button>

                    </form>

                </div>

            </c:if>


        </div>


        <!-- Order Progress -->

        <div class="order-card">

            <h2>
                Order Progress
            </h2>


            <c:choose>


                <c:when test="${orderDetails.order.orderStatus == 'CANCELLED'}">

                    <div class="cancelled-order">

                        <div class="cancelled-order-icon">
                            ❌
                        </div>

                        <h3>
                            Order Cancelled
                        </h3>

                        <p>
                            This order has been cancelled.
                        </p>

                    </div>

                </c:when>


                <c:otherwise>

                    <div class="order-progress">


                        <!-- Placed -->

                        <div class="progress-step">

                            <div class="progress-icon">
                                📦
                            </div>

                            <strong>
                                Placed
                            </strong>

                            <c:if test="${orderDetails.order.orderStatus == 'PLACED'
                                || orderDetails.order.orderStatus == 'CONFIRMED'
                                || orderDetails.order.orderStatus == 'SHIPPED'
                                || orderDetails.order.orderStatus == 'DELIVERED'}">

                                <div class="progress-check">
                                    ✓
                                </div>

                            </c:if>

                        </div>


                        <div class="progress-line"></div>


                        <!-- Confirmed -->

                        <div class="progress-step">

                            <div class="progress-icon">
                                ✅
                            </div>

                            <strong>
                                Confirmed
                            </strong>

                            <c:if test="${orderDetails.order.orderStatus == 'CONFIRMED'
                                || orderDetails.order.orderStatus == 'SHIPPED'
                                || orderDetails.order.orderStatus == 'DELIVERED'}">

                                <div class="progress-check">
                                    ✓
                                </div>

                            </c:if>

                        </div>


                        <div class="progress-line"></div>


                        <!-- Shipped -->

                        <div class="progress-step">

                            <div class="progress-icon">
                                🚚
                            </div>

                            <strong>
                                Shipped
                            </strong>

                            <c:if test="${orderDetails.order.orderStatus == 'SHIPPED'
                                || orderDetails.order.orderStatus == 'DELIVERED'}">

                                <div class="progress-check">
                                    ✓
                                </div>

                            </c:if>

                        </div>


                        <div class="progress-line"></div>


                        <!-- Delivered -->

                        <div class="progress-step">

                            <div class="progress-icon">
                                🏠
                            </div>

                            <strong>
                                Delivered
                            </strong>

                            <c:if test="${orderDetails.order.orderStatus == 'DELIVERED'}">

                                <div class="progress-check">
                                    ✓
                                </div>

                            </c:if>

                        </div>


                    </div>

                </c:otherwise>


            </c:choose>

        </div>


        <!-- Payment Information -->

        <div class="order-card payment-info-card">

            <h2>
                Payment Information
            </h2>


            <div class="info-grid">


                <div class="info-item">

                    <span>
                        Payment Status
                    </span>

                    <strong>

                        <c:choose>

                            <c:when test="${orderDetails.order.paymentStatus == 'PAID'}">

                                <span class="payment-status-paid">
                                    PAID
                                </span>

                            </c:when>


                            <c:when test="${orderDetails.order.paymentStatus == 'FAILED'}">

                                <span class="payment-status-failed">
                                    FAILED
                                </span>

                            </c:when>


                            <c:otherwise>

                                <span class="payment-status-pending">
                                    ${orderDetails.order.paymentStatus}
                                </span>

                            </c:otherwise>

                        </c:choose>

                    </strong>

                </div>


                <div class="info-item">

                    <span>
                        Razorpay Order ID
                    </span>

                    <strong>
                        ${orderDetails.order.razorpayOrderId}
                    </strong>

                </div>


                <div class="info-item">

                    <span>
                        Razorpay Payment ID
                    </span>

                    <strong>
                        ${orderDetails.order.razorpayPaymentId}
                    </strong>

                </div>

            </div>

        </div>


        <!-- Ordered Products -->

        <div class="order-card order-products">

            <h2>
                Ordered Products
            </h2>


            <c:forEach
                var="item"
                items="${orderDetails.items}">


                <div class="product-row">


                    <div class="product-info">

                        <strong>
                            ${item.productName}
                        </strong>

                        <span>
                            Quantity: ${item.quantity}
                        </span>

                    </div>


                    <div class="product-price">

                        ₹

                        <fmt:formatNumber
                            value="${item.price}"
                            type="number"
                            minFractionDigits="2"
                            maxFractionDigits="2"/>

                        × ${item.quantity}

                    </div>


                </div>


            </c:forEach>


            <div class="order-total">

                <span>
                    Total:
                </span>

                <strong>

                    ₹

                    <fmt:formatNumber
                        value="${orderDetails.order.totalAmount}"
                        type="number"
                        minFractionDigits="2"
                        maxFractionDigits="2"/>

                </strong>

            </div>


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