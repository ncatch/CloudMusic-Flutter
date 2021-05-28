/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-07 15:41:21
 * @LastEditTime: 2021-05-28 16:02:31
 * @LastEditors: Walker
 */
import 'package:flutter/material.dart';

class MenuInfoModel {
  String text = "";
  IconData? icon;
  String iconUrl = "";
  String url = "";
  late Function onPressed;
  Color? color;

  MenuInfoModel(
    String text, {
    String iconUrl = "",
    IconData? icon,
    String url = "",
    Function? onPressed,
    Color? color,
  }) {
    this.text = text;
    this.icon = icon;
    this.iconUrl = iconUrl;
    this.url = url;
    this.onPressed = onPressed ?? () {};
    this.color = color;
  }
}
