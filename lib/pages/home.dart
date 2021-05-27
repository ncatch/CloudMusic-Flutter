/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-05-27 16:50:05
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/components/Base/PrimaryScrollBehavior.dart';
import 'package:cloudmusic_flutter/components/DrawerMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './homePage/blogs.dart';
import './homePage/cloudVillage.dart';
import './homePage/discover.dart';
import './homePage/my.dart';
import './homePage/sing.dart';

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

  GlobalKey<ScaffoldState> mainScaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    this.setState(() {
      pages = [
        Discover(mainScaffoldKey: mainScaffoldKey),
        Blogs(),
        My(mainScaffoldKey: mainScaffoldKey),
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
    // AnnotatedRegion<SystemUiOverlayStyle>(
    //   value: SystemUiOverlayStyle.light,
    //   child: Material(child:Scaffold(),),);
    // }
    return Scaffold(
      key: mainScaffoldKey,
      drawer: DrawerMenu(),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 1,
            child: ScrollConfiguration(
              behavior: PrimaryScrollBehavior(show: false),
              child: pages.length > 0 ? pages[_selectedIndex] : Text('加载中...'),
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
      ),
    );
  }
}
