/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-18 11:29:25
 * @LastEditTime: 2021-05-19 17:10:43
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
  int commentId = 0;
  String content = "";
  int likedCount = 0;
  bool liked = false;
  int time = 0;
  UserInfo user = new UserInfo();
  List<BeReplied> beReplieds = [];

  CommentInfo.fromData(Map<String, dynamic> data) {
    this.commentId = data['commentId'];
    this.content = data['content'];
    this.time = data['time'];
    this.likedCount = data['likedCount'];
    this.liked = data['liked'];

    this.beReplieds = List<BeReplied>.from(
        data['beReplied'].map<BeReplied>((ele) => BeReplied.fromData(ele)));

    this.user = UserInfo.fromJson(data['user']);
  }
}

class BeReplied {
  String content = "";
  int beRepliedCommentId = 0;

  UserInfo user = new UserInfo();

  BeReplied() {}

  BeReplied.fromData(Map<String, dynamic> data) {
    this.beRepliedCommentId = data['beRepliedCommentId'];
    this.content = data['content'];

    this.user = UserInfo.fromJson(data['user']);
  }
}
