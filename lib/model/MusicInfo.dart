/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-11 16:45:47
 * @LastEditTime: 2021-06-09 16:24:23
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/libs/config.dart';

class MusicInfo {
  String musicName = "";
  String singerName = "";
  String bgImgUrl = "";
  String iconUrl = "";
  String tip = "";
  String localUrl = "";
  int id = 0;

  MusicInfo(
      {int id = 0,
      String musicName = "",
      String singerName = "",
      String iconUrl = play_img_url_default,
      String bgImgUrl = play_img_url_default,
      String tip = ""}) {
    this.id = id;
    this.musicName = musicName;
    this.singerName = singerName;
    this.bgImgUrl = bgImgUrl;
    this.iconUrl = iconUrl;
    this.tip = tip;
  }

  MusicInfo.fromJson(Map<String, dynamic> jsonstr) {
    this.id = jsonstr["id"];
    this.musicName = jsonstr["musicName"];
    this.singerName = jsonstr["singerName"];
    this.bgImgUrl = jsonstr["bgImgUrl"];
    this.iconUrl = jsonstr["iconUrl"];
    this.tip = jsonstr["tip"];
    this.localUrl = jsonstr["localUrl"] ?? "";
  }

  MusicInfo.fromData(Map<String, dynamic> data) {
    this.id = data['id'];
    if (data['al'] != null) {
      this.iconUrl = data['al']['picUrl'];
      this.tip = data['al']['name'];
    } else if (data['album'] != null) {
      this.iconUrl = data['album']['picUrl'];
      this.tip = data['album']['name'];
    }

    if (data['ar'] != null) {
      this.singerName = data['ar'][0]['name'];
    } else if (data['artists'] != null) {
      this.singerName = data['artists'][0]['name'];
    }

    this.musicName = data['name'];

    this.bgImgUrl = data["bgImgUrl"] ?? play_img_url_default;
    this.localUrl = data["localUrl"] ?? "";
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = this.id;
    map["musicName"] = this.musicName;
    map["singerName"] = this.singerName;
    map["bgImgUrl"] = this.bgImgUrl;
    map["iconUrl"] = this.iconUrl;
    map["tip"] = this.tip;
    map["localUrl"] = this.localUrl;
    return map;
  }
}
