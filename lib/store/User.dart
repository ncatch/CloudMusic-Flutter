/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-06 14:02:58
 * @LastEditTime: 2021-07-05 15:43:58
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/libs/extends/Toast.dart';
import 'package:cloudmusic_flutter/model/Level.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/model/UserInfo.dart';
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:flutter/cupertino.dart';
import '../utils/preference.dart';

class User with ChangeNotifier {
  UserInfo userInfo = new UserInfo();
  Level levelInfo = new Level();
  List<PlayListModel> playList = [];

  User() {
    initUserInfo();
  }

  Future<UserInfo> init() {
    return PreferenceUtils.getJSON(PreferencesKey.USER_INFO).then((data) {
      if (data != null) {
        userInfo = UserInfo.fromJson(data);
        initUserInfo();
        notifyListeners();
      }
      return userInfo;
    });
  }

  clearUserInfo() {
    PreferenceUtils.saveString(PreferencesKey.USER_INFO, '');
    PreferenceUtils.saveString(PreferencesKey.USER_COOKIE, '');
    PreferenceUtils.saveString(PreferencesKey.USER_TOKEN, '');

    userInfo = new UserInfo();
    levelInfo = new Level();
    playList = [];

    notifyListeners();
  }

  checkLogin() {
    if (userInfo.userId == 0) {
      Toast('请先登录');
      return false;
    }

    return true;
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
      // 获取用户歌单
      getUserPlayList(userInfo.userId).then((res) {
        if (res['code'] == 200) {
          playList = List<PlayListModel>.from(res['playlist']
              .map<PlayListModel>((ele) => PlayListModel.fromData(ele)));
          notifyListeners();
        }
      });
    }
  }
}
