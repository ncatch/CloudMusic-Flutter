/*
 * @Description: 
 * @Author: nocatch
 * @Date: 2021-05-19 22:21:01
 * @LastEditTime: 2021-05-19 22:32:25
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/libs/config.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

class RefreshRate {
  bool isInit = false;

  refreshRateInit([DisplayMode? mode]) {
    if (!isInit) {
      if (isMobile) {
        if (mode != null) {
          FlutterDisplayMode.setPreferredMode(mode);
        } else {
          FlutterDisplayMode.setHighRefreshRate(); // 设置最高刷新率 最高分辨率
        }
      }

      isInit = true;
    }
  }
}
