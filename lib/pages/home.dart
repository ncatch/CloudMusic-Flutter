/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-05-10 17:37:41
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './homePage/blogs.dart';
import './homePage/cloudVillage.dart';
import './homePage/discover.dart';
import './homePage/my.dart';
import './homePage/sing.dart';
import '../components/DrawerMenu.dart';

import '../components/PlayMini.dart';

import '../libs/theme.dart';

class HomeStatefulWidget extends StatefulWidget {
  HomeStatefulWidget({Key? key}) : super(key: key);

  @override
  _HomeStatefulWidgetState createState() => _HomeStatefulWidgetState();
}

class _HomeStatefulWidgetState extends State<HomeStatefulWidget> {
  int _selectedIndex = 0;
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();

    this.setState(() {
      pages = [
        Discover(),
        Blogs(),
        My(),
        Sing(),
        CloudVillage(),
      ];
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerMenu(),
        appBar: AppBar(
            title: Container(
          height: 38,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/search');
            },
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                Text(
                  '搜索',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        )),
        body: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: ListView(
                children: [
                  pages.length > 0 ? pages[_selectedIndex] : Text('加载中...')
                ],
              ),
            ),
            PlayMini()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.adjust), label: '发现'),
            BottomNavigationBarItem(icon: Icon(Icons.adjust), label: '博客'),
            BottomNavigationBarItem(icon: Icon(Icons.adjust), label: '我的'),
            BottomNavigationBarItem(icon: Icon(Icons.adjust), label: 'K歌'),
            BottomNavigationBarItem(icon: Icon(Icons.adjust), label: '云村'),
          ],
          currentIndex: _selectedIndex,
          showUnselectedLabels: true,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ));
  }
}
