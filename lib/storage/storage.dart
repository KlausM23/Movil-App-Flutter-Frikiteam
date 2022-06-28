import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage() {}
  String nameKey = 'token';
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(nameKey, token);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(nameKey)!;
  }
}
