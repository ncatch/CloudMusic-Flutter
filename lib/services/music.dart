/*
 * @Description: 歌曲相关接口
 * @Author: nocatch
 * @Date: 2021-04-09 14:28:07
 * @LastEditTime: 2021-05-24 16:52:35
 * @LastEditors: Walker
 */
import '../libs/config.dart';

import '../utils/http.dart';

Future<List<dynamic>> getMusicUrl(id, [br = '999000']) {
  return DioUtil.dio
      .get(server + '/song/url?id=' + id.toString() + '&br=' + br)
      .then((value) {
    return value.data['data'];
  });
}

Future<dynamic> getMusicLyric(id) {
  return DioUtil.dio.get(server + '/lyric?id=' + id.toString()).then((value) {
    return value.data;
  });
}

Future<List<dynamic>> getMusicDetail(List<int> ids) {
  return DioUtil.dio
      .get(server + '/song/detail?ids=' + ids.join(',').toString())
      .then((value) {
    return value.data['songs'];
  });
}

Future<dynamic> getLikeList(id) {
  return DioUtil.dio.get('/likelist?uid=$id').then((value) {
    return value.data['songs'];
  });
}
