/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-05-07 15:30:27
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/model/Banner.dart';
import 'package:cloudmusic_flutter/services/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// 当前页面组件
import '../../../components/Banner.dart' as BannerComponent;
import './discover/menu.dart';
import './discover/recommend-songList.dart';

class Discover extends StatefulWidget {
  Discover({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DiscoverState();
}

class DiscoverState extends State<Discover> {
  var homeData;
  List<BannerModel> banners = [];

  @override
  void initState() {
    super.initState();

    getHomeData(true).then((value) {
      if (value['code'] == 200) {
        this.setState(() {
          homeData = value['data'];
          banners = List<BannerModel>.from(value['data']['blocks'][0]['extInfo']
                  ['banners']
              .map((ele) => BannerModel.fromJson(ele)));
        });
      } else {
        Fluttertoast.showToast(
          msg: value['message'] ?? '网络异常',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: [
            // 轮播图
            BannerComponent.Banner(banners: banners),
            // 轮播图下菜单
            DiscoverMenu(),
            // 推荐歌单
            DiscoverRecommendSongList(),
          ],
        ),
      ),
    );
  }
}
