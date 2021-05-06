/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-06 14:02:58
 * @LastEditTime: 2021-05-06 15:50:30
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/model/UserInfo.dart';
import 'package:flutter/cupertino.dart';
import '../utils/preference.dart';

class User with ChangeNotifier {
  UserInfo userInfo = new UserInfo();

  User() {
    PreferenceUtils.getJSON(PreferencesKey.USER_INFO).then((data) {
      userInfo = _createUserInfo(data);
      notifyListeners();
    });
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

  setUserInfo(data) {
    var tmp = _createUserInfo(data);
    userInfo = tmp;
    PreferenceUtils.saveJSON(PreferencesKey.USER_INFO, tmp);

    notifyListeners();
  }
}
