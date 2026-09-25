<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Order Details - ShopEase</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f3f6fa;
            color: #14213d;
        }

        .container {
            width: 90%;
            max-width: 1400px;
            margin: 40px auto;
        }

        .section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        h1 {
            margin-top: 0;
            margin-bottom: 30px;
            font-size: 30px;
        }

        h2 {
            margin-top: 0;
            margin-bottom: 25px;
            font-size: 26px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .info-box {
            background: #f7f9fc;
            padding: 22px;
            border-radius: 10px;
        }

        .label {
            display: block;
            color: #64748b;
            font-size: 15px;
            margin-bottom: 8px;
        }

        .value {
            font-size: 18px;
            font-weight: 600;
            color: #14213d;
            word-break: break-word;
        }

        .status {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
            color: #155724;
            background: #d4edda;
        }

        .payment-paid {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
            color: #155724;
            background: #d4edda;
        }

        .payment-pending {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
            color: #856404;
            background: #fff3cd;
        }

        .payment-failed {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
            color: #721c24;
            background: #f8d7da;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #f1f3f5;
            text-align: left;
            padding: 17px;
            font-size: 16px;
        }

        td {
            padding: 17px;
            border-bottom: 1px solid #e5e7eb;
            font-size: 16px;
        }

        .total {
            font-weight: bold;
        }

        .back-btn {
            display: inline-block;
            text-decoration: none;
            background: #ff8c00;
            color: white;
            padding: 12px 22px;
            border-radius: 8px;
            font-weight: bold;
            margin-top: 5px;
        }

        .back-btn:hover {
            background: #e67e00;
        }

        @media (max-width: 768px) {

            .container {
                width: 95%;
                margin: 20px auto;
            }

            .section {
                padding: 20px;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            h1 {
                font-size: 25px;
            }

            h2 {
                font-size: 22px;
            }
        }

    </style>

</head>

<body>

<div class="container">

    <!-- ================= ORDER INFORMATION ================= -->

    <div class="section">

        <h1>Order Information</h1>

        <div class="info-grid">

            <div class="info-box">

                <span class="label">
                    Order ID
                </span>

                <span class="value">
                    #${order.orderId}
                </span>

            </div>


            <div class="info-box">

                <span class="label">
                    User ID
                </span>

                <span class="value">
                    ${order.userId}
                </span>

            </div>


            <div class="info-box">

                <span class="label">
                    Total Amount
                </span>

                <span class="value">
                    ₹ ${order.totalAmount}
                </span>

            </div>


            <div class="info-box">

                <span class="label">
                    Order Status
                </span>

                <span class="status">
                    ${order.orderStatus}
                </span>

            </div>


            <div class="info-box">

                <span class="label">
                    Shipping Address
                </span>

                <span class="value">
                    ${order.shippingAddress}
                </span>

            </div>


            <div class="info-box">

                <span class="label">
                    Order Date
                </span>

                <span class="value">
                    ${order.orderDate}
                </span>

            </div>

        </div>

    </div>


    <!-- ================= PAYMENT INFORMATION ================= -->

    <div class="section">

        <h2>Payment Information</h2>

        <div class="info-grid">

            <div class="info-box">

                <span class="label">
                    Payment Status
                </span>

                <c:choose>

                    <c:when test="${order.paymentStatus == 'PAID'}">

                        <span class="payment-paid">
                            PAID
                        </span>

                    </c:when>

                    <c:when test="${order.paymentStatus == 'FAILED'}">

                        <span class="payment-failed">
                            FAILED
                        </span>

                    </c:when>

                    <c:otherwise>

                        <span class="payment-pending">
                            ${order.paymentStatus}
                        </span>

                    </c:otherwise>

                </c:choose>

            </div>


            <div class="info-box">

                <span class="label">
                    Razorpay Order ID
                </span>

                <span class="value">
                    ${order.razorpayOrderId}
                </span>

            </div>


            <div class="info-box">

                <span class="label">
                    Razorpay Payment ID
                </span>

                <span class="value">
                    ${order.razorpayPaymentId}
                </span>

            </div>

        </div>

    </div>


    <!-- ================= ORDER ITEMS ================= -->

    <div class="section">

        <h2>Order Items</h2>

        <div class="table-wrapper">

            <table>

                <thead>

                    <tr>

                        <th>
                            Product
                        </th>

                        <th>
                            Quantity
                        </th>

                        <th>
                            Price
                        </th>

                        <th>
                            Total
                        </th>

                    </tr>

                </thead>

                <tbody>

                    <c:forEach
                        var="item"
                        items="${orderItems}">

                        <tr>

                            <td>
                                ${item.productName}
                            </td>

                            <td>
                                ${item.quantity}
                            </td>

                            <td>
                                ₹ ${item.price}
                            </td>

                            <td class="total">
                                ₹ ${item.price * item.quantity}
                            </td>

                        </tr>

                    </c:forEach>

                </tbody>

            </table>

        </div>

    </div>


    <!-- ================= BACK BUTTON ================= -->

    <a
        href="${pageContext.request.contextPath}/admin/orders"
        class="back-btn">

        ← Back to Orders

    </a>

</div>

</body>

</html>