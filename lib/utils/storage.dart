import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    print("Storage init");
    return _prefsInstance;
  }

  static String getString(String key, [String? defValue]) {
    return _prefsInstance!.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static int getInteger(String key, [String? defValue]) {
    return _prefsInstance!.getInt(key) ?? defValue as int? ?? 0;
  }

  static Future<bool> setInteger(String key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key, value);
  }
}
