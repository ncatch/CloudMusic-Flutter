/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-28 18:03:38
 * @LastEditTime: 2021-04-30 13:51:03
 * @LastEditors: Walker
 */

import '../libs/config.dart';

// TODO 播放model 歌曲名 歌手名 背景url id

class PlayInfo {
  MusicInfo info = new MusicInfo();
  int index = 0;
  List<MusicInfo> list = [];

  PlayInfo({MusicInfo? info, int index = 0, List<MusicInfo>? list}) {
    this.info = info ?? new MusicInfo();
    this.index = index;
    this.list = list ?? [];
  }
}

class MusicInfo {
  String musicName = "";
  String singerName = "";
  String bgImgUrl = "";
  String iconUrl = "";
  int id = 0;

  MusicInfo(
      {int id = 0,
      String musicName = "",
      String singerName = "",
      String iconUrl = play_img_url_default,
      String bgImgUrl = play_img_url_default}) {
    this.id = id;
    this.musicName = musicName;
    this.singerName = singerName;
    this.bgImgUrl = bgImgUrl;
    this.iconUrl = iconUrl;
  }

  MusicInfo.fromJson(Map<String, dynamic> jsonstr) {
    this.id = jsonstr["id"];
    this.musicName = jsonstr["musicName"];
    this.singerName = jsonstr["singerName"];
    this.bgImgUrl = jsonstr["bgImgUrl"];
    this.iconUrl = jsonstr["iconUrl"];
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = this.id;
    map["musicName"] = this.musicName;
    map["singerName"] = this.singerName;
    map["bgImgUrl"] = this.bgImgUrl;
    map["iconUrl"] = this.iconUrl;
    return map;
  }
}
