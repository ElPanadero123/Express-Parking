import 'package:shared_preferences/shared_preferences.dart';

class GlobalToken {
  static final GlobalToken _instance = GlobalToken._internal();
  static SharedPreferences? _prefs;
  static String? _userToken;

  GlobalToken._internal();

  // Proporciona un acceso público estático a la instancia
  static GlobalToken get instance => _instance;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _userToken = _prefs?.getString('userToken');
  }

  static String? get userToken => _userToken;

  static set userToken(String? token) {
    _userToken = token;
    if (token == null) {
      _prefs?.remove('userToken');
    } else {
      _prefs?.setString('userToken', token);
    }
  }
}
