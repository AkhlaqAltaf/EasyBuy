class Urls {
  static String serverUrl = 'https://d489-37-111-166-199.ngrok-free.app';
// AUTH APIS
  static String authUrl = '$serverUrl/api/accounts';
  static String products = '$serverUrl/api/product';

  static String registerUserUrl = '$authUrl/register/';

  static String signinUserUrl = '$authUrl/login/';

  static String verifyEmailUrl = '$authUrl/verify-email/';

  static String getCategoriesUrl = '$products/categories';
  static String getProductsUrl = '$products/products';
}
