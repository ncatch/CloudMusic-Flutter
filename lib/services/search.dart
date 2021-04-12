/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-08 14:16:20
 * @LastEditTime: 2021-04-08 15:13:35
 * @LastEditors: Walker
 */
import 'dart:convert';
import 'package:dio/dio.dart';

import '../utils/http.dart';
import '../libs/config.dart';
import '../libs/enums.dart';

Future<dynamic> getDefaultSearchKey() {
  return DioUtil.dio.post(server + '/search/default').then((value) {
    return value.data['data'];
  });
}

// 获取热搜列表
Future<List<dynamic>> getHotList() {
  return DioUtil.dio.post(server + '/search/hot').then((value) {
    return value.data['result']['hots'];
  });
}

// 获取热搜列表详细
Future<List<dynamic>> getHotListDetail() {
  return DioUtil.dio.post(server + '/search/hot/detail').then((value) {
    return value.data['data'];
  });
}

// 搜索
Future<List<dynamic>> searchByKeywords(keywords, [type = 'mobile']) {
  return DioUtil.dio.post(server + '/search/suggest', data: {
    type: type,
    keywords: keywords,
  }).then((value) {
    return value.data['result']['songs'];
  });
}

// 搜索
Future<List<dynamic>> searchSong(keywords, [type = 'mobile']) {
  return DioUtil.dio.get(server + '/search?keywords=' + keywords).then((value) {
    return value.data['result']['songs'];
  });
}
