/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-06 17:39:01
 * @LastEditTime: 2021-04-30 11:49:48
 * @LastEditors: Walker
 */
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesKey {
  static const HOME_BANNER = 'home_banner'; // 当前主题 index
  static const HOME_SONGLIST = 'home_songlist'; // 刷新头部跟随
  static const PLAY_INFO = 'play_music_list'; // 播放信息
}

/// shared_preferences 管理类
class PreferenceUtils {
  static var _instance = null;

  static Future<SharedPreferences> get instance async {
    if (_instance != null) return _instance;
    return await init();
  }

  static init() async {
    _instance = await SharedPreferences.getInstance();
    return _instance;
  }

  static saveInteger(String key, int value) async =>
      (await instance).setInt(key, value);

  static saveString(String key, String value) async =>
      (await instance).setString(key, value);

  static saveBool(String key, bool value) async =>
      (await instance).setBool(key, value);

  static saveDouble(String key, double value) async =>
      (await instance).setDouble(key, value);

  static saveStringList(String key, List<String> value) async =>
      (await instance).setStringList(key, value);

  static Future<int> getInteger(String key, [int defaultValue = 0]) async {
    var value = (await instance).getInt(key);
    return value ?? defaultValue;
  }

  static Future<String> getString(String key,
      [String defaultValue = '']) async {
    var value = (await instance).getString(key);
    return value ?? defaultValue;
  }

  static Future<bool> getBool(String key, [bool defaultValue = false]) async {
    var value = (await instance).getBool(key);
    return value ?? defaultValue;
  }

  static Future<double> getDouble(String key,
      [double defaultValue = 0.0]) async {
    var value = (await instance).getDouble(key);
    return value ?? defaultValue;
  }

  static Future<List<String>> getStringList(String key,
      [List<String> defaultValue = const <String>[]]) async {
    var value = (await instance).getStringList(key);
    return value ?? defaultValue;
  }
}
