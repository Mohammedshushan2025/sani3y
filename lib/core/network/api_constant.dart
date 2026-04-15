// URLS GOOGLE MAP
// ADD GOOGLE API KEY HERE & ANDROID & IOS

// const BASE_URL_AUTH = "https://api.apothecary.dafa.dev/v1/mobile";

const BASE_URL = "https://octane.curvaegypt.com/api/";

const LOGIN_URL_AUTH = "login";
const SIGNUP_URL_AUTH = "register";
const FORGET_PASSWORD_URL_AUTH = "send-code";
const OTP_URL_AUTH = "check-code";
const RESET_PASSWORD_URL_AUTH = "reset-password";

const HOME_URL = "home";
const OFFERS_URL = "offers";
const SEARCH_URL = "products";
String PRODUCT_DETAILS_URL(int? id) => "product/$id";
String CART_URL = "carts";
String DELETE_FROM_CART_URL(int? id) => "carts/$id";
String ADD_TO_CART_URL = "carts";
const ORDERS_URL = "orders";
const BLOGS_URL = "blogs";
const BRANDS_URL = "brands";
const CLUBS_URL = "clubs";
String Product_DETAILS_URL(int? id) => "product/$id";
String ADDRESSES_URL = "addresses";
String ADD_ORDER_URL = "orders";
String CITIES_URL(int? stateId) => "cities/$stateId";
String REGIONS_URL(int? cityId) => "regions/$cityId";
String STATES_URL = "states";
String ADD_ADDRESS_URL = "addresses";
String WISHLIST_URL = "wishlist";
String PROFILE_URL = "profile";
String CATEGORIES_URL = "categories";
String Sub_CATEGORIES_URL(int? categoryId) => "subcategories/$categoryId";
String SEASONS_URL = "seasons";
String CONTACTS_URL = "contacts";
String ABOUT_URL = "about";
String BRANCHES_URL = "branches";
