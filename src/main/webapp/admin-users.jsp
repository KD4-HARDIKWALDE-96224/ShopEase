<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Manage Users - ShopEase</title>

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

th, td {
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

.role {
	display: inline-block;
	padding: 6px 10px;
	border-radius: 20px;
	background: #dbeafe;
	color: #1d4ed8;
	font-size: 13px;
	font-weight: bold;
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

.delete-btn {
	display: inline-block;
	padding: 7px 12px;
	background: #dc2626;
	color: white;
	text-decoration: none;
	border-radius: 6px;
	font-size: 14px;
}

.delete-btn:hover {
	background: #b91c1c;
}

.empty {
	text-align: center;
	padding: 40px;
	color: #6b7280;
}

.current-user {
    display: inline-block;
    padding: 7px 12px;
    background: #e5e7eb;
    color: #374151;
    border-radius: 6px;
    font-size: 14px;
    font-weight: bold;
}
</style>

</head>

<body>

	<div class="navbar">

		<h2>ShopEase Admin</h2>

		<div class="nav-links">

			<a href="${pageContext.request.contextPath}/admin/dashboard">
				Dashboard </a> <a href="${pageContext.request.contextPath}/products">
				View Store </a> <a href="${pageContext.request.contextPath}/logout">
				Logout </a>

		</div>

	</div>


	<div class="container">

		<div class="header">

			<h1>Manage Users</h1>

			<a href="${pageContext.request.contextPath}/admin/dashboard"
				class="back-btn"> Back to Dashboard </a>

		</div>


		<div class="table-container">

			<c:choose>

				<c:when test="${not empty users}">

					<table>

						<thead>

							<tr>

								<th>User ID</th>

								<th>Full Name</th>

								<th>Email</th>

								<th>Phone</th>

								<th>Address</th>

								<th>Role</th>

								<th>Action</th>

							</tr>

						</thead>


						<tbody>

							<c:forEach var="user" items="${users}">

								<tr>

									<td>${user.userId}</td>

									<td>${user.fullName}</td>

									<td>${user.email}</td>

									<td>${user.phone}</td>

									<td>${user.address}</td>

									<td>

										<form
											action="${pageContext.request.contextPath}/admin/users/update-role"
											method="post">

											<input type="hidden" name="userId" value="${user.userId}">

											<select name="role" onchange="this.form.submit()">

												<option value="CUSTOMER"
													${user.role == 'CUSTOMER' ? 'selected' : ''}>
													CUSTOMER</option>

												<option value="ADMIN"
													${user.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>

											</select>

										</form>

									</td>

									<td><c:choose>

											<c:when
												test="${user.userId == sessionScope.loggedInUser.userId}">

												<span class="current-user"> Current Admin </span>

											</c:when>

											<c:otherwise>

												<a
													href="${pageContext.request.contextPath}/admin/users/delete?userId=${user.userId}"
													onclick="return confirm('Are you sure you want to delete ${user.fullName}?');"
													class="delete-btn"> Delete </a>

											</c:otherwise>

										</c:choose></td>

								</tr>

							</c:forEach>

						</tbody>

					</table>

				</c:when>


				<c:otherwise>

					<div class="empty">

						<h3>No Users Found</h3>

						<p>There are currently no users in the system.</p>

					</div>

				</c:otherwise>

			</c:choose>

		</div>

	</div>

</body>

</html>