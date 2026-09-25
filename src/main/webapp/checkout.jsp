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

    <title>ShopEase - Checkout</title>

    <link rel="stylesheet"
        href="${pageContext.request.contextPath}/css/style.css">

    <!-- Razorpay Checkout -->
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>

</head>

<body>

    <!-- ================= NAVBAR ================= -->

    <nav class="navbar">

        <div class="logo">

            Shop<span>Ease</span>

        </div>

        <div class="nav-actions">

            <a href="${pageContext.request.contextPath}/products">
                Products
            </a>

            <a href="${pageContext.request.contextPath}/cart">
                🛒 Cart
            </a>

            <a href="${pageContext.request.contextPath}/logout">
                Logout
            </a>

        </div>

    </nav>


    <!-- ================= CHECKOUT ================= -->

    <section class="checkout-section">

        <div class="checkout-container">


            <!-- ================= CHECKOUT FORM ================= -->

            <div class="checkout-form">

                <h1>Checkout</h1>

                <p>
                    Enter your shipping details to place your order.
                </p>


                <form id="checkoutForm">

                    <div class="form-group">

                        <label for="shippingAddress">
                            Shipping Address
                        </label>

                        <textarea
                            id="shippingAddress"
                            name="shippingAddress"
                            rows="5"
                            placeholder="Enter your complete delivery address"
                            required></textarea>

                    </div>


                    <button
                        type="submit"
                        id="payButton"
                        class="checkout-btn">

                        Pay with Razorpay

                    </button>

                </form>

            </div>


            <!-- ================= ORDER SUMMARY ================= -->

            <div class="checkout-summary">

                <h2>Order Summary</h2>


                <c:set
                    var="checkoutTotal"
                    value="0" />


                <c:forEach
                    var="item"
                    items="${sessionScope.cart}">


                    <div class="checkout-item">

                        <div>

                            <strong>
                                ${item.product.productName}
                            </strong>

                            <p>

                                Quantity:
                                ${item.quantity}

                            </p>

                        </div>


                        <span>

                            ₹<fmt:formatNumber
                                value="${item.totalPrice}"
                                type="number"
                                maxFractionDigits="0"/>

                        </span>

                    </div>


                    <c:set
                        var="checkoutTotal"
                        value="${checkoutTotal + item.totalPrice}" />

                </c:forEach>


                <div class="checkout-total">

                    <strong>
                        Total
                    </strong>

                    <strong>

                        ₹<fmt:formatNumber
                            value="${checkoutTotal}"
                            type="number"
                            maxFractionDigits="0"/>

                    </strong>

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


    <!-- ================= RAZORPAY JAVASCRIPT ================= -->

    <script>

        const checkoutForm =
            document.getElementById("checkoutForm");

        const payButton =
            document.getElementById("payButton");


        checkoutForm.addEventListener(
            "submit",
            async function(event) {

                event.preventDefault();


                const shippingAddress =
                    document.getElementById(
                        "shippingAddress"
                    ).value.trim();


                if (shippingAddress === "") {

                    alert(
                        "Please enter your shipping address."
                    );

                    return;
                }


                payButton.disabled = true;

                payButton.innerText =
                    "Creating Payment...";


                try {

                    /*
                     * Step 1:
                     * Ask our server to create
                     * a Razorpay Order.
                     */

                    const response =
                        await fetch(
                            "${pageContext.request.contextPath}/create-razorpay-order",
                            {
                                method: "POST"
                            }
                        );


                    if (!response.ok) {

                        throw new Error(
                            "Unable to create Razorpay order."
                        );

                    }


                    const orderData =
                        await response.json();


                    /*
                     * Step 2:
                     * Open Razorpay Checkout.
                     */

                    const options = {

                        key: orderData.keyId,

                        amount: orderData.amount,

                        currency: orderData.currency,

                        name: "ShopEase",

                        description:
                            "ShopEase Order Payment",

                        order_id:
                            orderData.orderId,


                        prefill: {

                            name:
                                "${sessionScope.loggedInUser.fullName}",

                            email:
                                "${sessionScope.loggedInUser.email}"

                        },


                        theme: {

                            color: "#ff7a00"

                        },


                        handler:
                            function(paymentResponse) {

                                /*
                                 * Step 3:
                                 * Payment successful.
                                 *
                                 * Send the payment details
                                 * to our backend for
                                 * signature verification.
                                 */

                                submitPaymentVerification(
                                    paymentResponse,
                                    shippingAddress
                                );

                            },


                        modal: {

                            ondismiss:
                                function() {

                                    payButton.disabled =
                                        false;

                                    payButton.innerText =
                                        "Pay with Razorpay";

                                }

                        }

                    };


                    const razorpay =
                        new Razorpay(options);


                    razorpay.on(
                        "payment.failed",
                        function(response) {

                            console.error(
                                response.error
                            );

                            alert(
                                "Payment failed. Please try again."
                            );

                            payButton.disabled =
                                false;

                            payButton.innerText =
                                "Pay with Razorpay";

                        }
                    );


                    razorpay.open();


                } catch (error) {

                    console.error(error);

                    alert(
                        "Unable to start payment. Please try again."
                    );

                    payButton.disabled =
                        false;

                    payButton.innerText =
                        "Pay with Razorpay";

                }

            }
        );


        /*
         * Send successful payment details
         * to our backend.
         */

        function submitPaymentVerification(
            paymentResponse,
            shippingAddress) {


            const form =
                document.createElement("form");

            form.method = "POST";

            form.action =
                "${pageContext.request.contextPath}/verify-razorpay-payment";


            const fields = {

                razorpay_payment_id:
                    paymentResponse.razorpay_payment_id,

                razorpay_order_id:
                    paymentResponse.razorpay_order_id,

                razorpay_signature:
                    paymentResponse.razorpay_signature,

                shippingAddress:
                    shippingAddress

            };


            for (
                const key in fields
            ) {

                const input =
                    document.createElement("input");

                input.type = "hidden";

                input.name = key;

                input.value =
                    fields[key];

                form.appendChild(input);

            }


            document.body.appendChild(form);

            form.submit();

        }

    </script>

</body>

</html>