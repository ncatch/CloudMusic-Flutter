/*
 * @Description: 轮播图下方菜单按钮
 * @Author: Walker
 * @Date: 2021-04-02 15:41:58
 * @LastEditTime: 2021-04-02 16:24:31
 * @LastEditors: Walker
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuInfo {
  String text = "";
  String icon = "";
  String url = "";

  MenuInfo(String text, String icon, String url) {
    this.text = text;
    this.icon = icon;
    this.url = url;
  }
}

var menuInfo = [
  MenuInfo("每日推荐", "assets/icon.png", ""),
  MenuInfo("私人FM", "assets/icon.png", ""),
  MenuInfo("歌单", "assets/icon.png", ""),
  MenuInfo("排行榜", "assets/icon.png", ""),
  MenuInfo("直播", "assets/icon.png", ""),
  MenuInfo("数字专辑", "assets/icon.png", ""),
  MenuInfo("歌房", "assets/icon.png", ""),
  MenuInfo("游戏专区", "assets/icon.png", "")
];

class DiscoverMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var menus = <Widget>[];

    menuInfo.forEach((ele) {
      menus.add(Container(
          padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
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
                    ele.icon,
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
