/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-05-28 16:25:50
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/store/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../libs/theme.dart';

class DrawerMenu extends StatefulWidget {
  DrawerMenu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DrawerMenuState();
}

class DrawerMenuState extends State<DrawerMenu> {
  toLogin() {
    Navigator.pushNamed(context, '/login');
  }

  toSetting() {
    Navigator.pushNamed(context, '/setting');
  }

  exitLogin(User userStore) {
    userStore.clearUserInfo();
    toLogin();
  }

  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<User>(context);

    var isLogin = userStore.userInfo.userId > 0;
    var textStyle = TextStyle(color: Colors.white, fontSize: 24);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Container(
              alignment: Alignment.center,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  isLogin
                      ? Container(
                          height: 80,
                          width: 80,
                          margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: isLogin
                                ? Image.network(
                                    userStore.userInfo.avatarUrl,
                                    fit: BoxFit.fill,
                                  )
                                : Text(''),
                          ),
                        )
                      : Text(''),
                  isLogin
                      ? Text(
                          userStore.userInfo.nickname,
                          style: textStyle,
                        )
                      : TextButton(
                          onPressed: toLogin,
                          child: Text(
                            '立即登录',
                            style: textStyle,
                          ),
                        )
                ],
              ),
            ),
          ),
          isLogin
              ? ListTile(
                  leading: Icon(Icons.power_settings_new),
                  title: Text('退出登录'),
                  onTap: () {
                    exitLogin(userStore);
                  },
                )
              : Text(''),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('设置'),
            onTap: toSetting,
          ),
        ],
      ),
    );
  }
}
