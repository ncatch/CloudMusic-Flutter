/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-08 10:34:13
 * @LastEditTime: 2021-06-01 17:26:39
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/pages/localMusic.dart';
import 'package:cloudmusic_flutter/pages/playList/index.dart';
import 'package:flutter/cupertino.dart';

import '../components/SearchPage.dart';
import '../pages/login/index.dart';
import '../pages/setting.dart';

var routes = <String, WidgetBuilder>{
  '/search': (BuildContext context) => SearchPage(),
  '/login': (BuildContext context) => Login(),
  '/playList': (BuildContext context) => PlayList(),
  '/setting': (BuildContext context) => Setting(),
  '/localMusic': (BuildContext context) => LocalMusic(),
};
