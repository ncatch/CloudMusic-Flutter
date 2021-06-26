/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-31 16:17:19
 * @LastEditTime: 2021-06-11 14:21:15
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/components/Play.dart';
import 'package:cloudmusic_flutter/libs/enums.dart';
import 'package:cloudmusic_flutter/libs/extends/Toast.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:cloudmusic_flutter/model/MenuInfo.dart';
import 'package:cloudmusic_flutter/model/MusicInfo.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:cloudmusic_flutter/utils/file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloudmusic_flutter/libs/extends/StringExtend.dart';
import 'package:provider/provider.dart';

class MusicList extends StatefulWidget {
  final List<MusicInfo> musicList;
  final MusicListTye type;
  List<MenuInfoModel>? menus;

  MusicList({
    Key? key,
    required this.musicList,
    this.type = MusicListTye.online,
    this.menus,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MusicListState();
}

class MusicListState extends State<MusicList> {
  double downloadProgress = 0;

  musicMenu() {}

  musicClick(playInfoStore, index) {
    playInfoStore.setPlayList(widget.musicList, index);

    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return Play();
    }));
  }

  callback(String type, double value) {
    switch (type) {
      case 'download':
        if (value >= 1) {
          value = 0;
          Toast('下载完成');
        }
        setState(() {
          downloadProgress = value;
        });
        break;
      default:
    }
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
              RightMenu(
                type: widget.type,
                info: ele,
                callback: callback,
                menus: widget.menus,
              ),
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
        children: [
          new LinearProgressIndicator(
            backgroundColor: Colors.white,
            value: downloadProgress,
            valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
          ),
          ...getMusicListWidget(playInfoStore)
        ],
      ),
    );
  }
}

class RightMenu extends StatelessWidget {
  MusicInfo info;
  MusicListTye type;
  Function? callback;
  List<MenuInfoModel>? menus;

  RightMenu({
    Key? key,
    required this.info,
    this.type = MusicListTye.online,
    this.callback,
    this.menus,
  });

  onReceiveProgress(int a, int b) {
    if (callback != null) {
      callback!('download', a / b);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<PopupMenuEntry<String>> btns = [];

    if (type != MusicListTye.local) {
      btns.add(PopupMenuItem<String>(
        value: 'download',
        child: Text('下载'),
      ));
    }

    // 外部添加的按钮
    menus?.forEach((ele) {
      btns.add(PopupMenuItem<String>(
        value: ele.code,
        child: Text(ele.text),
      ));
    });

    return PopupMenuButton<String>(
      onSelected: (val) {
        switch (val) {
          case 'download':
            FileUtil.downloadMusic(info, onReceiveProgress: onReceiveProgress);
            break;
          default:
            var menu = menus?.firstWhere((ele) => ele.code == val);
            menu?.onPressed(info);
        }
      },
      itemBuilder: (context) {
        return btns;
      },
    );
  }
}
