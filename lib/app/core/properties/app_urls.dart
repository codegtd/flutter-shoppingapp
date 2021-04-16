const URL_FIREBASE =
    "https://my-first-shop-app-1db95-default-rtdb.firebaseio.com";
// const URL_RETROFIT =
//     "https://my-first-shop-app-1db95-default-rtdb.firebaseio.com/";

const COLLECTION_PRODUCTS = "products";
const COLLECTION_ORDERS = "orders";
const COLLECTION_CART_ITEMS = "cart-items";
const EXTENSION = ".json";

const PRODUCTS_URL_HTTP = "$URL_FIREBASE/$COLLECTION_PRODUCTS$EXTENSION";
const ORDERS_URL_HTTP = "$URL_FIREBASE/$COLLECTION_ORDERS$EXTENSION";
const CART_ITEM_URL_HTTP = "$URL_FIREBASE/$COLLECTION_CART_ITEMS$EXTENSION";

const PRODUCTS_URL_RETROFIT = "/$COLLECTION_PRODUCTS";
const ORDERS_URL_RETROFIT = "/$COLLECTION_ORDERS";
const CART_ITEM_URL_RETROFIT = "/$COLLECTION_CART_ITEMS";
