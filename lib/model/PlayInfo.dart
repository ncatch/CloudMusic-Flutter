/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-28 18:03:38
 * @LastEditTime: 2021-05-11 16:46:16
 * @LastEditors: Walker
 */

import '../libs/config.dart';
import './MusicInfo.dart';

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
