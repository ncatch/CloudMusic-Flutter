/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-07 15:40:01
 * @LastEditTime: 2021-05-08 16:25:30
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/libs/config.dart';
import 'package:flutter/cupertino.dart';

import 'PlayInfo.dart';

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
