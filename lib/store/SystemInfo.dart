/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-30 19:03:03
 * @LastEditTime: 2021-05-19 21:57:45
 * @LastEditors: Walker
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

class SystemInfo with ChangeNotifier {
  Brightness brightNess = Brightness.dark;
  DisplayMode? currDisplayMode;

  setDisplayMode(DisplayMode mode) {
    currDisplayMode = mode;
    notifyListeners();
  }
}
