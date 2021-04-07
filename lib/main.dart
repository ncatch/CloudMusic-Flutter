/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:03:55
 * @LastEditTime: 2021-04-07 15:21:03
 * @LastEditors: Walker
 */
// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './pages/home.dart';
import './utils/preference.dart';

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
      title: 'Flutter Demo',
      home: HomeStatefulWidget(),
    );
  }
}
