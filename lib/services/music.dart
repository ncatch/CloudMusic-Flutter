/*
 * @Description: 
 * @Author: nocatch
 * @Date: 2021-04-09 14:28:07
 * @LastEditTime: 2021-04-09 14:33:35
 * @LastEditors: Walker
 */
import 'dart:convert';

import 'package:dio/dio.dart';
import '../libs/config.dart';

import '../utils/http.dart';

Future<Map> getMusicUrl(id) {
  return DioUtil.dio
      .get(server + '/song/url?id=' + id.toString())
      .then((value) {
    return value.data['data'];
  });
}
