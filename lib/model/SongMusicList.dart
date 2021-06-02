/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-07 15:40:01
 * @LastEditTime: 2021-06-02 14:12:56
 * @LastEditors: Walker
 */

import 'MusicInfo.dart';

class SongMusicListModel {
  String title = "";
  String btnText = "";
  List<List<SongMusic>> musicList = [];

  SongMusicListModel.fromJson(Map<String, dynamic> jsonstr) {
    this.btnText = jsonstr["uiElement"]["button"]["text"];
    this.title = jsonstr["uiElement"]["subTitle"]["title"];

    this.musicList = List<List<SongMusic>>.from(jsonstr['creatives'].map(
        (ele) => List<SongMusic>.from(
            ele['resources'].map((element) => SongMusic.fromJson(element)))));
  }
}

class SongMusic extends MusicInfo {
  String descript = "";

  SongMusic.fromJson(Map<String, dynamic> jsonstr) {
    this.id = jsonstr["resourceExtInfo"]["songData"]["id"];
    this.musicName = jsonstr["uiElement"]["mainTitle"]["title"];
    this.singerName = jsonstr["resourceExtInfo"]["artists"][0]["name"];
    this.descript = jsonstr["uiElement"]["subTitle"]?["title"] ?? "";
    this.bgImgUrl = jsonstr["resourceExtInfo"]["artists"][0]["img1v1Url"];
    this.iconUrl = jsonstr["uiElement"]["image"]["imageUrl"];
  }
}
