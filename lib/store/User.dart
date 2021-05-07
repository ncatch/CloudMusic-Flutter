/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-06 14:02:58
 * @LastEditTime: 2021-05-07 11:46:06
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/model/UserInfo.dart';
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:flutter/cupertino.dart';
import '../utils/preference.dart';

class User with ChangeNotifier {
  UserInfo userInfo = new UserInfo();
  var levelInfo;

  User() {
    PreferenceUtils.getJSON(PreferencesKey.USER_INFO).then((data) {
      userInfo = _createUserInfo(data);
      notifyListeners();
    });

    initUserInfo();
  }

  UserInfo _createUserInfo(data) {
    var tmp = UserInfo();
    tmp.userId = data["userId"];
    tmp.nickname = data["nickname"];
    tmp.vipType = data["vipType"];
    tmp.userType = data["userType"];
    tmp.avatarUrl = data["avatarUrl"];
    tmp.backgroundUrl = data["backgroundUrl"];
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

    // 获取用户等级信息
    getUserLevel().then((res) {
      levelInfo = res;
      notifyListeners();
    });
    // 获取用户歌单
  }
}
