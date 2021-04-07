/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-04-07 19:31:43
 * @LastEditors: Walker
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './homePage/blogs.dart';
import './homePage/cloudVillage.dart';
import './homePage/discover.dart';
import './homePage/my.dart';
import './homePage/sing.dart';
import '../components/DrawerMenu.dart';

import '../libs/theme.dart';

class HomeStatefulWidget extends StatefulWidget {
  HomeStatefulWidget({Key? key}) : super(key: key);

  @override
  _HomeStatefulWidgetState createState() => _HomeStatefulWidgetState();
}

class _HomeStatefulWidgetState extends State<HomeStatefulWidget> {
  int _selectedIndex = 0;

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
            backgroundColor: primaryColor,
            title: Container(
              height: 38,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  Text(
                    '搜索',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            )),
        body: [
          Discover(),
          Blogs(),
          My(),
          Sing(),
          CloudVillage(),
        ][_selectedIndex],
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
