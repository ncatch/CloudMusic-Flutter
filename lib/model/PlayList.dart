/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-11 16:45:25
 * @LastEditTime: 2021-05-11 17:51:58
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/model/MusicInfo.dart';

class PlayList {
  String title = "";
  String headBgUrl = "";
  String descript = "";
  var creator; // 创建人
  List<String> labels = [];

  List<MusicInfo> musicList = [];
}
