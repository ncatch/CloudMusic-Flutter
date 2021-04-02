import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './homePage/blogs.dart';
import './homePage/cloudVillage.dart';
import './homePage/discover.dart';
import './homePage/my.dart';
import './homePage/sing.dart';

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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),
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
