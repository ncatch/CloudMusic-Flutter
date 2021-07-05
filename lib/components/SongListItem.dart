/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-27 19:09:24
 * @LastEditTime: 2021-07-05 14:32:55
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/components/Base/IconRow.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/pages/playList/index.dart';
import 'package:flutter/material.dart';
import 'package:cloudmusic_flutter/libs/extends/StringExtend.dart';
import 'package:cloudmusic_flutter/libs/extends/IntExtend.dart';

class SongListItem extends StatelessWidget {
  final PlayListModel info;

  SongListItem({Key? key, required this.info});

  songClick(context, id) {
    if (id > 0) {
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
        return PlayList(
          songId: id,
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconRow(
      image: info.coverImgUrl,
      title: info.title.overFlowString(12),
      descript: '${info.trackCount}首, 播放${info.playCount.toMyriadString(1)}次',
      onTap: () {
        songClick(context, info.id);
      },
    );
  }
}
