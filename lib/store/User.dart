/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-06 14:02:58
 * @LastEditTime: 2021-05-14 11:28:41
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/libs/config.dart';
import 'package:cloudmusic_flutter/model/UserInfo.dart';
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:flutter/cupertino.dart';
import '../utils/preference.dart';

class User with ChangeNotifier {
  UserInfo userInfo = new UserInfo();
  var levelInfo;

  User() {
    initUserInfo();
  }

  init() {
    PreferenceUtils.getJSON(PreferencesKey.USER_INFO).then((data) {
      if (data != null) {
        userInfo = _createUserInfo(data);
        initUserInfo();
        notifyListeners();
      }
    });
  }

  UserInfo _createUserInfo(data) {
    var tmp = UserInfo();
    tmp.userId = data["userId"];
    tmp.nickname = data["nickname"];
    tmp.vipType = data["vipType"];
    tmp.userType = data["userType"];
    tmp.avatarUrl = data["avatarUrl"] ?? play_img_url_default;
    tmp.backgroundUrl = data["backgroundUrl"] ?? play_img_url_default;
    return tmp;
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
      var tmp = _createUserInfo(data['profile']);
      userInfo = tmp;
      notifyListeners();
      PreferenceUtils.saveJSON(PreferencesKey.USER_INFO, tmp);
      PreferenceUtils.saveString(PreferencesKey.USER_COOKIE, data['cookie']);
      PreferenceUtils.saveString(PreferencesKey.USER_TOKEN, data['token']);
    }

    if (userInfo.userId > 0) {
      // 获取用户等级信息
      getUserLevel().then((res) {
        levelInfo = res;
        notifyListeners();
      });
      // 用户详情
      getUserDetail(userInfo.userId).then((res) {});
    }
  }
}
