/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-04-06 14:07:07
 * @LastEditors: Walker
 */
import 'package:dio/dio.dart';

import '../utils/http.dart';
import '../libs/config.dart';

Future<Response> getBanner(type) async {
  return await DioUtil.dio.post(server + '/banner/get', data: {
    'clientType': type,
  });
}

Future<Response> getRecommendSongList(int limit) async {
  return await DioUtil.dio.post(server + '/personalized?limit=' + limit.toString());
}
