/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-27 19:09:24
 * @LastEditTime: 2021-05-27 19:10:39
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/pages/playList/index.dart';
import 'package:flutter/material.dart';
import 'package:cloudmusic_flutter/libs/extends/StringExtend.dart';
import 'package:cloudmusic_flutter/libs/extends/IntExtend.dart';

class SongListItem extends StatelessWidget {
  final PlayListModel info;

  SongListItem({Key? key, required this.info});

  songClick(context, id) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return PlayList(
        songId: id,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: () {
          songClick(context, info.id);
        },
        child: Row(
          children: [
            Container(
              width: 80,
              height: 55,
              padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  info.coverImgUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info.title.overFlowString(12),
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '${info.trackCount}首, 播放${info.playCount.toMyriadString(1)}次',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
