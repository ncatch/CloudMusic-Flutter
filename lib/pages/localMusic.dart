/*
 * @Description: 本地音乐
 * @Author: Walker
 * @Date: 2021-06-01 15:14:44
 * @LastEditTime: 2021-06-01 15:19:54
 * @LastEditors: Walker
 */

import 'dart:io';

import 'package:cloudmusic_flutter/utils/file.dart';
import 'package:flutter/material.dart';

//

class localMusic extends StatefulWidget {
  localMusic({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => localMusicState();
}

class localMusicState extends State<localMusic> {
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
    return Container(
      child: Text(names.join(',')),
    );
  }
}
