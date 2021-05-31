/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-31 16:17:19
 * @LastEditTime: 2021-05-31 16:26:07
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/components/Play.dart';
import 'package:cloudmusic_flutter/model/MusicInfo.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloudmusic_flutter/libs/extends/StringExtend.dart';
import 'package:provider/provider.dart';

class MusicList extends StatefulWidget {
  final List<MusicInfo> musicList;

  MusicList({Key? key, required this.musicList}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MusicListState();
}

class MusicListState extends State<MusicList> {
  musicMenu() {}

  musicClick(playInfoStore, index) {
    playInfoStore.setPlayList(widget.musicList, index);

    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return Play();
    }));
  }

  List<Widget> getMusicListWidget(playInfoStore) {
    List<Widget> result = [];
    for (var i = 0; i < widget.musicList.length; i++) {
      var ele = widget.musicList[i];

      result.add(Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: InkWell(
          onTap: () {
            musicClick(playInfoStore, i);
          },
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Container(
                width: 40,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  (i + 1).toString(),
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Expanded(
                flex: 1,
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      ele.musicName.overFlowString(18),
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      ele.singerName + '-' + ele.tip.overFlowString(15),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: musicMenu,
                icon: Icon(Icons.more_vert),
              )
            ],
          ),
        ),
      ));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var playInfoStore = Provider.of<PlayInfoStore>(context);

    return Container(
      child: Wrap(
        children: getMusicListWidget(playInfoStore),
      ),
    );
  }
}
