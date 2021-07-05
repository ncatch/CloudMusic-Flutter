/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-07-02 10:39:14
 * @LastEditTime: 2021-07-05 14:02:59
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/components/Base/IconRow.dart';
import 'package:cloudmusic_flutter/components/PlayMini.dart';
import 'package:cloudmusic_flutter/model/Album.dart';
import 'package:cloudmusic_flutter/model/MenuInfo.dart';
import 'package:cloudmusic_flutter/pages/playList/index.dart';
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubList extends StatefulWidget {
  SubList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SubListState();
  }
}

class SubListState extends State<SubList> {
  List<AlbumInfo> list = [];

  List<MenuInfoModel> menus = [];

  @override
  void initState() {
    super.initState();

    this.setState(() {
      menus = [
        MenuInfoModel('删除', code: 'delete', onPressed: delete),
      ];
    });

    getList();
  }

  delete(info) {}

  getList() {
    getUserSublist().then((res) {
      this.setState(() {
        list = List<AlbumInfo>.from(
            res["data"].map((ele) => AlbumInfo.fromJson(ele)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收藏和赞'),
      ),
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: Column(
                  children: list
                      .map((e) => IconRow(
                            title: e.name,
                            descript: e.creater,
                            image: e.picUrl,
                          ))
                      .toList()),
            ),
            PlayMini(),
          ],
        ),
      ),
    );
  }
}

class SubItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
