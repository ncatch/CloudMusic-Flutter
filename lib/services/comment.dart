/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-19 17:07:38
 * @LastEditTime: 2021-05-19 17:17:14
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/utils/http.dart';

Future<dynamic> comment(commentType, type, content, {id = '', commentId = ''}) {
  return DioUtil.dio
      .get(
          '/comment?t=$commentType&type=$type&id=$id&content=$content&commentId=$commentId')
      .then((value) {
    return value.data;
  });
}

Future<dynamic> likeComment(id, cid, likeType, type) {
  return DioUtil.dio
      .get('/comment/like?id=$id&cid=$cid&t=$likeType&type=$type')
      .then((value) {
    return value.data;
  });
}
