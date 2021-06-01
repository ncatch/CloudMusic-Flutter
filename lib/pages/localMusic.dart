/*
 * @Description: 本地音乐
 * @Author: Walker
 * @Date: 2021-06-01 15:14:44
 * @LastEditTime: 2021-06-01 22:31:59
 * @LastEditors: Walker
 */

import 'dart:io';

import 'package:cloudmusic_flutter/components/Base/HeightRefresh.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:cloudmusic_flutter/utils/file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocalMusic extends StatefulWidget {
  LocalMusic({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LocalMusicState();
}

class LocalMusicState extends State<LocalMusic> {
  List<String> names = [];

  @override
  void initState() {
    super.initState();

    getLocalMusicList();
  }

  getLocalMusicList() async {
    var tmp = await FileUtil.getDownloadMusicList();

    setState(() {
      names = tmp.map((e) => e.path).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var playInfoStore = Provider.of<PlayInfoStore>(context);

    return HeightRefresh(
      child: Scaffold(
        appBar: AppBar(
          title: Text('本地音乐'),
        ),
        body: Container(
          child: InkWell(
            onTap: () {
              // playInfoStore.setPlayMusic(names[0]);
              playInfoStore.audioPlayer.play(names[0]);
            },
            child: Text('123'),
          ),
        ),
      ),
    );
  }
}
