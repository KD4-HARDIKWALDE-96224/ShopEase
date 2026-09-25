<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Add Product - ShopEase</title>

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
            max-width: 850px;
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

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input,
        textarea,
        select {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 15px;
            font-family: Arial, sans-serif;
        }

        input:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: #ff8500;
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
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

            .form-row {
                grid-template-columns: 1fr;
            }

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

            <a href="${pageContext.request.contextPath}/admin/products">
                Products
            </a>

            <a href="${pageContext.request.contextPath}/logout">
                Logout
            </a>

        </div>

    </nav>


    <main class="container">

        <div class="page-header">

            <h1>Add New Product</h1>

            <p>
                Add a new product to your ShopEase store.
            </p>

        </div>


        <div class="form-card">

            <form
                action="${pageContext.request.contextPath}/admin/products/add"
                method="post"
            >

                <div class="form-group">

                    <label for="productName">
                        Product Name
                    </label>

                    <input
                        type="text"
                        id="productName"
                        name="productName"
                        placeholder="Enter product name"
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
                        placeholder="Enter product description"
                        required
                    ></textarea>

                </div>


                <div class="form-row">

                    <div class="form-group">

                        <label for="price">
                            Price (₹)
                        </label>

                        <input
                            type="number"
                            id="price"
                            name="price"
                            min="0"
                            step="0.01"
                            placeholder="Enter price"
                            required
                        >

                    </div>


                    <div class="form-group">

                        <label for="discount">
                            Discount (%)
                        </label>

                        <input
                            type="number"
                            id="discount"
                            name="discount"
                            min="0"
                            max="100"
                            step="0.01"
                            value="0"
                            required
                        >

                    </div>

                </div>


                <div class="form-row">

                    <div class="form-group">

                        <label for="stockQuantity">
                            Stock Quantity
                        </label>

                        <input
                            type="number"
                            id="stockQuantity"
                            name="stockQuantity"
                            min="0"
                            placeholder="Enter stock quantity"
                            required
                        >

                    </div>


                    <div class="form-group">

                        <label for="categoryId">
                            Category
                        </label>

                        <select
                            id="categoryId"
                            name="categoryId"
                            required
                        >

                            <option value="">
                                Select Category
                            </option>

                            <option value="1">
                                Mobiles
                            </option>

                            <option value="2">
                                Laptops
                            </option>

                            <option value="3">
                                Fashion
                            </option>

                            <option value="4">
                                Accessories
                            </option>

                            <option value="5">
                                Home
                            </option>

                            <option value="6">
                                Books
                            </option>

                            <option value="7">
                                Sports
                            </option>

                        </select>

                    </div>

                </div>


                <div class="form-group">

                    <label for="imageUrl">
                        Image URL
                    </label>

                    <input
                        type="text"
                        id="imageUrl"
                        name="imageUrl"
                        placeholder="Example: phone.jpg"
                    >

                </div>


                <div class="button-row">

                    <button
                        type="submit"
                        class="submit-button"
                    >
                        Add Product
                    </button>

                    <a
                        class="cancel-button"
                        href="${pageContext.request.contextPath}/admin/products"
                    >
                        Cancel
                    </a>

                </div>

            </form>

        </div>


        <a
            class="back-link"
            href="${pageContext.request.contextPath}/admin/products"
        >
            ← Back to Manage Products
        </a>

    </main>


    <footer>

        © 2026 ShopEase. All Rights Reserved.

    </footer>

</body>

</html>