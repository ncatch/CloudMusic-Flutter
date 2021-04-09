/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-08 10:35:14
 * @LastEditTime: 2021-04-09 10:16:59
 * @LastEditors: Walker
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter2_app/libs/theme.dart';

import '../services/search.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  // 搜索默认显示
  String defaultSearchKey = "";
  // 热搜列表
  var hotList = [];
  // 显示全部热搜
  bool showAll = false;

  // 搜索内容
  TextEditingController searchText = new TextEditingController();

  @override
  initState() {
    super.initState();

    initData();
  }

  initData() {
    getDefaultSearchKey().then((value) {
      this.setState(() {
        defaultSearchKey = value['showKeyword'];
      });
    });

    getHotListDetail().then((value) {
      this.setState(() {
        hotList = value;
      });
    });
  }

  playClick() {}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 30;
    List<Widget> hotTitles = [];

    double fontSize = 14;

    int length = showAll ? hotList.length : (hotList.length / 2).round();

    for (var i = 0; i < length; i++) {
      hotTitles.add(
        Container(
          width: width / 2,
          height: 25,
          child: Row(children: [
            Container(
              width: 22,
              child: Text((i + 1).toString(),
                  style: TextStyle(
                      color: i < 3 ? Colors.red : Colors.grey,
                      fontSize: fontSize)),
            ),
            Text(
              hotList[i]['searchWord'],
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: i < 3 ? FontWeight.w600 : FontWeight.w400),
            ),
            hotList[i]['iconUrl'] != null
                ? Image.network(
                    hotList[i]['iconUrl'],
                    width: 30,
                    height: 12,
                  )
                : Text(''),
          ]),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          leadingWidth: 30,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Container(
            height: 38,
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: TextField(
              controller: searchText,
              decoration: InputDecoration(hintText: defaultSearchKey),
              style: TextStyle(fontSize: 20),
            ),
          )),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Wrap(
          children: [
            Container(
              width: width,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))),
              child: Stack(
                children: [
                  Container(
                    height: 30,
                    child: Text(
                      '热搜榜',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  Positioned(
                    width: 70,
                    height: 24,
                    right: 0,
                    top: 0,
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(4, 0, 2, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border:
                                Border.all(color: Colors.black38, width: 0.6)),
                        child: Wrap(children: [
                          Icon(
                            Icons.play_arrow,
                            size: 20,
                          ),
                          Text('播放')
                        ]),
                      ),
                      onTap: playClick,
                    ),
                  )
                ],
              ),
            ),
            ...hotTitles,
            showAll
                ? Text('')
                : Container(
                    child: Center(
                    child: TextButton(
                      child: Text(
                        '展开更多热搜',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onPressed: () {
                        this.setState(() {
                          showAll = true;
                        });
                      },
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}
