<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="jakarta.tags.core"%>

<%@ taglib prefix="fmt"
    uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>${product.productName} - ShopEase</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">


    <style>

        /* =====================================================
           PRODUCT DETAILS PAGE
           ===================================================== */

        .product-details-section {
            width: 100%;
            min-height: calc(100vh - 160px);
            padding: 60px 6%;
            background: #f5f7fb;
            box-sizing: border-box;
        }


        .product-details-container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;

            display: grid !important;
            grid-template-columns: 1fr 1fr !important;

            gap: 55px;

            align-items: center;

            background: #ffffff;

            padding: 45px;

            border-radius: 16px;

            box-sizing: border-box;

            box-shadow:
                0 8px 30px rgba(0, 0, 0, 0.08);
        }


        /* =====================================================
           PRODUCT IMAGE
           ===================================================== */

        .product-details-image {
            width: 100%;
            height: 500px;

            background: #f8fafc;

            border-radius: 14px;

            overflow: hidden;

            display: flex;
            align-items: center;
            justify-content: center;

            box-sizing: border-box;
        }


        .product-details-image img {
            width: 100%;
            height: 100%;

            object-fit: contain;

            display: block;
        }


        /* =====================================================
           PRODUCT INFORMATION
           ===================================================== */

        .product-details-info {
            width: 100%;

            padding: 10px 5px;

            box-sizing: border-box;
        }


        .product-details-badge {
            display: inline-block;

            background: #fff1df;
            color: #e68a00;

            padding: 7px 14px;

            border-radius: 20px;

            font-size: 13px;
            font-weight: 700;

            margin-bottom: 18px;
        }


        .product-details-info h1 {
            margin: 0 0 18px;

            color: #172033;

            font-size: 38px;

            line-height: 1.2;

            font-weight: 700;
        }


        .product-details-description {
            margin: 0 0 25px;

            color: #667085;

            font-size: 16px;

            line-height: 1.7;

            max-width: 520px;
        }


        /* =====================================================
           PRICE
           ===================================================== */

        .product-details-price {
            color: #172033;

            font-size: 32px;

            font-weight: 700;

            margin-bottom: 20px;
        }


        /* =====================================================
           STOCK
           ===================================================== */

        .product-details-stock {
            display: flex;

            align-items: center;

            gap: 12px;

            margin-bottom: 30px;

            color: #667085;

            font-size: 14px;
        }


        .in-stock {
            color: #15803d;

            font-weight: 700;
        }


        .out-of-stock {
            color: #dc2626;

            font-weight: 700;
        }


        /* =====================================================
           ADD TO CART
           ===================================================== */

        .details-add-cart {
            width: 100%;

            max-width: 360px;

            padding: 14px 25px;

            border: none;

            border-radius: 8px;

            background: #ff9900;

            color: #ffffff;

            font-size: 16px;

            font-weight: 700;

            cursor: pointer;

            transition: 0.2s ease;
        }


        .details-add-cart:hover {
            background: #e68a00;

            transform: translateY(-1px);
        }


        .details-add-cart:disabled {
            background: #b8bec8;

            cursor: not-allowed;

            transform: none;
        }


        /* =====================================================
           CONTINUE SHOPPING
           ===================================================== */

        .back-products-btn {
            display: inline-block;

            margin-top: 18px;

            color: #172033;

            font-size: 14px;

            font-weight: 600;

            text-decoration: none;
        }


        .back-products-btn:hover {
            color: #ff9900;
        }


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 900px) {

            .product-details-section {
                padding: 35px 20px;
            }


            .product-details-container {
                grid-template-columns: 1fr !important;

                gap: 35px;

                padding: 30px;
            }


            .product-details-image {
                height: 420px;
            }


            .product-details-info h1 {
                font-size: 32px;
            }

        }


        @media (max-width: 600px) {

            .product-details-section {
                padding: 20px 12px;
            }


            .product-details-container {
                padding: 20px;

                border-radius: 12px;
            }


            .product-details-image {
                height: 300px;
            }


            .product-details-info h1 {
                font-size: 28px;
            }


            .product-details-price {
                font-size: 27px;
            }


            .details-add-cart {
                max-width: 100%;
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

            <c:choose>


                <c:when test="${not empty sessionScope.loggedInUser}">

                    <span class="welcome-user">

                        Hello,
                        ${sessionScope.loggedInUser.fullName}

                    </span>


                    <a
                        href="${pageContext.request.contextPath}/products">

                        Products

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/orders">

                        Orders

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/cart"
                        class="cart">

                        🛒 Cart

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/logout">

                        Logout

                    </a>

                </c:when>


                <c:otherwise>

                    <a
                        href="${pageContext.request.contextPath}/login.jsp">

                        Login

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/register.jsp">

                        Register

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/products">

                        Products

                    </a>

                </c:otherwise>


            </c:choose>

        </div>

    </nav>



    <!-- ================= PRODUCT DETAILS ================= -->

    <section class="product-details-section">


        <div class="product-details-container">


            <!-- ================= PRODUCT IMAGE ================= -->

            <div class="product-details-image">

                <c:choose>


                    <c:when
                        test="${product.productId == 1}">

                        <img
                            src="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&w=800&q=80"
                            alt="Smartphone">

                    </c:when>


                    <c:when
                        test="${product.productId == 2}">

                        <img
                            src="https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&w=800&q=80"
                            alt="Laptop">

                    </c:when>


                    <c:when
                        test="${product.productId == 3}">

                        <img
                            src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=800&q=80"
                            alt="Wireless Headphones">

                    </c:when>


                    <c:when
                        test="${product.productId == 4}">

                        <img
                            src="https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=800&q=80"
                            alt="Running Shoes">

                    </c:when>


                </c:choose>

            </div>



            <!-- ================= PRODUCT INFORMATION ================= -->

            <div class="product-details-info">


                <!-- DISCOUNT -->

                <span class="product-details-badge">

                    ${product.discount}% OFF

                </span>



                <!-- PRODUCT NAME -->

                <h1>

                    ${product.productName}

                </h1>



                <!-- DESCRIPTION -->

                <p class="product-details-description">

                    ${product.description}

                </p>



                <!-- PRICE -->

                <div class="product-details-price">

                    ₹

                    <fmt:formatNumber
                        value="${product.price}"
                        type="number"
                        minFractionDigits="2"
                        maxFractionDigits="2"/>

                </div>



                <!-- STOCK -->

                <div class="product-details-stock">

                    <c:choose>


                        <c:when
                            test="${product.stockQuantity > 0}">

                            <span class="in-stock">

                                ✓ In Stock

                            </span>


                            <span>

                                ${product.stockQuantity}
                                units available

                            </span>

                        </c:when>


                        <c:otherwise>

                            <span class="out-of-stock">

                                ✕ Out of Stock

                            </span>

                        </c:otherwise>


                    </c:choose>

                </div>



                <!-- ADD TO CART -->

                <c:choose>


                    <c:when
                        test="${product.stockQuantity > 0}">

                        <form
                            action="${pageContext.request.contextPath}/add-to-cart"
                            method="post">

                            <input
                                type="hidden"
                                name="productId"
                                value="${product.productId}">


                            <button
                                type="submit"
                                class="details-add-cart">

                                🛒 Add to Cart

                            </button>

                        </form>

                    </c:when>


                    <c:otherwise>

                        <button
                            type="button"
                            class="details-add-cart"
                            disabled>

                            Out of Stock

                        </button>

                    </c:otherwise>


                </c:choose>



                <!-- CONTINUE SHOPPING -->

                <a
                    href="${pageContext.request.contextPath}/products"
                    class="back-products-btn">

                    ← Continue Shopping

                </a>


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