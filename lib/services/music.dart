/*
 * @Description: 
 * @Author: nocatch
 * @Date: 2021-04-09 14:28:07
 * @LastEditTime: 2021-04-28 15:13:31
 * @LastEditors: Walker
 */
import 'dart:convert';

import 'package:dio/dio.dart';
import '../libs/config.dart';

import '../utils/http.dart';

Future<List<dynamic>> getMusicUrl(id, [br = '999000']) {
  return DioUtil.dio
      .get(server + '/song/url?id=' + id.toString() + '&br=' + br)
      .then((value) {
    return value.data['data'];
  });
}

Future<dynamic> getMusicLyric(id) {
  return DioUtil.dio.get(server + '/lyric?id=' + id.toString()).then((value) {
    return value.data;
  });
}
