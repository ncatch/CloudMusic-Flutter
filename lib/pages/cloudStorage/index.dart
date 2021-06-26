/*
 * @Description: 云盘
 * @Author: Walker
 * @Date: 2021-06-09 14:25:52
 * @LastEditTime: 2021-06-11 14:37:42
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/components/MusicList.dart';
import 'package:cloudmusic_flutter/components/PlayMini.dart';
import 'package:cloudmusic_flutter/components/playMenu.dart';
import 'package:cloudmusic_flutter/libs/extends/Toast.dart';
import 'package:cloudmusic_flutter/model/MenuInfo.dart';
import 'package:cloudmusic_flutter/model/MusicInfo.dart';
import 'package:cloudmusic_flutter/services/cludStorage.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CloudStorage extends StatefulWidget {
  CloudStorage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CloudStorageState();
  }
}

class CloudStorageState extends State<CloudStorage> {
  List<MusicInfo> musicList = [];

  List<MenuInfoModel> menus = [];

  @override
  void initState() {
    super.initState();

    this.setState(() {
      menus = [
        MenuInfoModel('删除', code: 'delete', onPressed: delete),
      ];
    });

    getList();
  }

  delete(MusicInfo info) {
    deleteCloudMusic(info.id).then((value) {
      if (value['code'] == 200) {
        getList();
        Toast('删除成功');
      }
    });
  }

  getList() {
    getCloudInfo().then((res) {
      this.setState(() {
        musicList = List<MusicInfo>.from(
            res['data'].map((ele) => MusicInfo.fromData(ele['simpleSong'])));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var playInfoStore = Provider.of<PlayInfoStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('云盘'),
      ),
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: Column(children: [
                PlayMenu(
                  musicList: musicList,
                  playInfoStore: playInfoStore,
                ),
                MusicList(
                  musicList: musicList,
                  menus: menus,
                ),
              ]),
            ),
            PlayMini(),
          ],
        ),
      ),
    );
  }
}
