/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-02 16:09:03
 * @LastEditTime: 2021-04-16 10:30:26
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
            songList = value;
          })
        });
  }

  String handleSongName(String val) {
    if (val.length <= 16) return val;

    return val.substring(0, 15) + '...';
  }

  void moreSongList() {}

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];

    for (var i = 0; i < songList.length; i++) {
      var ele = songList[i];

      list.add(Container(
        height: 180,
        width: 110,
        padding: EdgeInsets.fromLTRB(i == 0 ? 0 : 10, 0, 0, 0),
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
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              Text(handleSongName(ele['name']), style: TextStyle(fontSize: 12)),
            ]),
            Positioned(
                child: Container(
                  padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                  decoration: BoxDecoration(
                    color: Colors.black38,
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
                height: 22,
                top: 4,
                right: 4)
          ],
        ),
      ));
    }

    return Container(
      height: 200,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Stack(
        children: [
          Text(
            '推荐歌单',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Positioned(
            child: TextButton(
              child: Text(
                '更多 >',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: moreSongList,
            ),
            top: -3,
            right: 0,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: list,
            ),
          ),
        ],
      ),
    );
  }
}
