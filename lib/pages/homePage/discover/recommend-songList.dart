/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-02 16:09:03
 * @LastEditTime: 2021-05-07 13:35:07
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/components/SongList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../services/home.dart';

class DiscoverRecommendSongList extends StatefulWidget {
  DiscoverRecommendSongList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DiscoverRecommendSongListState();
}

class DiscoverRecommendSongListState extends State<DiscoverRecommendSongList> {
  var songList = [];

  @override
  initState() {
    super.initState();

    getRecommendSongList(6).then((value) => {
          this.setState(() {
            songList = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return SongList(songList: songList);
  }
}
