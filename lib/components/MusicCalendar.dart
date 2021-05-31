/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-31 17:46:41
 * @LastEditTime: 2021-05-31 17:48:35
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/services/user.dart';
import 'package:flutter/material.dart';

class MusicCalendar extends StatefulWidget {
  MusicCalendar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MusicCalendarState();
}

class MusicCalendarState extends State<MusicCalendar> {
  @override
  void initState() {
    super.initState();

    initCalendar();
  }

  // 音乐日历
  initCalendar() {
    var curr = DateTime.now();

    var today = DateTime(curr.year, curr.month, curr.day);
    var start = today.millisecondsSinceEpoch;

    var nextDay = today.add(Duration(days: 1));
    var end = nextDay.millisecondsSinceEpoch;

    getCalendar(start, end);
  }

  moreClick() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Stack(
        children: [
          Text(
            '音乐日历',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Positioned(
            child: TextButton(
              child: Text(
                '今日3条',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: moreClick,
            ),
            top: -3,
            right: 0,
          ),
          Container(margin: EdgeInsets.fromLTRB(0, 40, 0, 0), child: Text('')),
        ],
      ),
    );
  }
}
