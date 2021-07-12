/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-07-12 15:49:20
 * @LastEditors: Walker
 */
import 'dart:io';

import 'package:cloudmusic_flutter/components/Base/PrimaryScrollBehavior.dart';
import 'package:cloudmusic_flutter/components/DrawerMenu.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:cloudmusic_flutter/store/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './homePage/blogs.dart';
import './homePage/cloudVillage.dart';
import 'homePage/discover/discover.dart';
import './homePage/my/my.dart';
import './homePage/sing.dart';

import '../components/PlayMini.dart';

import '../libs/theme.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  bool isInit = false;
  int _selectedIndex = 0;
  List<Widget> pages = [];

  GlobalKey<ScaffoldState> mainScaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    this.setState(() {
      pages = [
        Discover(mainScaffoldKey: mainScaffoldKey),
        // Blogs(),
        My(mainScaffoldKey: mainScaffoldKey),
        // Sing(),
        // CloudVillage(),
      ];
    });
  }

  init(context) {
    var playInfoStore = Provider.of<PlayInfoStore>(context);
    playInfoStore.init();

    var userStore = Provider.of<User>(context);
    userStore.init().then((userInfo) {
      if (userInfo.userId == 0) {
        // TODO 调试注释
        Navigator.pushNamed(context, '/login');
      }
    });

    isInit = true;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onBackPressed() {
    showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('确定退出程序吗?'),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    '暂不',
                    style: TextStyle(color: primaryColor),
                  ),
                  onPressed: () => Navigator.pop(context, false),
                ),
                TextButton(
                  child: Text(
                    '确定',
                    style: TextStyle(color: primaryColor),
                  ),
                  onPressed: () => exit(0),
                ),
              ],
            ));
    return Future.sync(() => false);
  }

  @override
  Widget build(BuildContext context) {
    if (!isInit) {
      init(context);
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: mainScaffoldKey,
        drawer: DrawerMenu(),
        body: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: ScrollConfiguration(
                behavior: PrimaryScrollBehavior(show: false),
                child:
                    pages.length > 0 ? pages[_selectedIndex] : Text('加载中...'),
              ),
            ),
            PlayMini()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.adjust), label: '发现'),
            // BottomNavigationBarItem(icon: Icon(Icons.adjust), label: '博客'),
            BottomNavigationBarItem(icon: Icon(Icons.adjust), label: '我的'),
            // BottomNavigationBarItem(icon: Icon(Icons.adjust), label: 'K歌'),
            // BottomNavigationBarItem(icon: Icon(Icons.adjust), label: '云村'),
          ],
          currentIndex: _selectedIndex,
          showUnselectedLabels: true,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
