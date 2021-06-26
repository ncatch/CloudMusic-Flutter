/*
 * @Description: 播放控件
 * @Author: Walker
 * @Date: 2021-04-29 16:19:03
 * @LastEditTime: 2021-06-01 15:57:52
 * @LastEditors: Walker
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmusic_flutter/components/Play.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Base/ShowModalBottomSheetTools.dart';

class PlayMini extends StatefulWidget {
  PlayMini({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlayMiniState();
}

class PlayMiniState extends State<PlayMini> with ShowCurrMusicList {
  @override
  Widget build(BuildContext context) {
    var playInfoStore = Provider.of<PlayInfoStore>(context);
    double width = MediaQuery.of(context).size.width;

    return Container(
        height:
            playInfoStore.isPlayer || playInfoStore.musicInfo.id > 0 ? 50 : 0,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext ctx) {
              return Play();
            }));
          },
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: CachedNetworkImageProvider(
                      playInfoStore.musicInfo.iconUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(playInfoStore.musicInfo.musicName +
                        '-' +
                        playInfoStore.musicInfo.singerName),
                  )),
              Container(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: playInfoStore.play,
                  icon: Icon(playInfoStore.isPlayer
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline),
                  iconSize: 30,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {
                    showMusicList(context, playInfoStore);
                  },
                  icon: Icon(Icons.playlist_play_rounded),
                  iconSize: 30,
                ),
              ),
            ],
          ),
        ));
  }
}
