/*
 * @Description: 轮播图下方菜单按钮
 * @Author: Walker
 * @Date: 2021-04-02 15:41:58
 * @LastEditTime: 2021-06-02 16:15:07
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/components/Play.dart';
import 'package:cloudmusic_flutter/libs/enums.dart';
import 'package:cloudmusic_flutter/model/MusicInfo.dart';
import 'package:cloudmusic_flutter/pages/playList/index.dart';
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/MenuInfo.dart';

class DiscoverMenu extends StatefulWidget {
  DiscoverMenu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DiscoverMenuState();
}

class DiscoverMenuState extends State<DiscoverMenu> {
  var menuInfo;

  DiscoverMenuState() {
    menuInfo = [
      MenuInfoModel("每日推荐",
          iconUrl: "assets/icon_red.png", onPressed: recommendClick),
      MenuInfoModel("私人FM", iconUrl: "assets/icon_red.png", onPressed: fmClick),
      MenuInfoModel("歌单",
          iconUrl: "assets/icon_red.png", onPressed: songListClick),
      MenuInfoModel("排行榜",
          iconUrl: "assets/icon_red.png", onPressed: rankListClick),
      MenuInfoModel("直播", iconUrl: "assets/icon_red.png"),
      MenuInfoModel("数字专辑", iconUrl: "assets/icon_red.png"),
      MenuInfoModel("歌房", iconUrl: "assets/icon_red.png"),
      MenuInfoModel("游戏专区", iconUrl: "assets/icon_red.png")
    ];
  }

  // 每日推荐
  recommendClick([playInfoStore]) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return PlayList(
        playlistType: PlayListType.recommend,
      );
    }));
  }

  // 私人FM
  fmClick([playInfoStore]) {
    getPersonalFM().then((res) {
      if (res['code'] == 200) {
        var list = List<MusicInfo>.from(
            res['data'].map((ele) => MusicInfo.fromData(ele)));

        playInfoStore.setPlayList(list);

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext ctx) {
          return Play();
        }));
      }
    });
  }

  // 歌单
  songListClick([playInfoStore]) {}

  // 排行榜
  rankListClick([playInfoStore]) {}

  @override
  Widget build(BuildContext context) {
    var menus = <Widget>[];
    var playInfoStore = Provider.of<PlayInfoStore>(context);

    menuInfo.forEach((ele) {
      menus.add(Container(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: InkWell(
            onTap: () {
              ele.onPressed(playInfoStore);
            },
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Image.asset(
                    ele.iconUrl,
                    width: 25,
                    height: 25,
                  ),
                ),
                Text(ele.text)
              ],
            ),
          )));
    });

    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: menus,
      ),
    );
  }
}
