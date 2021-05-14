/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-06 13:51:53
 * @LastEditTime: 2021-05-14 11:36:11
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

Future<dynamic> getUserPlayList(id, [offset]) {
  return DioUtil.dio.get('/user/playlist?uid=$id').then((value) {
    return value.data;
  });
}

Future<dynamic> getUserLevel() {
  return DioUtil.dio.get(server + '/user/level').then((value) {
    return value.data;
  });
}
