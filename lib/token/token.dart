class GlobalToken {
  static final GlobalToken _instance = GlobalToken._internal();
  String _userToken = '';

  factory GlobalToken() {
    return _instance;
  }

  GlobalToken._internal();

  static String get userToken => _instance._userToken;

  static set userToken(String token) {
    _instance._userToken = token;
  }
}
