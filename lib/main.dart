/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:03:55
 * @LastEditTime: 2021-04-08 14:13:58
 * @LastEditors: Walker
 */
// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './pages/home.dart';
import 'libs/routes.dart';
import './libs/theme.dart';

void main() async {
  runApp(MyApp());

  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
