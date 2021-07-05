/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-08 10:34:13
 * @LastEditTime: 2021-07-02 10:42:45
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/pages/cloudStorage/index.dart';
import 'package:cloudmusic_flutter/pages/localMusic.dart';
import 'package:cloudmusic_flutter/pages/playList/index.dart';
import 'package:cloudmusic_flutter/pages/subList.dart';
import 'package:flutter/cupertino.dart';

import '../components/SearchPage.dart';
import '../pages/login/index.dart';
import '../pages/login/login.dart' as AccountLogin;
import '../pages/setting.dart';

var routes = <String, WidgetBuilder>{
  '/search': (BuildContext context) => SearchPage(),
  '/login': (BuildContext context) => Login(),
  '/AccountLogin': (BuildContext context) => AccountLogin.Login(),
  '/playList': (BuildContext context) => PlayList(),
  '/setting': (BuildContext context) => Setting(),
  '/localMusic': (BuildContext context) => LocalMusic(),
  '/cloudStorage': (BuildContext context) => CloudStorage(),
  '/subList': (BuildContext context) => SubList(),
};
