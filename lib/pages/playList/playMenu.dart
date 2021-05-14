/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-14 13:46:30
 * @LastEditTime: 2021-05-14 13:50:43
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/components/Play.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayMenu extends StatelessWidget {
  PlayListModel playListInfo;

  PlayMenu({Key? key, required this.playListInfo}) : super(key: key);

  downloadMusic() {}
  selectClich() {}

  playAll(context) {
    var playInfoStore = Provider.of<PlayInfoStore>(context);

    playInfoStore.setPlayList(playListInfo.musicList);

    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return Play();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 40,
              child: InkWell(
                onTap: () {
                  playAll(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.play_circle_fill, color: primaryColor),
                    Text(' 播放全部'),
                    Text(playListInfo.musicList.length.toString()),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: downloadMusic,
                  icon: Icon(Icons.cloud_download_outlined),
                ),
                IconButton(
                  onPressed: selectClich,
                  icon: Icon(Icons.playlist_add_check),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
