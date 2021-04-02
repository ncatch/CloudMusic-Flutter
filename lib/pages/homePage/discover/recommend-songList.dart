/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-02 16:09:03
 * @LastEditTime: 2021-04-02 18:04:16
 * @LastEditors: Walker
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../services/home.dart';

class DiscoverRecommendSongList extends StatefulWidget {
  DiscoverRecommendSongList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DiscoverRecommendSongListState();
}

class DiscoverRecommendSongListState extends State<DiscoverRecommendSongList> {
  var songList = [];

  @override
  initState() {
    super.initState();

    getRecommendSongList(6).then((value) => {
          this.setState(() {
            songList = value.data['result'];
          })
        });
  }

  String handleSongName(String val) {
    if (val.length <= 18) return val;

    return val.substring(0, 17) + '...';
  }

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];

    songList.forEach((ele) {
      list.add(Container(
        height: 180,
        width: 120,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Stack(
          children: [
            Column(children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    ele['picUrl'],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(handleSongName(ele['name']), style: TextStyle(fontSize: 12)),
            ]),
            Positioned(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.play_arrow_outlined,
                          color: Colors.white, size: 18),
                      Text(
                        (ele['playCount'] / 10000).round().toString() + '万',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                width: 60,
                height: 20,
                top: 5,
                left: 40)
          ],
        ),
      ));
    });

    return Container(
      height: 200,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: list.length > 0
          ? ListView(
              scrollDirection: Axis.horizontal,
              children: list,
            )
          : Text('loading'),
    );
  }
}
