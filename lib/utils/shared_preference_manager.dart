import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  late SharedPreferences _preferences;

  PreferenceManager._privateConstructor();

  static final PreferenceManager instance =
      PreferenceManager._privateConstructor();

  init() async {
    debugPrint('Shared prefs Initialized');
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> clear() async {
    return await _preferences.clear();
  }

  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  bool getBool(String key) {
    return _preferences.getBool(key) ?? false;
  }

  String getString(String key) {
    return _preferences.getString(key) ?? '';
  }

  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }
}
