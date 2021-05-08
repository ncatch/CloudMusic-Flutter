/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-08 10:34:13
 * @LastEditTime: 2021-05-08 10:49:31
 * @LastEditors: Walker
 */

import 'package:flutter/cupertino.dart';

import '../components/SearchPage.dart';
import '../pages/login.dart';

var routes = <String, WidgetBuilder>{
  '/search': (BuildContext context) => SearchPage(),
  '/login': (BuildContext context) => Login(),
};
