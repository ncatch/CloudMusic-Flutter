/*
 * @Description: 歌单相关接口
 * @Author: Walker
 * @Date: 2021-04-30 19:18:22
 * @LastEditTime: 2021-06-11 14:58:28
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

Future<dynamic> getPlayListComment(id, {limit = 20, offset = "", before = ""}) {
  return DioUtil.dio
      .get(
          '/comment/playlist?id=$id&limit=$limit&offset=$offset&bofore=$before')
      .then((value) {
    return value.data;
  });
}

// 获取推荐歌单
Future<dynamic> getRecommendResource() {
  return DioUtil.dio.get('/recommend/resource').then((value) {
    return value.data;
  });
}

Future<dynamic> getRecommendSongs() {
  return DioUtil.dio.get('/recommend/songs').then((value) {
    return value.data;
  });
}
