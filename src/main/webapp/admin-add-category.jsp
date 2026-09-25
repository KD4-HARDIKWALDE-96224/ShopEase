<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Add Category - ShopEase</title>

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
            max-width: 700px;
            margin: 45px auto;
        }

        .page-header {
            margin-bottom: 25px;
        }

        .page-header h1 {
            font-size: 32px;
            margin-bottom: 8px;
        }

        .page-header p {
            color: #64748b;
        }

        .form-card {
            background: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        .error-message {
            background: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
            padding: 13px 16px;
            border-radius: 7px;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 22px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input,
        textarea {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 15px;
            font-family: Arial, sans-serif;
        }

        input:focus,
        textarea:focus {
            outline: none;
            border-color: #ff8500;
        }

        textarea {
            min-height: 130px;
            resize: vertical;
        }

        .button-row {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .submit-button {
            border: none;
            background: #ff8c00;
            color: white;
            padding: 13px 25px;
            border-radius: 7px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
        }

        .submit-button:hover {
            background: #e67e00;
        }

        .cancel-button {
            background: #e2e8f0;
            color: #172554;
            padding: 13px 25px;
            border-radius: 7px;
            text-decoration: none;
            font-weight: bold;
        }

        .cancel-button:hover {
            background: #cbd5e1;
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

            .form-card {
                padding: 25px;
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

            <a href="${pageContext.request.contextPath}/admin/categories">
                Categories
            </a>

            <a href="${pageContext.request.contextPath}/logout">
                Logout
            </a>

        </div>

    </nav>


    <main class="container">

        <div class="page-header">

            <h1>Add Category</h1>

            <p>
                Create a new product category for your ShopEase store.
            </p>

        </div>


        <div class="form-card">

            <c:if test="${not empty error}">

                <div class="error-message">
                    ${error}
                </div>

            </c:if>


            <form
                action="${pageContext.request.contextPath}/admin/categories/add"
                method="post"
            >

                <div class="form-group">

                    <label for="categoryName">
                        Category Name
                    </label>

                    <input
                        type="text"
                        id="categoryName"
                        name="categoryName"
                        placeholder="Enter category name"
                        maxlength="100"
                        required
                    >

                </div>


                <div class="form-group">

                    <label for="description">
                        Description
                    </label>

                    <textarea
                        id="description"
                        name="description"
                        placeholder="Enter category description"
                        maxlength="255"
                    ></textarea>

                </div>


                <div class="button-row">

                    <button
                        type="submit"
                        class="submit-button"
                    >
                        Add Category
                    </button>

                    <a
                        class="cancel-button"
                        href="${pageContext.request.contextPath}/admin/categories"
                    >
                        Cancel
                    </a>

                </div>

            </form>

        </div>


        <a
            class="back-link"
            href="${pageContext.request.contextPath}/admin/categories"
        >
            ← Back to Manage Categories
        </a>

    </main>


    <footer>

        © 2026 ShopEase. All Rights Reserved.

    </footer>

</body>

</html>