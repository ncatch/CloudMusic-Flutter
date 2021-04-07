/*
 * @Description: 轮播图
 * @Author: Walker
 * @Date: 2021-04-02 16:17:32
 * @LastEditTime: 2021-04-07 16:02:50
 * @LastEditors: Walker
 */
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../../model/Banner.dart';

import '../../../services/home.dart';
import '../../../libs/enums.dart';
import '../../../utils/preference.dart';

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
    var bannerHistory =
        await PreferenceUtils.getString(PreferencesKey.HOME_BANNER);

    if (bannerHistory != '') {
      images = jsonDecode(bannerHistory);
    } else {
      getBanner(clientType['android']).then((value) {
        PreferenceUtils.saveString(
            PreferencesKey.HOME_BANNER, jsonEncode(value.data['banners']));

        this.setState(() {
          images = value.data['banners'];
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                images[index]['imageUrl'],
                fit: BoxFit.fill,
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
