/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:03:55
 * @LastEditTime: 2021-04-30 19:05:31
 * @LastEditors: Walker
 */
// @dart=2.9
import 'package:cloudmusic_flutter/store/SystemInfo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './pages/home.dart';
import 'libs/routes.dart';
import './libs/theme.dart';
import './utils/http.dart';

import './store/PlayInfo.dart';

void main() async {
  // GestureBinding.instance.resamplingEnabled = true;

  // 沉浸状态栏
  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: new PlayInfoStore()),
      ChangeNotifierProvider.value(value: new SystemInfo()),
    ],
    child: MyApp(),
  ));

  // http请求拦截器
  DioUtil.tokenInter();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '网抑云',
      theme: ThemeData(
          primaryColor: primaryColor,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white),
      home: HomeStatefulWidget(),
      routes: routes,
    );
  }
}
