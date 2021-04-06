/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-06 17:39:01
 * @LastEditTime: 2021-04-06 19:07:26
 * @LastEditors: Walker
 */
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesKey {
  static const HOME_BANNER = 'home_banner'; // 当前主题 index
  static const HOME_SONGLIST = 'home_songlist'; // 刷新头部跟随
}

/// shared_preferences 管理类
class PreferenceUtils {
  static var _instance;

  static SharedPreferences get instance {
    return _instance;
  }

  static init() async {
    _instance = await SharedPreferences.getInstance();
    return _instance;
  }

  static saveInteger(String key, int value) => _instance.setInt(key, value);

  static saveString(String key, String value) =>
      _instance.setString(key, value);

  static saveBool(String key, bool value) => _instance.setBool(key, value);

  static saveDouble(String key, double value) =>
      _instance.setDouble(key, value);

  static saveStringList(String key, List<String> value) =>
      _instance.setStringList(key, value);

  static int getInteger(String key, [int defaultValue = 0]) {
    var value = _instance.getInt(key);
    return value ?? defaultValue;
  }

  static String getString(String key, [String defaultValue = '']) {
    var value = _instance.getString(key);
    return value ?? defaultValue;
  }

  static bool getBool(String key, [bool defaultValue = false]) {
    var value = _instance.getBool(key);
    return value ?? defaultValue;
  }

  static double getDouble(String key, [double defaultValue = 0.0]) {
    var value = _instance.getDouble(key);
    return value ?? defaultValue;
  }

  static List<String> getStringList(String key,
      [List<String> defaultValue = const <String>[]]) {
    var value = _instance.getStringList(key);
    return value ?? defaultValue;
  }
}
