/*
 * @Description: 播放控件
 * @Author: Walker
 * @Date: 2021-04-29 16:19:03
 * @LastEditTime: 2021-04-30 15:20:35
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/components/Play.dart';
import 'package:cloudmusic_flutter/model/PlayInfo.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayMini extends StatelessWidget {
  removeMusic(int Index) {}

  getListItem(playInfoStore) {
    int playCount = playInfoStore.musicList.length;

    return ListView.builder(
      itemCount: playCount,
      itemBuilder: (context, index) {
        var tmpInfo = playInfoStore.musicList[index];

        return InkWell(
            onTap: () {
              playInfoStore.setPlayIndex(index);
              Navigator.pop(context);
            },
            child: Container(
              height: 30,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text(
                          tmpInfo.musicName,
                        ),
                        Text(
                          '-' + tmpInfo.singerName,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     removeMusic(index);
                  //   },
                  //   icon: Icon(Icons.close),
                  // )
                ],
              ),
            ));
      },
    );
  }

  showMusicList(context, playInfoStore) {
    int playCount = playInfoStore.musicList.length;

    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Container(
                height: 50,
                alignment: Alignment.centerLeft,
                child: Text(
                  '当前播放（$playCount）',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(flex: 1, child: getListItem(playInfoStore))
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var playInfoStore = Provider.of<PlayInfoStore>(context);
    double width = MediaQuery.of(context).size.width;

    return Container(
        height: playInfoStore.playIndex >= 0 ? 50 : 0,
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
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new NetworkImage(playInfoStore.musicInfo.iconUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
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
                  icon: Icon(Icons.list),
                  iconSize: 30,
                ),
              ),
            ],
          ),
        ));
  }
}
