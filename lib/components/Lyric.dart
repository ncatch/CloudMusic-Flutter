/*
 * @Description: 歌词组件
 * @Author: Walker
 * @Date: 2021-04-30 15:26:08
 * @LastEditTime: 2021-05-08 13:42:48
 * @LastEditors: Walker
 */

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
  ScrollController _scrollController = new ScrollController();

  TextStyle whiteStyle =
      new TextStyle(color: Colors.white, fontSize: 15, height: 2);
  TextStyle greyStyle =
      new TextStyle(color: Colors.grey, fontSize: 15, height: 2);

  int currIndex = -1;

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

  int getCurrIndex() {
    PlayInfoStore playInfoStore = Provider.of<PlayInfoStore>(context);

    // String currTime = playInfoStore.position.toString();
    // Duration currDuration = getDuration(currTime);
    Duration currDuration = playInfoStore.position;

    List<String> lyricArr = playInfoStore.lyricArr;

    for (var i = 0; i < lyricArr.length; i++) {
      if (lyricArr[i].startsWith('[')) {
        var ly = lyricArr[i];
        var lySplit = ly.split(']');

        var tmpTime = lySplit[0].split('[')[1];
        var tmpDuration = getDuration(tmpTime);

        if (tmpDuration > currDuration) {
          return i;
        }
      }
    }

    return 0;
  }

  List<Widget> getLyric() {
    List<Widget> result = [];
    PlayInfoStore playInfoStore = Provider.of<PlayInfoStore>(context);

    List<String> lyricArr = playInfoStore.lyricArr;

    var child;

    for (var i = 0; i < lyricArr.length; i++) {
      if (lyricArr[i].startsWith('[')) {
        var ly = lyricArr[i];
        var lySplit = ly.split(']');
        var style = greyStyle;

        if (i == currIndex) {
          style = whiteStyle;
        }

        child = Text(
          lySplit[1],
          style: style,
          textAlign: TextAlign.center,
        );
      } else {
        child = Text(
          lyricArr[i],
          style: whiteStyle,
          textAlign: TextAlign.center,
        );
      }
      result.add(Container(
        child: child,
        height: 40,
      ));
    }

    return result;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    int tmpIndex = getCurrIndex() - 1;

    if (tmpIndex != currIndex) {
      currIndex = tmpIndex;

      _scrollController.animateTo(
        currIndex * 40, // 具体高度待调试
        duration: new Duration(milliseconds: 400),
        curve: Curves.linear,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var lyricList = getLyric();

    return Container(
      alignment: Alignment.center,
      child: ListView(
        controller: _scrollController,
        children: [
          Container(
            height: size.height / 2 - 190,
          ),
          ...lyricList,
        ],
      ),
    );
  }
}
