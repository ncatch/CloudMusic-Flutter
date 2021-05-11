/*
 * @Description: 歌单相关接口
 * @Author: Walker
 * @Date: 2021-04-30 19:18:22
 * @LastEditTime: 2021-05-11 16:15:26
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/libs/config.dart';
import 'package:cloudmusic_flutter/utils/http.dart';

Future<dynamic> getPlayListById(id, [count = 8]) {
  return DioUtil.dio
      .post(server + '/playlist/detail?id=$id&s=$count')
      .then((value) {
    return value.data;
  });
}
