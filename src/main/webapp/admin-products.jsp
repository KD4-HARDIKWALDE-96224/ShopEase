<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8">

<title>Manage Products - ShopEase</title>

<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: Arial, sans-serif;
	background: #f4f6fa;
	color: #172554;
}

.navbar {
	background: #101828;
	color: white;
	padding: 20px 5%;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.logo {
	font-size: 30px;
	font-weight: bold;
}

.logo span {
	color: #ff8500;
}

.nav-links {
	display: flex;
	align-items: center;
	gap: 25px;
}

.nav-links a {
	color: white;
	text-decoration: none;
	font-size: 15px;
}

.nav-links a:hover {
	color: #ff8500;
}

.container {
	width: 90%;
	max-width: 1400px;
	margin: 40px auto;
}

.page-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.page-header h1 {
	font-size: 32px;
	margin-bottom: 8px;
}

.page-header p {
	color: #64748b;
}

.add-button {
	background: #ff8c00;
	color: white;
	text-decoration: none;
	padding: 13px 22px;
	border-radius: 7px;
	font-weight: bold;
}

.add-button:hover {
	background: #e67e00;
}

.table-container {
	background: white;
	border-radius: 12px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
	overflow-x: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	min-width: 950px;
}

th {
	background: #101828;
	color: white;
	padding: 16px;
	text-align: left;
	font-size: 14px;
}

td {
	padding: 15px 16px;
	border-bottom: 1px solid #e5e7eb;
	vertical-align: middle;
	font-size: 14px;
}

tr:hover {
	background: #f8fafc;
}

.product-image {
	width: 70px;
	height: 70px;
	object-fit: contain;
	border-radius: 7px;
	background: #f1f5f9;
}

.product-name {
	font-weight: bold;
	color: #172554;
}

.description {
	max-width: 250px;
	color: #64748b;
	line-height: 1.4;
}

.price {
	font-weight: bold;
	font-size: 16px;
}

.discount {
	color: #16a34a;
	font-weight: bold;
}

.stock {
	font-weight: bold;
}

.out-of-stock {
	color: #dc2626;
}

.in-stock {
	color: #16a34a;
}

.actions {
	display: flex;
	gap: 8px;
}

.edit-button, .delete-button {
	border: none;
	padding: 8px 12px;
	border-radius: 5px;
	text-decoration: none;
	font-size: 13px;
	font-weight: bold;
	cursor: pointer;
}

.edit-button {
	background: #e0f2fe;
	color: #0369a1;
}

.delete-button {
	background: #fee2e2;
	color: #dc2626;
}

.empty-message {
	padding: 50px;
	text-align: center;
	color: #64748b;
	font-size: 17px;
}

.back-link {
	display: inline-block;
	margin-top: 25px;
	color: #172554;
	text-decoration: none;
	font-weight: bold;
}

.back-link:hover {
	color: #ff8500;
}

footer {
	margin-top: 60px;
	background: #101828;
	color: #94a3b8;
	text-align: center;
	padding: 25px;
}

@media ( max-width : 700px) {
	.navbar {
		flex-direction: column;
		gap: 15px;
	}
	.page-header {
		flex-direction: column;
		align-items: flex-start;
		gap: 20px;
	}
	.container {
		width: 95%;
	}
}
</style>

</head>

<body>

	<nav class="navbar">

		<div class="logo">
			Shop<span>Ease</span>
		</div>

		<div class="nav-links">

			<a href="${pageContext.request.contextPath}/admin/dashboard">
				Dashboard </a> <a href="${pageContext.request.contextPath}/products">
				View Store </a> <a href="${pageContext.request.contextPath}/logout">
				Logout </a>

		</div>

	</nav>


	<main class="container">

		<div class="page-header">

			<div>

				<h1>Manage Products</h1>

				<p>View and manage all products in your ShopEase store.</p>

			</div>

			<a class="add-button"
				href="${pageContext.request.contextPath}/admin/products/add">
				+ Add New Product </a>

		</div>


		<div class="table-container">

			<c:choose>

				<c:when test="${not empty products}">

					<table>

						<thead>

							<tr>
								<th>ID</th>
								<th>Image</th>
								<th>Product</th>
								<th>Description</th>
								<th>Price</th>
								<th>Discount</th>
								<th>Stock</th>
								<th>Category ID</th>
								<th>Actions</th>
							</tr>

						</thead>

						<tbody>

							<c:forEach var="product" items="${products}">

								<tr>

									<td>${product.productId}</td>

									<td><c:choose>

											<c:when test="${product.productId == 1}">
												<img class="product-image"
													src="${pageContext.request.contextPath}/img/phone.jpg"
													alt="${product.productName}">
											</c:when>

											<c:when test="${product.productId == 2}">
												<img class="product-image"
													src="${pageContext.request.contextPath}/img/laptop.jpg"
													alt="${product.productName}">
											</c:when>

											<c:when test="${product.productId == 3}">
												<img class="product-image"
													src="${pageContext.request.contextPath}/img/headphones.jpg"
													alt="${product.productName}">
											</c:when>

											<c:when test="${product.productId == 4}">
												<img class="product-image"
													src="${pageContext.request.contextPath}/img/shoes.jpg"
													alt="${product.productName}">
											</c:when>

											<c:otherwise>
												<div class="product-image"></div>
											</c:otherwise>

										</c:choose></td>

									<td>

										<div class="product-name">${product.productName}</div>

									</td>

									<td>

										<div class="description">${product.description}</div>

									</td>

									<td><span class="price"> ₹ <fmt:formatNumber
												value="${product.price}" type="number" minFractionDigits="2"
												maxFractionDigits="2" />
									</span></td>

									<td><span class="discount"> ${product.discount}%
											OFF </span></td>

									<td><c:choose>

											<c:when test="${product.stockQuantity > 0}">

												<span class="stock in-stock">
													${product.stockQuantity} </span>

											</c:when>

											<c:otherwise>

												<span class="stock out-of-stock"> Out of Stock </span>

											</c:otherwise>

										</c:choose></td>

									<td>${product.categoryId}</td>

									<td>

										<div class="actions">

											<a class="edit-button"
												href="${pageContext.request.contextPath}/admin/products/edit?productId=${product.productId}">
												Edit </a> <a class="delete-button"
												href="${pageContext.request.contextPath}/admin/products/delete?productId=${product.productId}"
												onclick="return confirm('Are you sure you want to delete ${product.productName}?');">
												Delete </a>

										</div>

									</td>

								</tr>

							</c:forEach>

						</tbody>

					</table>

				</c:when>


				<c:otherwise>

					<div class="empty-message">No products found.</div>

				</c:otherwise>

			</c:choose>

		</div>


		<a class="back-link"
			href="${pageContext.request.contextPath}/admin/dashboard">
			← Back to Admin Dashboard </a>

	</main>


	<footer> © 2026 ShopEase. All Rights Reserved. </footer>

</body>

</html>