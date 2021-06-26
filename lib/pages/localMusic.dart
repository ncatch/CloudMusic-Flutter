/*
 * @Description: 本地音乐
 * @Author: Walker
 * @Date: 2021-06-01 15:14:44
 * @LastEditTime: 2021-06-02 11:17:16
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/components/Base/HeightRefresh.dart';
import 'package:cloudmusic_flutter/components/MusicList.dart';
import 'package:cloudmusic_flutter/libs/enums.dart';
import 'package:cloudmusic_flutter/model/MusicInfo.dart';
import 'package:cloudmusic_flutter/utils/preference.dart';
import 'package:flutter/material.dart';

class LocalMusic extends StatefulWidget {
  LocalMusic({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LocalMusicState();
}

class LocalMusicState extends State<LocalMusic> {
  bool isInit = false;
  List<MusicInfo> musicLic = [];

  @override
  void initState() {
    super.initState();
  }

  init() {
    isInit = true;
    getLocalMusicList();
  }

  getLocalMusicList() async {
    var downloadMusics = List<MusicInfo>.from(
        await PreferenceUtils.getJSON(PreferencesKey.DOWNLOAD_MUSIC));

    setState(() {
      musicLic = downloadMusics;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isInit) {
      init();
    }

    return HeightRefresh(
      child: Scaffold(
        appBar: AppBar(
          title: Text('本地音乐'),
        ),
        body: Container(
          child: MusicList(
            type: MusicListTye.local,
            musicList: musicLic,
          ),
        ),
      ),
    );
  }
}
