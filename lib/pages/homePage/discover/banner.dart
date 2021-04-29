/*
 * @Description: 轮播图
 * @Author: Walker
 * @Date: 2021-04-02 16:17:32
 * @LastEditTime: 2021-04-29 10:10:35
 * @LastEditors: Walker
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../../services/home.dart';
import '../../../services/music.dart';
import '../../../libs/enums.dart';
import '../../../utils/preference.dart';
import 'package:cloudmusic_flutter/components/play.dart';

class DiscoverBanner extends StatefulWidget {
  DiscoverBanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DiscoverBannerState();
}

class DiscoverBannerState extends State<DiscoverBanner> {
  var images = [];

  @override
  initState() {
    super.initState();

    getBannerInfo();
  }

  getBannerInfo() async {
    getBanner(clientType['android']).then((value) {
      this.setState(() {
        images = value;
      });
    });
  }

  bannerClick(info) {
    if (info['targetId'] != 0) {
      // getMusicDetail([info['targetId']]).then((res) {
      //   Navigator.of(context)
      //       .push(MaterialPageRoute(builder: (BuildContext ctx) {
      //     // 页面跳转时传入参数
      //     return Play(params: {
      //       'info': res,
      //       'index': 0,
      //       'list': [res]
      //     });
      //   }));
      // });
    } else {
      // info['url']
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              bannerClick(images[index]);
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  images[index]['imageUrl'],
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
        itemCount: images.length,
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
