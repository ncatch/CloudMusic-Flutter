/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-31 17:46:41
 * @LastEditTime: 2021-06-02 15:29:36
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/components/Base/HomeBlock.dart';
import 'package:cloudmusic_flutter/pages/playList/index.dart';
import 'package:cloudmusic_flutter/pages/webView.dart';
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:cloudmusic_flutter/model/MusicCalendar.dart';
import 'package:flutter/material.dart';

class MusicCalendar extends StatefulWidget {
  MusicCalendarModel model;

  MusicCalendar({Key? key, required this.model}) : super(key: key);

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

  itemClick(MusicCalendarItem item) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      switch (item.resourceType) {
        case 'WEBVIEW':
          return WebViewComponent(url: item.resourceId);
        default:
          return PlayList(
            songId: item.resourceId,
          );
      }
    }));
  }

  moreClick() {}

  @override
  Widget build(BuildContext context) {
    return HomeBlock(
      title: widget.model.title,
      btnText: widget.model.btnText,
      onPressed: moreClick,
      child: Container(
          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Column(
            children: widget.model.items.map<Widget>((e) {
              var tmp = e.content.split('-');

              e.content = tmp[tmp.length - 1];

              tmp.remove(e.content);

              return InkWell(
                  onTap: () {
                    itemClick(e);
                  },
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1,
                          color: Colors.grey.shade100,
                        ),
                      ),
                    ),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  ...tmp.map((label) => CalendarLabel(
                                        text: label,
                                        textColor: Colors.grey,
                                        bgColor: Colors.grey.shade100,
                                      )),
                                  ...e.labels.map((label) => CalendarLabel(
                                        text: label,
                                        textColor: Colors.orange,
                                        bgColor: Colors.orange.withOpacity(0.1),
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                e.content,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        )),
                        Container(
                          width: 50,
                          height: 50,
                          child: Image.network(e.imgUrl),
                        )
                      ],
                    ),
                  ));
            }).toList(),
          )),
    );
  }
}

class CalendarLabel extends StatelessWidget {
  Color bgColor;
  Color textColor;
  String text;

  CalendarLabel({
    Key? key,
    required this.text,
    this.textColor = Colors.grey,
    this.bgColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
        ),
      ),
    );
  }
}
