/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:03:55
 * @LastEditTime: 2021-05-13 13:41:00
 * @LastEditors: Walker
 */
// @dart=2.9

import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import './pages/home.dart';
import 'libs/config.dart';
import 'libs/routes.dart';
import './libs/theme.dart';
import './utils/http.dart';

import './store/SystemInfo.dart';
import './store/PlayInfo.dart';
import './store/User.dart';

import './libs/extends/StringExtend.dart';

_initSystemInfo() {
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      isMobile = true;
    }
  } catch (e) {
    isMobile = false;
  }
}

void main() async {
  // GestureBinding.instance.resamplingEnabled = true;

  // 沉浸状态栏
  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  // http请求拦截器
  DioUtil.tokenInter();

  _initSystemInfo();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: new PlayInfoStore()),
      ChangeNotifierProvider.value(value: new SystemInfo()),
      ChangeNotifierProvider.value(value: new User()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    if (isMobile) {
      _checkPermission();
    }
  }

  // 申请权限
  Future _checkPermission() async {
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      return;
    }

    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '网抑云',
      theme: ThemeData(
        primaryColor: primaryColor,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomeStatefulWidget(),
      routes: routes,
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: BotToastInit(),
    );
  }
}
