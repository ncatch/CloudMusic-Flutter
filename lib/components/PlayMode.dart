/*
 * @Description: 播放模式组件
 * @Author: Walker
 * @Date: 2021-05-08 18:00:16
 * @LastEditTime: 2021-05-08 19:41:12
 * @LastEditors: Walker
 */

import 'package:bot_toast/bot_toast.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloudmusic_flutter/libs/enums.dart';

class PlayMode extends StatefulWidget {
  PlayMode({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlayModeState();
}

class PlayModeState extends State<PlayMode> {
  var icons = {
    playModes.random: Icons.shuffle_rounded,
    playModes.repeat: Icons.repeat_rounded,
    playModes.repeatOne: Icons.repeat_one_rounded,
    playModes.order: Icons.wrap_text_rounded,
  };

  var tips = {
    playModes.random: "随机播放",
    playModes.repeat: "循环播放",
    playModes.repeatOne: "单曲播放",
    playModes.order: "顺序播放",
  };

  changePlayMode(PlayInfoStore playInfoStore) {
    var playModeList = playModes.values;

    var currIndex = playModeList.indexOf(playInfoStore.playMode);

    if (++currIndex >= playModeList.length) {
      currIndex = 0;
    }

    var currMode = playModeList[currIndex];

    playInfoStore.changePlayMode(currMode);

    BotToast.showText(text: tips[currMode] ?? "");
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
      iconSize: 30,
    );
  }
}
