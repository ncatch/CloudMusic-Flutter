/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-19 17:07:38
 * @LastEditTime: 2021-05-19 19:39:58
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/utils/http.dart';

Future<dynamic> getCommentList(
  id,
  type,
  sortType,
  pageNo, {
  pageSize = 20,
  cursor = "",
}) {
  return DioUtil.dio
      .get(
          '/comment/new?type=$type&id=$id&sortType=$sortType&cursor=$cursor&pageSize=$pageSize&pageNo=$pageNo')
      .then((value) {
    return value.data;
  });
}

Future<dynamic> comment(commentType, type, content, {id = '', commentId = ''}) {
  return DioUtil.dio
      .get(
          '/comment?t=$commentType&type=$type&id=$id&content=$content&commentId=$commentId')
      .then((value) {
    return value.data;
  });
}

Future<dynamic> likeComment(id, cid, likeType, type, {threadId = ''}) {
  return DioUtil.dio
      .get(
          '/comment/like?id=$id&cid=$cid&t=$likeType&type=$type&threadId=$threadId')
      .then((value) {
    return value.data;
  });
}
