/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-11 16:45:25
 * @LastEditTime: 2021-05-12 11:06:23
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/libs/config.dart';
import 'package:cloudmusic_flutter/model/MusicInfo.dart';

class PlayListModel {
  String title = "";
  String headBgUrl = "";
  String coverImgUrl = "";
  String descript = "";
  int playCount = 0;
  var creator = {}; // 创建人
  var tags = [];
  List<MusicInfo> musicList = [];
  List<dynamic> subscribers = [];

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

    this.creator = creator ?? {};
  }

  PlayListModel.fromData(Map<String, dynamic> data) {
    this.headBgUrl = data['backgroundCoverUrl'] ?? "";
    this.coverImgUrl = data['coverImgUrl'] ?? play_img_url_default;
    this.descript = data['description'];
    this.title = data['name'];
    this.tags = data['tags'];
    this.playCount = data['playCount'];

    this.subscribers = data['subscribers'];
    this.creator = data['creator'];

    this.musicList = List<MusicInfo>.from(
        data['tracks'].map<MusicInfo>((ele) => MusicInfo.fromData(ele)));
  }
}
