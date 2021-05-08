/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:03:55
 * @LastEditTime: 2021-05-08 17:35:22
 * @LastEditors: Walker
 */
// @dart=2.9

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './pages/home.dart';
import 'libs/routes.dart';
import './libs/theme.dart';
import './utils/http.dart';

import './store/SystemInfo.dart';
import './store/PlayInfo.dart';
import './store/User.dart';

void main() async {
  // GestureBinding.instance.resamplingEnabled = true;

  // 沉浸状态栏
  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  // http请求拦截器
  DioUtil.tokenInter();

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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '网抑云',
      theme: ThemeData(
          primaryColor: primaryColor,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white),
      home: HomeStatefulWidget(),
      routes: routes,
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: BotToastInit(),
    );
  }
}
