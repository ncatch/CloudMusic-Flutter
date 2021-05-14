/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-11 16:45:25
 * @LastEditTime: 2021-05-14 14:37:57
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/libs/config.dart';
import 'package:cloudmusic_flutter/model/Creator.dart';
import 'package:cloudmusic_flutter/model/MusicInfo.dart';
import 'package:cloudmusic_flutter/model/UserInfo.dart';

class PlayListModel {
  String title = "";
  String headBgUrl = "";
  String coverImgUrl = "";
  String descript = "";
  int playCount = 0;
  int subscribedCount = 0; // 收藏数
  int shareCount = 0; // 分享数
  int commentCount = 0; // 评论数
  int id = 0;
  bool subscribed = false;

  Creator creator = Creator(); // 创建人
  var tags = [];
  List<MusicInfo> musicList = [];
  List<UserInfo> subscribers = [];

  PlayListModel({
    String title = "",
    String headBgUrl = "",
    String coverImgUrl = play_img_url_default,
    String descript = "",
    int playCount = 0,
    creator,
  }) {
    this.title = title;
    this.descript = descript;
    this.playCount = playCount;

    this.headBgUrl = headBgUrl;
    this.coverImgUrl = coverImgUrl;

    this.creator = creator ?? Creator();
  }

  PlayListModel.fromData(Map<String, dynamic> data) {
    this.id = data['id'];
    this.headBgUrl = data['backgroundCoverUrl'] ?? "";
    this.coverImgUrl = data['coverImgUrl'] ?? play_img_url_default;
    this.descript = data['description'];
    this.title = data['name'];
    this.tags = data['tags'];
    this.playCount = data['playCount'];
    this.subscribedCount = data['subscribedCount'];
    this.shareCount = data['shareCount'];
    this.commentCount = data['commentCount'];
    this.subscribed = data['subscribed'] ?? false;

    this.creator = Creator.fromData(data['creator']);

    this.subscribers = List<UserInfo>.from((data['subscribers'] ?? [])
        .map<UserInfo>((ele) => UserInfo.fromJson(ele)));

    this.musicList = List<MusicInfo>.from((data['tracks'] ?? [])
        .map<MusicInfo>((ele) => MusicInfo.fromData(ele)));
  }
}
