/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:03:55
 * @LastEditTime: 2021-06-01 19:27:30
 * @LastEditors: Walker
 */
// @dart=2.9

import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import './pages/home.dart';
import 'libs/config.dart';
import 'libs/routes.dart';
import './libs/theme.dart';
import './utils/http.dart';

import './store/SystemInfo.dart';
import './store/PlayInfo.dart';
import './store/User.dart';

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

  await SentryFlutter.init(
    (options) {
      options.dsn = senTryUrl;
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: new PlayInfoStore()),
        ChangeNotifierProvider.value(value: new SystemInfo()),
        ChangeNotifierProvider.value(value: new User()),
      ],
      child: MyApp(),
    )),
  );
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
          appBarTheme: new AppBarTheme(backgroundColor: primaryColor)),
      home: Home(),
      routes: routes,
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: BotToastInit(),
    );
  }
}
