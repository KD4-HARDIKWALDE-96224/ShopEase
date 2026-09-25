<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Manage Categories - ShopEase</title>

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
            gap: 25px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
        }

        .nav-links a:hover {
            color: #ff8500;
        }

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 45px auto;
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
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #101828;
            color: white;
            padding: 16px;
            text-align: left;
        }

        td {
            padding: 16px;
            border-bottom: 1px solid #e5e7eb;
        }

        tr:hover {
            background: #f8fafc;
        }

        .category-name {
            font-weight: bold;
        }

        .description {
            color: #64748b;
        }

        .actions {
            display: flex;
            gap: 8px;
        }

        .edit-button,
        .delete-button {
            padding: 8px 12px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 13px;
            font-weight: bold;
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

        @media (max-width: 650px) {

            .navbar {
                flex-direction: column;
                gap: 15px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }

            .table-container {
                overflow-x: auto;
            }

            table {
                min-width: 700px;
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
                Dashboard
            </a>

            <a href="${pageContext.request.contextPath}/admin/products">
                Products
            </a>

            <a href="${pageContext.request.contextPath}/products">
                View Store
            </a>

            <a href="${pageContext.request.contextPath}/logout">
                Logout
            </a>

        </div>

    </nav>


    <main class="container">

        <div class="page-header">

            <div>

                <h1>Manage Categories</h1>

                <p>
                    View and manage product categories.
                </p>

            </div>

            <a
                class="add-button"
                href="${pageContext.request.contextPath}/admin/categories/add"
            >
                + Add Category
            </a>

        </div>


        <div class="table-container">

            <c:choose>

                <c:when test="${not empty categories}">

                    <table>

                        <thead>

                            <tr>
                                <th>ID</th>
                                <th>Category Name</th>
                                <th>Description</th>
                                <th>Actions</th>
                            </tr>

                        </thead>

                        <tbody>

                            <c:forEach
                                var="category"
                                items="${categories}"
                            >

                                <tr>

                                    <td>
                                        ${category.categoryId}
                                    </td>

                                    <td>

                                        <span class="category-name">
                                            ${category.categoryName}
                                        </span>

                                    </td>

                                    <td>

                                        <span class="description">
                                            ${category.description}
                                        </span>

                                    </td>

                                    <td>

                                        <div class="actions">

                                            <a
                                                class="edit-button"
                                                href="${pageContext.request.contextPath}/admin/categories/edit?categoryId=${category.categoryId}"
                                            >
                                                Edit
                                            </a>

                                            <a
                                                class="delete-button"
                                                href="${pageContext.request.contextPath}/admin/categories/delete?categoryId=${category.categoryId}"
                                                onclick="return confirm('Are you sure you want to delete ${category.categoryName}?');"
                                            >
                                                Delete
                                            </a>

                                        </div>

                                    </td>

                                </tr>

                            </c:forEach>

                        </tbody>

                    </table>

                </c:when>

                <c:otherwise>

                    <div class="empty-message">
                        No categories found.
                    </div>

                </c:otherwise>

            </c:choose>

        </div>


        <a
            class="back-link"
            href="${pageContext.request.contextPath}/admin/dashboard"
        >
            ← Back to Admin Dashboard
        </a>

    </main>


    <footer>

        © 2026 ShopEase. All Rights Reserved.

    </footer>

</body>

</html>