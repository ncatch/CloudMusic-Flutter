/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-18 11:29:25
 * @LastEditTime: 2021-05-18 11:41:13
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/model/UserInfo.dart';

class Comments {
  int total = 0;
  List<CommentInfo> commentList = [];
  List<CommentInfo> hotCommentList = [];

  Comments() {}

  Comments.fromData(Map<String, dynamic> data) {
    this.total = data['total'];

    this.commentList = List<CommentInfo>.from(
        data['comments'].map<CommentInfo>((ele) => CommentInfo.fromData(ele)));
    this.hotCommentList = data['hotComments'];
  }
}

class CommentInfo {
  String content = "";
  int time = 0;
  UserInfo user = new UserInfo();

  CommentInfo.fromData(Map<String, dynamic> data) {
    this.content = data['content'];
    this.time = data['time'];

    this.user = UserInfo.fromJson(data['user']);
  }
}
