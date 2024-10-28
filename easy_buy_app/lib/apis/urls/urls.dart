class Urls {
  static String serverUrl = 'http://192.168.30.216:8000';
// AUTH APIS
  static String authUrl = '$serverUrl/api/accounts';
  static String products = '$serverUrl/api/product';

  static String registerUserUrl = '$authUrl/register/';

  static String signinUserUrl = '$authUrl/login/';

  static String verifyEmailUrl = '$authUrl/verify-email/';

  static String getCategoriesUrl = '$products/categories';
  static String getProductsUrl = '$products/products';
}
