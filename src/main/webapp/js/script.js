/**
 * 
 */let cartCount = 0;

function addToCart(productName) {

    cartCount++;

    document.getElementById("cartCount").innerText = cartCount;

    alert(productName + " added to cart!");
}


function searchProduct() {

    const search = document
        .getElementById("searchInput")
        .value
        .trim();

    if (search === "") {
        alert("Please enter a product name.");
        return;
    }

    alert("Searching for: " + search);
}


function subscribe() {

    const email = document
        .getElementById("email")
        .value
        .trim();

    if (email === "") {
        alert("Please enter your email.");
        return;
    }

    alert("Thank you for subscribing!");

    document.getElementById("email").value = "";
}