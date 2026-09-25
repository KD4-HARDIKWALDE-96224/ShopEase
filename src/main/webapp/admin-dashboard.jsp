<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard - ShopEase</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">


    <style>

        /* ================= ADMIN DASHBOARD ================= */

        .admin-page {
            min-height: calc(100vh - 80px);
            background: #f5f7fb;
            padding: 40px 6%;
        }


        .admin-container {
            max-width: 1250px;
            margin: 0 auto;
        }


        .admin-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
        }


        .admin-header h1 {
            margin: 0;
            color: #172033;
            font-size: 32px;
        }


        .admin-header p {
            margin: 8px 0 0;
            color: #667085;
            font-size: 15px;
        }


        .admin-badge {
            background: #172033;
            color: #ffffff;
            padding: 9px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 700;
        }


        /* ================= ADMIN CARDS ================= */

        .admin-grid {
            display: grid;
            grid-template-columns:
                repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 35px;
        }


        .admin-card {
            background: #ffffff;
            padding: 25px;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
            box-shadow:
                0 4px 15px rgba(0, 0, 0, 0.05);
        }


        .admin-card-icon {
            font-size: 30px;
            margin-bottom: 15px;
        }


        .admin-card h3 {
            margin: 0 0 8px;
            color: #172033;
            font-size: 17px;
        }


        .admin-card p {
            margin: 0 0 18px;
            color: #667085;
            font-size: 14px;
            line-height: 1.5;
        }


        .admin-card a {
            display: inline-block;
            color: #e68a00;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
        }


        .admin-card a:hover {
            text-decoration: underline;
        }


        /* ================= QUICK ACTIONS ================= */

        .admin-section {
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
            box-shadow:
                0 4px 15px rgba(0, 0, 0, 0.05);
        }


        .admin-section h2 {
            margin: 0 0 20px;
            color: #172033;
            font-size: 21px;
        }


        .admin-actions {
            display: grid;
            grid-template-columns:
                repeat(3, 1fr);
            gap: 15px;
        }


        .admin-action {
            display: block;
            padding: 18px;
            background: #f8fafc;
            border: 1px solid #e5e7eb;
            border-radius: 9px;
            color: #172033;
            text-decoration: none;
            font-weight: 600;
            transition: 0.2s ease;
        }


        .admin-action:hover {
            background: #fff7ed;
            border-color: #ff9900;
            color: #e68a00;
            transform: translateY(-2px);
        }


        /* ================= RESPONSIVE ================= */

        @media (max-width: 1000px) {

            .admin-grid {
                grid-template-columns:
                    repeat(2, 1fr);
            }

            .admin-actions {
                grid-template-columns:
                    repeat(2, 1fr);
            }

        }


        @media (max-width: 600px) {

            .admin-page {
                padding: 25px 15px;
            }

            .admin-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .admin-header h1 {
                font-size: 27px;
            }

            .admin-grid {
                grid-template-columns: 1fr;
            }

            .admin-actions {
                grid-template-columns: 1fr;
            }

        }

    </style>

</head>


<body>


    <!-- ================= NAVBAR ================= -->

    <nav class="navbar">

        <div class="logo">
            Shop<span>Ease</span>
        </div>


        <div class="nav-actions">

            <span class="welcome-user">

                Hello,
                ${sessionScope.loggedInUser.fullName}

            </span>


            <a
                href="${pageContext.request.contextPath}/products">

                View Store

            </a>


            <a
                href="${pageContext.request.contextPath}/logout">

                Logout

            </a>

        </div>

    </nav>



    <!-- ================= ADMIN PAGE ================= -->

    <section class="admin-page">

        <div class="admin-container">


            <!-- HEADER -->

            <div class="admin-header">

                <div>

                    <h1>
                        Admin Dashboard
                    </h1>

                    <p>
                        Manage your ShopEase store from one place.
                    </p>

                </div>


                <span class="admin-badge">
                    ADMIN
                </span>

            </div>



            <!-- ================= MANAGEMENT CARDS ================= -->

            <div class="admin-grid">


                <!-- PRODUCTS -->

                <div class="admin-card">

                    <div class="admin-card-icon">
                        📦
                    </div>

                    <h3>
                        Manage Products
                    </h3>

                    <p>
                        Add, edit and remove products
                        from the store.
                    </p>

                    <a
                        href="${pageContext.request.contextPath}/admin/products">

                        Manage Products →

                    </a>

                </div>



                <!-- CATEGORIES -->

                <div class="admin-card">

                    <div class="admin-card-icon">
                        🗂️
                    </div>

                    <h3>
                        Manage Categories
                    </h3>

                    <p>
                        Create and manage product
                        categories.
                    </p>

                    <a
                        href="${pageContext.request.contextPath}/admin/categories">

                        Manage Categories →

                    </a>

                </div>



                <!-- ORDERS -->

                <div class="admin-card">

                    <div class="admin-card-icon">
                        🛒
                    </div>

                    <h3>
                        Manage Orders
                    </h3>

                    <p>
                        View customer orders and
                        update order status.
                    </p>

                    <a
                        href="${pageContext.request.contextPath}/admin/orders">

                        Manage Orders →

                    </a>

                </div>



                <!-- USERS -->

                <div class="admin-card">

                    <div class="admin-card-icon">
                        👥
                    </div>

                    <h3>
                        Manage Users
                    </h3>

                    <p>
                        View registered customers
                        and user information.
                    </p>

                    <a
                        href="${pageContext.request.contextPath}/admin/users">

                        Manage Users →

                    </a>

                </div>

            </div>



            <!-- ================= QUICK ACTIONS ================= -->

            <div class="admin-section">

                <h2>
                    Quick Actions
                </h2>


                <div class="admin-actions">


                    <a
                        href="${pageContext.request.contextPath}/admin/products"
                        class="admin-action">

                        ➕ Add New Product

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/admin/categories"
                        class="admin-action">

                        🗂️ Add Category

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/admin/orders"
                        class="admin-action">

                        📋 View Orders

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/admin/users"
                        class="admin-action">

                        👤 View Users

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/products"
                        class="admin-action">

                        🛍️ Visit Store

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/logout"
                        class="admin-action">

                        🚪 Logout

                    </a>

                </div>

            </div>


        </div>

    </section>



    <!-- ================= FOOTER ================= -->

    <footer class="footer">

        <p>
            © 2026 ShopEase. All Rights Reserved.
        </p>

    </footer>


</body>

</html>