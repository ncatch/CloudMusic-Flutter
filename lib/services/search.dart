/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-08 14:16:20
 * @LastEditTime: 2021-06-11 14:02:56
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/model/MusicInfo.dart';

import '../utils/http.dart';
import '../libs/config.dart';

Future<dynamic> getDefaultSearchKey() {
  return DioUtil.dio.post(server + '/search/default').then((value) {
    return value.data['data'];
  });
}

// 获取热搜列表
Future<List<dynamic>> getHotList() {
  return DioUtil.dio.post(server + '/search/hot').then((value) {
    return value.data['result']['hots'];
  });
}

// 获取热搜列表详细
Future<List<dynamic>> getHotListDetail() {
  return DioUtil.dio.post(server + '/search/hot/detail').then((value) {
    return value.data['data'];
  });
}

// 搜索
Future<List<dynamic>> searchByKeywords(keywords, [type = 'mobile']) {
  return DioUtil.dio.post(server + '/search/suggest', data: {
    type: type,
    keywords: keywords,
  }).then((value) {
    return value.data['result']['songs'];
  });
}

// 搜索
Future<List<MusicInfo>> searchSong(keywords, [type = 'mobile']) {
  return DioUtil.dio.get(server + '/search?keywords=' + keywords).then((value) {
    List<MusicInfo> result = [];

    for (var i = 0; i < value.data['result']['songs'].length; i++) {
      var info = value.data['result']['songs'][i];

      MusicInfo tmp = new MusicInfo(id: info['id'], musicName: info['name']);

      if (info != null &&
          info['artists'] != null &&
          info['artists'][0] != null) {
        if (info['artists'][0]['img1v1Url'] != null) {
          tmp.bgImgUrl = info['artists'][0]['img1v1Url'];
        }
        if (info['artists'][0]['name'] != null) {
          tmp.singerName = info['artists'][0]['name'];
        }
      }

      result.add(tmp);
    }

    return result;
  });
}
