/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-20 16:44:42
 * @LastEditTime: 2021-05-20 16:47:06
 * @LastEditors: Walker
 */

import 'package:bot_toast/bot_toast.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:flutter/material.dart';

void Toast(String msg) {
  BotToast.showText(
    text: msg,
    contentColor: Colors.white,
    textStyle: TextStyle(color: Colors.black),
  );
}

void Function() ShowLoading() {
  return BotToast.showLoading(
    backgroundColor: primaryColor,
  );
}
