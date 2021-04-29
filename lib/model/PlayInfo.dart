/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-28 18:03:38
 * @LastEditTime: 2021-04-29 14:27:36
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
  int id = 0;

  MusicInfo(
      {int id = 0,
      String musicName = "",
      String singerName = "",
      String bgImgUrl = play_img_url_default}) {
    this.id = id;
    this.musicName = musicName;
    this.singerName = singerName;
    this.bgImgUrl = bgImgUrl;
  }
}
