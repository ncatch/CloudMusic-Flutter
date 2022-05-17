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
import 'package:flutter/material.dart';
import 'package:cloudmusic_flutter/model/MenuInfo.dart';

import '../libs/extends/Toast.dart';
import '../utils/file.dart';

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
    List<MusicInfo> downloadMusics = await FileUtil.getDownloadMusicList();

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
            menus: [
              MenuInfoModel(
                '删除',
                code: 'delete',
                onPressed: (info) async {
                  var cb = ShowLoading();

                  await FileUtil.deleteMusic(info);

                  getLocalMusicList();

                  cb();

                  Toast('删除成功！');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
