/*
 * @Description: 轮播图
 * @Author: Walker
 * @Date: 2021-04-02 16:17:32
 * @LastEditTime: 2021-05-10 21:43:20
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/model/Banner.dart';
import 'package:cloudmusic_flutter/pages/webView.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import 'package:cloudmusic_flutter/components/play.dart';

class Banner extends StatefulWidget {
  final List<BannerModel> banners;

  Banner({Key? key, required this.banners}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BannerState();
}

class BannerState extends State<Banner> {
  bannerClick(BannerModel info) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      switch (info.type) {
        case 3000:
          return WebViewComponent(url: info.url);
        case 10:
        case 1:
        default:
          Provider.of<PlayInfoStore>(context).playMusic(info.musicId);
          // 页面跳转时传入参数
          return Play();
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Swiper(
        key: UniqueKey(),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              bannerClick(widget.banners[index]);
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.banners[index].imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
        index: 0,
        autoplay: true,
        autoplayDelay: 10000,
        loop: false,
        itemCount: widget.banners.length,
        pagination: SwiperPagination(
          //指示器显示的位置
          alignment: Alignment.bottomCenter, // 位置 Alignment.bottomCenter 底部中间
          // 距离调整
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          // 指示器构建
          builder: DotSwiperPaginationBuilder(
              // 点之间的间隔
              space: 2,
              // 没选中时的大小
              size: 6,
              // 选中时的大小
              activeSize: 6,
              // 没选中时的颜色
              color: Color.fromRGBO(0, 0, 0, 0.4),
              //选中时的颜色
              activeColor: Colors.white),
        ),
      ),
    );
  }
}
