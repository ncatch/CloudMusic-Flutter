/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-04-02 16:48:59
 * @LastEditors: Walker
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 当前页面组件
import './discover/banner.dart';
import './discover/menu.dart';
import './discover/recommend-songList.dart';

class Discover extends StatefulWidget {
  Discover({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DiscoverState();
}

class DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: [
            // 轮播图
            DiscoverBanner(),
            // 轮播图下菜单
            DiscoverMenu(),
            // 推荐歌单
            DiscoverRecommendSongList()
          ],
        ),
      ),
    );
  }
}
