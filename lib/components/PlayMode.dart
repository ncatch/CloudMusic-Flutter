/*
 * @Description: 播放模式组件
 * @Author: Walker
 * @Date: 2021-05-08 18:00:16
 * @LastEditTime: 2021-06-11 14:05:29
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/libs/extends/Toast.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloudmusic_flutter/libs/enums.dart';

class PlayMode extends StatefulWidget {
  double iconSize;

  PlayMode({Key? key, this.iconSize = 20}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlayModeState();
}

class PlayModeState extends State<PlayMode> {
  var icons = {
    PlayModes.random: Icons.shuffle_rounded,
    PlayModes.repeat: Icons.repeat_rounded,
    PlayModes.repeatOne: Icons.repeat_one_rounded,
    PlayModes.order: Icons.wrap_text_rounded,
  };

  var tips = {
    PlayModes.random: "随机播放",
    PlayModes.repeat: "循环播放",
    PlayModes.repeatOne: "单曲播放",
    PlayModes.order: "顺序播放",
  };

  changePlayMode(PlayInfoStore playInfoStore) {
    var playModeList = PlayModes.values;

    var currIndex = playModeList.indexOf(playInfoStore.playMode);

    if (++currIndex >= playModeList.length) {
      currIndex = 0;
    }

    var currMode = playModeList[currIndex];

    playInfoStore.changePlayMode(currMode);

    Toast(tips[currMode]!);
  }

  @override
  Widget build(BuildContext context) {
    var playInfoStore = Provider.of<PlayInfoStore>(context);

    return IconButton(
      onPressed: () {
        changePlayMode(playInfoStore);
      },
      icon: Icon(icons[playInfoStore.playMode]),
      color: Colors.white,
      iconSize: widget.iconSize,
    );
  }
}
