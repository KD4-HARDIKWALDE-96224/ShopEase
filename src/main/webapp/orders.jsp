<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>My Orders - ShopEase</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

	<nav class="navbar">

		<div class="logo">

			Shop<span>Ease</span>

		</div>

		<div class="nav-actions">

			<span class="welcome-user"> Hello,
				${sessionScope.loggedInUser.fullName} </span> <a
				href="${pageContext.request.contextPath}/products"> Products </a> <a
				href="${pageContext.request.contextPath}/cart" class="cart"> 🛒
				Cart </a> <a href="${pageContext.request.contextPath}/logout">
				Logout </a>

		</div>

	</nav>


	<section class="orders-section">

		<div class="orders-container">

			<h1>My Orders</h1>

			<p class="orders-subtitle">View your previous orders and order
				details.</p>


			<c:choose>

				<c:when test="${empty orderDetailsList}">

					<div class="no-orders">

						<div class="no-orders-icon">📦</div>

						<h2>No Orders Yet</h2>

						<p>You haven't placed any orders yet.</p>

						<a href="${pageContext.request.contextPath}/products"
							class="continue-shopping-btn"> Start Shopping </a>

					</div>

				</c:when>


				<c:otherwise>

					<div class="orders-list">

						<c:forEach var="orderDetails" items="${orderDetailsList}">

							<div class="order-card">


								<div class="order-header">

									<div>

										<span class="order-label"> Order ID </span>

										<h3>#${orderDetails.order.orderId}</h3>

									</div>


									<span class="order-status"> <c:choose>

											<c:when test="${orderDetails.order.orderStatus == 'PLACED'}">
												<span style="color: orange;"> PLACED </span>
											</c:when>

											<c:when
												test="${orderDetails.order.orderStatus == 'CONFIRMED'}">
												<span style="color: blue;"> CONFIRMED </span>
											</c:when>

											<c:when test="${orderDetails.order.orderStatus == 'SHIPPED'}">
												<span style="color: #6f42c1;"> SHIPPED </span>
											</c:when>

											<c:when
												test="${orderDetails.order.orderStatus == 'DELIVERED'}">
												<span style="color: green;"> DELIVERED </span>
											</c:when>

											<c:when
												test="${orderDetails.order.orderStatus == 'CANCELLED'}">
												<span style="color: red;"> CANCELLED </span>
											</c:when>

											<c:otherwise>
            ${orderDetails.order.orderStatus}
        </c:otherwise>

										</c:choose>

									</span>

								</div>


								<div class="order-details">


									<div class="order-detail">

										<span> Order Date </span> <strong>
											${orderDetails.order.orderDate} </strong>

									</div>


									<div class="order-detail">

										<span> Total Amount </span> <strong> ₹ <fmt:formatNumber
												value="${orderDetails.order.totalAmount}" type="number"
												minFractionDigits="2" maxFractionDigits="2" />

										</strong>

									</div>


									<div class="order-detail">

										<span> Shipping Address </span> <strong>
											${orderDetails.order.shippingAddress} </strong>

									</div>

								</div>


								<div class="order-details">

									<div class="order-detail">

										<span> Payment Status </span> <strong> <c:choose>

												<c:when test="${orderDetails.order.paymentStatus == 'PAID'}">

													<span style="color: green;"> PAID </span>

												</c:when>

												<c:when
													test="${orderDetails.order.paymentStatus == 'FAILED'}">

													<span style="color: red;"> FAILED </span>

												</c:when>

												<c:otherwise>

													<span style="color: orange;">
														${orderDetails.order.paymentStatus} </span>

												</c:otherwise>

											</c:choose>

										</strong>

									</div>


									<div class="order-detail">

										<span> Razorpay Order ID </span> <strong>
											${orderDetails.order.razorpayOrderId} </strong>

									</div>


									<div class="order-detail">

										<span> Razorpay Payment ID </span> <strong>
											${orderDetails.order.razorpayPaymentId} </strong>

									</div>

								</div>


								<div class="order-items">

									<h3>Ordered Products</h3>


									<c:forEach var="item" items="${orderDetails.items}">

										<div class="order-item">


											<div class="order-item-info">

												<strong> ${item.productName} </strong> <span>
													Quantity: ${item.quantity} </span>

											</div>


											<div class="order-item-price">

												₹

												<fmt:formatNumber value="${item.price}" type="number"
													minFractionDigits="2" maxFractionDigits="2" />

												× ${item.quantity}

											</div>

										</div>

									</c:forEach>


								</div>


								<div style="margin-top: 20px; text-align: right;">

									<a
										href="${pageContext.request.contextPath}/order-details?orderId=${orderDetails.order.orderId}"
										class="continue-shopping-btn"> View Order Details </a>

								</div>


							</div>

						</c:forEach>

					</div>

				</c:otherwise>

			</c:choose>

		</div>

	</section>


	<footer class="footer">

		<p>© 2026 ShopEase. All Rights Reserved.</p>

	</footer>


</body>

</html>