/*
 * @Description: 播放页面
 * @Author: nocatch
 * @Date: 2021-04-09 14:33:57
 * @LastEditTime: 2021-05-27 15:26:00
 * @LastEditors: Walker
 */

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Lyric.dart';
import '../store/PlayInfo.dart';
import 'Base/ShowModalBottomSheetTools.dart';
import 'PlayMode.dart';

class Play extends StatefulWidget {
  Play({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlayState();
}

class PlayState extends State<Play> with ShowCurrMusicList {
  static double iconSize = 30;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    var playInfoStore = Provider.of<PlayInfoStore>(context);

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage(playInfoStore.musicInfo.bgImgUrl),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                    Colors.black54,
                    BlendMode.overlay,
                  ),
                ),
              ),
            ),
            Container(
                child: new BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Opacity(
                opacity: 0.6,
                child: new Container(
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
            )),
            Container(
              child: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.keyboard_arrow_down),
                  color: Colors.white,
                ),
                leadingWidth: 30,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Center(
                  child: Column(
                    children: [
                      Text(
                        playInfoStore.musicInfo.musicName,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        playInfoStore.musicInfo.singerName,
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              width: width,
              bottom: 150,
              height: height - 250,
              child: Container(
                alignment: Alignment.center,
                child: Lyric(),
              ),
            ),
            Positioned(
              width: width,
              bottom: 20,
              child: Column(
                children: [
                  Slider(
                    onChanged: (newValue) {
                      if (playInfoStore.duration != null) {
                        int seconds =
                            (playInfoStore.duration.inSeconds * newValue)
                                .round();
                        playInfoStore.audioPlayer
                            .seek(new Duration(seconds: seconds));
                      }
                    },
                    activeColor: Colors.white,
                    inactiveColor: Colors.white,
                    value: playInfoStore.sliderValue,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      PlayMode(iconSize: iconSize - 5),
                      IconButton(
                        onPressed: playInfoStore.previous,
                        icon: Icon(Icons.skip_previous_outlined),
                        color: playInfoStore.playIndex == 0
                            ? Colors.grey
                            : Colors.white,
                        iconSize: iconSize,
                      ),
                      IconButton(
                        onPressed: playInfoStore.play,
                        icon: Icon(playInfoStore.isPlayer
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_outline),
                        color: Colors.white,
                        iconSize: iconSize + 10,
                      ),
                      IconButton(
                        onPressed: playInfoStore.next,
                        icon: Icon(Icons.skip_next_outlined),
                        color: playInfoStore.playIndex >=
                                playInfoStore.musicList.length - 1
                            ? Colors.grey
                            : Colors.white,
                        iconSize: iconSize,
                      ),
                      IconButton(
                        onPressed: () {
                          showMusicList(context, playInfoStore);
                        },
                        icon: Icon(Icons.playlist_play_rounded),
                        color: Colors.white,
                        iconSize: iconSize,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
