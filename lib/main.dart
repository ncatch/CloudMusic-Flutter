// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './pages/home.dart';


void main() {
  runApp(MyApp());
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
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
