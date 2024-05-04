class GlobalToken {
  static String userToken = '';

  static setToken(String token) {
    userToken = token;
  }

  static String getToken() {
    return userToken;
  }
}
