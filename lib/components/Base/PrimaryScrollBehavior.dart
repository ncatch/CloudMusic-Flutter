/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-19 17:55:07
 * @LastEditTime: 2021-05-19 18:01:25
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:flutter/material.dart';

class PrimaryScrollBehavior extends ScrollBehavior {
  final bool show;
  final Color? color;

  PrimaryScrollBehavior({Key? key, this.show = true, this.color});

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          child: child,
          // 不显示头部水波纹
          showLeading: show,
          // 不显示尾部水波纹
          showTrailing: show,
          axisDirection: axisDirection,
          color: color ?? primaryColor,
        );
      case TargetPlatform.linux:
        break;
      case TargetPlatform.macOS:
        break;
      case TargetPlatform.windows:
        break;
    }
    return child;
  }
}
