/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-14 13:46:30
 * @LastEditTime: 2021-06-09 16:53:00
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/components/Play.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:cloudmusic_flutter/model/MusicInfo.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayMenu extends StatelessWidget {
  List<MusicInfo> musicList = [];
  int? musicCount;
  PlayInfoStore playInfoStore;

  PlayMenu(
      {Key? key,
      required this.musicList,
      required this.playInfoStore,
      this.musicCount})
      : super(key: key);

  downloadAllMusic() {}

  selectClich() {}

  playAll(context) {
    playInfoStore.setPlayList(musicList);

    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return Play();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              child: InkWell(
                onTap: () {
                  playAll(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.play_circle_fill, color: primaryColor),
                    Text(
                      ' 播放全部',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '（${musicCount ?? musicList.length}）',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: downloadAllMusic,
                  icon: Icon(Icons.cloud_download_outlined),
                ),
                IconButton(
                  onPressed: selectClich,
                  icon: Icon(Icons.playlist_add_check),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
