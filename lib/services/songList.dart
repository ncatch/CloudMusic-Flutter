/*
 * @Description: 歌单相关接口
 * @Author: Walker
 * @Date: 2021-04-30 19:18:22
 * @LastEditTime: 2021-05-14 15:46:26
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

Future<dynamic> getPlayListComment(id, [limit = 20, offset = "", before = ""]) {
  return DioUtil.dio
      .get(
          '/comment/playlist?id=$id&limit=$limit&offset=$offset&bofore=$before')
      .then((value) {
    return value.data;
  });
}
