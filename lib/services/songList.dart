/*
 * @Description: 歌单相关接口
 * @Author: Walker
 * @Date: 2021-04-30 19:18:22
 * @LastEditTime: 2021-05-14 14:36:37
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/utils/http.dart';

Future<dynamic> getPlayListById(id, [count = 8]) {
  return DioUtil.dio.post('/playlist/detail?id=$id&s=$count').then((value) {
    return value.data;
  });
}

Future<dynamic> subscribe(id, type) {
  return DioUtil.dio.get('/playlist/subscribe?id=$id&t=$type').then((value) {
    return value.data;
  });
}
