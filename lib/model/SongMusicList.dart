/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-07 15:40:01
 * @LastEditTime: 2021-05-08 15:49:56
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/libs/config.dart';
import 'package:flutter/cupertino.dart';

class SongMusicListModel {
  String title = "";
  String btnText = "";
  List<List<SongMusic>> musicLists = [];

  SongMusicListModel.fromJson(Map<String, dynamic> jsonstr) {
    this.btnText = jsonstr["uiElement"]["button"]["text"];
    this.title = jsonstr["uiElement"]["subTitle"]["title"];

    this.musicLists = List<List<SongMusic>>.from(jsonstr['creatives'].map(
        (ele) => List<SongMusic>.from(
            ele['resources'].map((element) => SongMusic.fromJson(element)))));
  }
}

class SongMusic {
  String musicName = "";
  String singerName = "";
  String bgImgUrl = play_img_url_default;
  String iconUrl = play_img_url_default;
  String descript = "";
  int id = 0;

  SongMusic.fromJson(Map<String, dynamic> jsonstr) {
    this.id = jsonstr["resourceExtInfo"]["songData"]["id"];
    this.musicName = jsonstr["uiElement"]["mainTitle"]["title"];
    this.singerName = jsonstr["resourceExtInfo"]["artists"][0]["name"];
    this.descript = jsonstr["uiElement"]["subTitle"]?["title"] ?? "";
    this.bgImgUrl = jsonstr["resourceExtInfo"]["artists"][0]["img1v1Url"];
    this.iconUrl = jsonstr["uiElement"]["image"]["imageUrl"];
  }
}
