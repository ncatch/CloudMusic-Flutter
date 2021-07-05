/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-06 13:51:53
 * @LastEditTime: 2021-07-02 10:38:48
 * @LastEditors: Walker
 */

import '../utils/http.dart';
import '../libs/config.dart';

Future<dynamic> loginByPhone(phone, password) {
  return DioUtil.dio
      .get(server + '/login/cellphone?phone=$phone&password=$password')
      .then((value) {
    return value.data;
  });
}

Future<dynamic> loginByEmail(email, password) {
  return DioUtil.dio
      .get(server + '/login?email=$email&password=$password')
      .then((value) {
    return value.data;
  });
}

Future<dynamic> getUserDetail(id) {
  return DioUtil.dio.get('/user/detail?uid=$id').then((value) {
    return value.data;
  });
}

Future<dynamic> getUserSubCount() {
  return DioUtil.dio.get('/user/subcount').then((value) {
    return value.data;
  });
}

// 获取用户歌单
Future<dynamic> getUserPlayList(id, [offset]) {
  return DioUtil.dio.get('/user/playlist?uid=$id').then((value) {
    return value.data;
  });
}

// 获取用户等级信息
Future<dynamic> getUserLevel() {
  return DioUtil.dio.get(server + '/user/level').then((value) {
    return value.data;
  });
}

// 关注用户
Future<dynamic> attentionUser(int id, int type) {
  return DioUtil.dio.get('/follow?id=$id&t=$type').then((value) {
    return value.data;
  });
}

// 用户动态
Future<dynamic> getUserEvent(id, {limit = 20, lasttime = ''}) {
  return DioUtil.dio
      .get('/user/event?uid=$id&limit=$limit&lasttime=$lasttime')
      .then((value) {
    return value.data;
  });
}

// 音乐日历
Future<dynamic> getCalendar(startTime, endTime) {
  return DioUtil.dio
      .get('/calendar?startTime=$startTime&endTime=$endTime')
      .then((value) {
    return value.data;
  });
}

// FM
Future<dynamic> getPersonalFM() {
  return DioUtil.dio.get('/personal_fm').then((value) {
    return value.data;
  });
}

// 获取用户关注列表
Future<dynamic> getUserFollows(uid, [offset = 0]) {
  return DioUtil.dio.get('/user/follows?uid=$uid&offset=$offset').then((value) {
    return value.data;
  });
}

// 获取用户粉丝列表
Future<dynamic> getUserFolloweds(uid, [offset = 0, limit = 20]) {
  return DioUtil.dio
      .get('/user/followeds?uid=$uid&limit=$limit&offset=$offset')
      .then((value) {
    return value.data;
  });
}

// 获取用户收藏的专辑
Future<dynamic> getUserSublist([offset = 0, limit = 20]) {
  return DioUtil.dio
      .get('/album/sublist?limit=$limit&offset=$offset')
      .then((value) {
    return value.data;
  });
}
