<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Category - ShopEase</title>

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
            width: 600px;
            max-width: 90%;
            margin: 50px auto;
            background: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        h1 {
            margin-top: 0;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input,
        textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        textarea {
            height: 120px;
            resize: vertical;
        }

        .error {
            background: #fee2e2;
            color: #b91c1c;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

        .buttons {
            display: flex;
            gap: 12px;
        }

        button,
        .cancel-btn {
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            font-size: 15px;
        }

        button {
            background: #2563eb;
            color: white;
        }

        .cancel-btn {
            background: #6b7280;
            color: white;
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

        <a href="${pageContext.request.contextPath}/admin/categories">
            Categories
        </a>
    </div>

</div>

<div class="container">

    <h1>Edit Category</h1>

    <c:if test="${not empty error}">
        <div class="error">
            ${error}
        </div>
    </c:if>

    <form
        action="${pageContext.request.contextPath}/admin/categories/edit"
        method="post">

        <input
            type="hidden"
            name="categoryId"
            value="${category.categoryId}">

        <label>Category Name</label>

        <input
            type="text"
            name="categoryName"
            value="${category.categoryName}"
            required>

        <label>Description</label>

        <textarea
            name="description"
            required>${category.description}</textarea>

        <div class="buttons">

            <button type="submit">
                Update Category
            </button>

            <a
                href="${pageContext.request.contextPath}/admin/categories"
                class="cancel-btn">
                Cancel
            </a>

        </div>

    </form>

</div>

</body>
</html>