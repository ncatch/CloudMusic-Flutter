/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-06 14:02:58
 * @LastEditTime: 2021-05-28 16:38:28
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/model/Level.dart';
import 'package:cloudmusic_flutter/model/UserInfo.dart';
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:flutter/cupertino.dart';
import '../utils/preference.dart';

class User with ChangeNotifier {
  UserInfo userInfo = new UserInfo();
  Level levelInfo = new Level();

  User() {
    initUserInfo();
  }

  init() {
    PreferenceUtils.getJSON(PreferencesKey.USER_INFO).then((data) {
      if (data != null) {
        userInfo = UserInfo.fromJson(data);
        initUserInfo();
        notifyListeners();
      }
    });
  }

  clearUserInfo() {
    PreferenceUtils.saveString(PreferencesKey.USER_INFO, '');
    userInfo = new UserInfo();

    notifyListeners();
  }

  initUserInfo([data]) {
    // data['cookie']
    // data['token']
    // data['bindings']
    // data['account']

    if (data != null) {
      userInfo = UserInfo.fromJson(data['profile']);

      PreferenceUtils.saveJSON(PreferencesKey.USER_INFO, data['profile']);
      PreferenceUtils.saveString(PreferencesKey.USER_COOKIE, data['cookie']);
      PreferenceUtils.saveString(PreferencesKey.USER_TOKEN, data['token']);
      notifyListeners();
    }

    if (userInfo.userId > 0) {
      // 获取用户等级信息
      getUserLevel().then((res) {
        if (res['code'] == 200) {
          levelInfo = Level.fromJson(res['data']);
          userInfo.level = levelInfo.level;
          notifyListeners();
        }
      });
      // 用户详情
      // getUserDetail(userInfo.userId).then((res) {});
    }
  }
}
