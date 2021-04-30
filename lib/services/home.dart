/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-04-30 19:19:16
 * @LastEditors: Walker
 */
import 'dart:convert';

import 'package:dio/dio.dart';

import '../utils/http.dart';
import '../libs/config.dart';

import '../utils/preference.dart';

Future<List<dynamic>> getBanner(type, [bool disableCache = true]) async {
  // 取缓存
  // if (!disableCache) {
  //   var cache = await PreferenceUtils.getString(PreferencesKey.HOME_BANNER);

  //   if (cache != '') {
  //     return jsonDecode(cache);
  //   }
  // }

  return DioUtil.dio.post(server + '/banner/get', data: {
    'clientType': type,
  }).then((value) {
    var banners = value.data['banners'];

    // PreferenceUtils.saveString(PreferencesKey.HOME_BANNER, jsonEncode(banners));

    return banners;
  });
}

Future<List<dynamic>> getRecommendSongList(int limit,
    [bool disableCache = true]) async {
  // 取缓存
  // if (!disableCache) {
  //   var cache = await PreferenceUtils.getString(PreferencesKey.HOME_SONGLIST);

  //   if (cache != '') {
  //     return jsonDecode(cache);
  //   }
  // }

  return await DioUtil.dio
      .post(server + '/personalized?limit=' + limit.toString())
      .then((value) {
    // PreferenceUtils.saveString(
    //     PreferencesKey.HOME_SONGLIST, jsonEncode(value.data['result']));

    return value.data['result'];
  });
}
