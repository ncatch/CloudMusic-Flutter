/*
 * @Description: 轮播图下方菜单按钮
 * @Author: Walker
 * @Date: 2021-04-02 15:41:58
 * @LastEditTime: 2021-05-28 15:22:48
 * @LastEditors: Walker
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../model/MenuInfo.dart';

var menuInfo = [
  MenuInfoModel("每日推荐", iconUrl: "assets/icon.png"),
  MenuInfoModel("私人FM", iconUrl: "assets/icon.png"),
  MenuInfoModel("歌单", iconUrl: "assets/icon.png"),
  MenuInfoModel("排行榜", iconUrl: "assets/icon.png"),
  MenuInfoModel("直播", iconUrl: "assets/icon.png"),
  MenuInfoModel("数字专辑", iconUrl: "assets/icon.png"),
  MenuInfoModel("歌房", iconUrl: "assets/icon.png"),
  MenuInfoModel("游戏专区", iconUrl: "assets/icon.png")
];

class DiscoverMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var menus = <Widget>[];

    menuInfo.forEach((ele) {
      menus.add(Container(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: InkWell(
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
