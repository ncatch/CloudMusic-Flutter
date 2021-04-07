/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-04-07 19:24:51
 * @LastEditors: Walker
 */
import 'dart:convert';

import 'package:dio/dio.dart';

import '../utils/http.dart';
import '../libs/config.dart';

import '../utils/preference.dart';

Future<List<dynamic>> getBanner(type, [bool disableCache = false]) async {
  // 取缓存
  if (!disableCache) {
    var bannerHistory =
        await PreferenceUtils.getString(PreferencesKey.HOME_BANNER);

    if (bannerHistory != '') {
      return jsonDecode(bannerHistory);
    }
  }

  return DioUtil.dio.post(server + '/banner/get', data: {
    'clientType': type,
  }).then((value) {
    var banners = value.data['banners'];

    PreferenceUtils.saveString(PreferencesKey.HOME_BANNER, jsonEncode(banners));

    return banners;
  });
}

Future<Response> getRecommendSongList(int limit) async {
  return await DioUtil.dio
      .post(server + '/personalized?limit=' + limit.toString());
}
