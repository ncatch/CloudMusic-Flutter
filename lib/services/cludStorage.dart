/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-06-09 16:08:09
 * @LastEditTime: 2021-06-11 14:37:56
 * @LastEditors: Walker
 */

import 'dart:math';

import 'package:cloudmusic_flutter/utils/http.dart';

Future<dynamic> getCloudInfo({limit: 20, offset: 0, cache = false}) {
  String v = cache ? '' : '&v=${Random().nextInt(100000)}';

  return DioUtil.dio
      .get('/user/cloud?limit=$limit&offset=$offset$v')
      .then((value) {
    return value.data;
  });
}

Future<dynamic> deleteCloudMusic(ids) {
  return DioUtil.dio.get('/user/cloud/del?id=$ids').then((value) {
    return value.data;
  });
}
