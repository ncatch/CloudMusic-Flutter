/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-04-01 14:07:39
 * @LastEditors: Walker
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../services/home.dart';

class Discover extends StatefulWidget {
  Discover({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DiscoverState();
}

class DiscoverState extends State<Discover> {
  var images = [];

  @override
  initState() {
    super.initState();

    getBanner(1).then((value) => {
          this.setState(() {
            images = value.data;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: [
            // 轮播图
            Container(
              height: 200,
              child: new Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return new Image.network(
                    images[index].imageUrl,
                    fit: BoxFit.fill,
                  );
                },
                itemCount: images.length,
                pagination: SwiperPagination(
                  //指示器显示的位置
                  alignment:
                      Alignment.bottomCenter, // 位置 Alignment.bottomCenter 底部中间
                  // 距离调整
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
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
            ),
            Text(images.toString())
          ],
        ),
      ),
    );
  }
}
