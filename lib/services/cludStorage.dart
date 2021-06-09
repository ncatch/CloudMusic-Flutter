/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-06-09 16:08:09
 * @LastEditTime: 2021-06-09 16:09:40
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/utils/http.dart';

Future<dynamic> getCloudInfo({limit: 20, offset: 0}) {
  return DioUtil.dio
      .get('/user/cloud?limit=$limit&offset=$offset')
      .then((value) {
    return value.data;
  });
}
