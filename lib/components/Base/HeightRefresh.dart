/*
 * @Description: 
 * @Author: nocatch
 * @Date: 2021-05-19 22:21:01
 * @LastEditTime: 2021-05-21 17:50:58
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/libs/config.dart';
import 'package:cloudmusic_flutter/store/SystemInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:provider/provider.dart';

class HeightRefresh extends StatelessWidget {
  Widget child;

  bool isInit = false;

  HeightRefresh({Key? key, required this.child});

  init(SystemInfo systemInfo) {
    refreshRateInit(systemInfo.currDisplayMode);

    isInit = true;
  }

  refreshRateInit([DisplayMode? mode]) {
    if (isMobile) {
      if (mode != null) {
        FlutterDisplayMode.setPreferredMode(mode);
      } else {
        FlutterDisplayMode.setHighRefreshRate(); // 设置最高刷新率 最高分辨率
      }
    }
  }

  @protected
  Widget build(BuildContext context) {
    var systemInfo = Provider.of<SystemInfo>(context);

    if (!isInit) {
      init(systemInfo);
    }

    return child;
  }
}
