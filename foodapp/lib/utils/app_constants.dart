class AppConstants{
  static const String APP_NAME = "FoodApp";
  static const int APP_VERSION = 1;


  
  static const String BASE_URL = "Your Base URL goes here";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  static const String DRINKS_URI = "/api/v1/products/drinks";
  static const String BREAKFAST_URI = "/api/v1/products/breakfast";
  static const String UPLOAD_URL = "/uploads/";

  static const String TOKEN="";
  static const String PHONE="";
  static const String PASSWORD="";
  static const String EMAIL="";

  //user and auth end points
  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO_URI = "/api/v1/customer/info";

  //address and geocode
  static const String USER_ADDRESS = "user_address";
  static const String ADD_USER_ADDRESS = "/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI = "/api/v1/customer/address/list";

  //config
  static const String GEOCODE_URI = "/api/v1/config/geocode-api";
  static const String ZONE_URI = "/api/v1/config/get-zone-id";
  static const String SEARCH_LOCATION_URI = "/api/v1/config/place-api-autocomplete";
  static const String PLACES_DETAILS_URI = "/api/v1/config/place-api-details";

  //orders
  static const String PLACE_ORDER_URI = "/api/v1/customer/order/place";

  static const String CART_LIST = "Cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";

}