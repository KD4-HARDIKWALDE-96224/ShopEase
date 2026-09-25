<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Manage Orders - ShopEase</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #222;
        }

        .navbar {
            background: #1f2937;
            color: white;
            padding: 18px 40px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar h2 {
            margin: 0;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
        }

        .container {
            width: 95%;
            margin: 40px auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .header h1 {
            margin: 0;
        }

        .back-btn {
            background: #6b7280;
            color: white;
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 6px;
        }

        .table-container {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th,
        td {
            padding: 14px 12px;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }

        th {
            background: #f3f4f6;
            font-weight: bold;
        }

        tr:hover {
            background: #f9fafb;
        }

        select {
            padding: 7px 10px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            background: white;
            cursor: pointer;
            font-size: 14px;
        }

        select:focus {
            outline: none;
            border-color: #2563eb;
        }

        .view-btn {
            display: inline-block;
            padding: 7px 12px;
            background: #2563eb;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
        }

        .view-btn:hover {
            background: #1d4ed8;
        }

        .empty {
            text-align: center;
            padding: 40px;
            color: #6b7280;
        }

    </style>

</head>

<body>

    <div class="navbar">

        <h2>ShopEase Admin</h2>

        <div class="nav-links">

            <a href="${pageContext.request.contextPath}/admin/dashboard">
                Dashboard
            </a>

            <a href="${pageContext.request.contextPath}/products">
                View Store
            </a>

            <a href="${pageContext.request.contextPath}/logout">
                Logout
            </a>

        </div>

    </div>


    <div class="container">

        <div class="header">

            <h1>Manage Orders</h1>

            <a
                href="${pageContext.request.contextPath}/admin/dashboard"
                class="back-btn">
                Back to Dashboard
            </a>

        </div>


        <div class="table-container">

            <c:choose>

                <c:when test="${not empty orders}">

                    <table>

                        <thead>

                            <tr>

                                <th>Order ID</th>

                                <th>User ID</th>

                                <th>Total Amount</th>

                                <th>Status</th>

                                <th>Shipping Address</th>

                                <th>Order Date</th>

                                <th>Action</th>

                            </tr>

                        </thead>


                        <tbody>

                            <c:forEach
                                var="order"
                                items="${orders}">

                                <tr>

                                    <td>
                                        #${order.orderId}
                                    </td>

                                    <td>
                                        ${order.userId}
                                    </td>

                                    <td>

                                        ₹

                                        <fmt:formatNumber
                                            value="${order.totalAmount}"
                                            type="number"
                                            minFractionDigits="2"
                                            maxFractionDigits="2"/>

                                    </td>


                                    <td>

                                        <form
                                            action="${pageContext.request.contextPath}/admin/orders/update-status"
                                            method="post">

                                            <input
                                                type="hidden"
                                                name="orderId"
                                                value="${order.orderId}">

                                            <select
                                                name="orderStatus"
                                                onchange="this.form.submit()">

                                                <option
                                                    value="PLACED"
                                                    ${order.orderStatus == 'PLACED' ? 'selected' : ''}>
                                                    PLACED
                                                </option>

                                                <option
                                                    value="CONFIRMED"
                                                    ${order.orderStatus == 'CONFIRMED' ? 'selected' : ''}>
                                                    CONFIRMED
                                                </option>

                                                <option
                                                    value="SHIPPED"
                                                    ${order.orderStatus == 'SHIPPED' ? 'selected' : ''}>
                                                    SHIPPED
                                                </option>

                                                <option
                                                    value="DELIVERED"
                                                    ${order.orderStatus == 'DELIVERED' ? 'selected' : ''}>
                                                    DELIVERED
                                                </option>

                                                <option
                                                    value="CANCELLED"
                                                    ${order.orderStatus == 'CANCELLED' ? 'selected' : ''}>
                                                    CANCELLED
                                                </option>

                                            </select>

                                        </form>

                                    </td>


                                    <td>
                                        ${order.shippingAddress}
                                    </td>


                                    <td>
                                        ${order.orderDate}
                                    </td>


                                    <td>

                                        <a
                                            href="${pageContext.request.contextPath}/admin/orders/details?orderId=${order.orderId}"
                                            class="view-btn">
                                            View Details
                                        </a>

                                    </td>

                                </tr>

                            </c:forEach>

                        </tbody>

                    </table>

                </c:when>


                <c:otherwise>

                    <div class="empty">

                        <h3>No Orders Found</h3>

                        <p>
                            There are currently no orders in the system.
                        </p>

                    </div>

                </c:otherwise>

            </c:choose>

        </div>

    </div>

</body>

</html>