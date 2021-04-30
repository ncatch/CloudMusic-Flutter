/*
 * @Description: 歌词组件
 * @Author: Walker
 * @Date: 2021-04-30 15:26:08
 * @LastEditTime: 2021-04-30 18:08:38
 * @LastEditors: Walker
 */

import 'dart:ffi';

import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Lyric extends StatefulWidget {
  Lyric({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LyricState();
}

class LyricState extends State<Lyric> {
  ScrollController? _scrollController;

  @override
  initState() {
    super.initState();

    _scrollController = new ScrollController();
  }

  Duration getDuration(String time) {
    var times = time.split(':');

    if (times.length == 2) {
      times.insert(0, '0');
    }

    var seconds = times[2].split('.');

    if (seconds[1].length < 3) {
      seconds[1] += '000';
    }

    seconds[1] = seconds[1].substring(0, 3);

    return new Duration(
      hours: int.parse(times[0]),
      minutes: int.parse(times[1]),
      seconds: int.parse(seconds[0]),
      milliseconds: int.parse(seconds[1]),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    PlayInfoStore playInfoStore = Provider.of<PlayInfoStore>(context);

    List<String> lyricArr = playInfoStore.musicLyric.split('\n');

    String currTime = playInfoStore.position.toString();
    Duration currDuration = getDuration(currTime);

    TextStyle whiteStyle =
        new TextStyle(color: Colors.white, fontSize: 15, height: 2);
    TextStyle greyStyle =
        new TextStyle(color: Colors.grey, fontSize: 15, height: 2);

    int currIndex = -1;

    return Container(
      alignment: Alignment.center,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: lyricArr.length,
        itemBuilder: (context, index) {
          if (lyricArr[index].startsWith('[')) {
            var ly = lyricArr[index];
            var lySplit = ly.split(']');

            var tmpTime = lySplit[0].split('[')[1];
            var tmpDuration = getDuration(tmpTime);
            var style = greyStyle;

            if (tmpDuration > currDuration && currIndex < 0) {
              currIndex = index;
              style = whiteStyle;

              var scroll = index * 30 - size.height / 2 + 140;
              if (scroll < 0) {
                scroll = 0;
              }

              _scrollController?.animateTo(
                index * 30 - size.height / 2 + 150,
                duration: new Duration(milliseconds: 500),
                curve: Curves.linear,
              );
            }

            return Text(
              lySplit[1],
              style: style,
              textAlign: TextAlign.center,
            );
          }
          return Text(
            lyricArr[index],
            style: whiteStyle,
            textAlign: TextAlign.center,
          );
        },
      ),
    );
  }
}
