/*
 * @Description: 播放控件
 * @Author: Walker
 * @Date: 2021-04-29 16:19:03
 * @LastEditTime: 2021-04-29 17:50:43
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayMini extends StatelessWidget {
  showMusicList() {}

  @override
  Widget build(BuildContext context) {
    var playInfoStore = Provider.of<PlayInfoStore>(context);
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: playInfoStore.playIndex >= 0 ? 50 : 0,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 1,
            child: Text(playInfoStore.musicInfo.musicName +
                '-' +
                playInfoStore.musicInfo.singerName),
          ),
          Container(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: playInfoStore.play,
              icon: Icon(playInfoStore.isPlayer
                  ? Icons.pause_circle_outline
                  : Icons.play_circle_outline),
              iconSize: 30,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: showMusicList,
              icon: Icon(Icons.list),
              iconSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
