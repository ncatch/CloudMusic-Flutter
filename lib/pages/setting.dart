/*
 * @Description: 
 * @Author: nocatch
 * @Date: 2021-04-03 15:50:55
 * @LastEditTime: 2021-05-21 17:32:00
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/libs/config.dart';
import 'package:cloudmusic_flutter/store/SystemInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  Setting({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SettingState();
  }
}

class SettingState extends State<Setting> {
  bool init = false;
  List<DisplayMode> modes = [];
  DisplayMode? active;

  @override
  void initState() {
    super.initState();

    if (isMobile) {
      initModelData();
    }
  }

  initModelData() async {
    List<DisplayMode> modes = await FlutterDisplayMode.supported;
    this.setState(() {
      this.modes = modes;
    });
  }

  setModel(model) async {
    FlutterDisplayMode.setPreferredMode(model);

    var tmp = await FlutterDisplayMode.active;

    this.setState(() {
      active = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    var systemInfo = Provider.of<SystemInfo>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('设置模式：' + systemInfo.currDisplayMode.toString()),
            Text('当前模式：' + active.toString()),
            ...modes.map(
              (e) => TextButton(
                onPressed: () {
                  systemInfo.setDisplayMode(e);
                  setModel(e);
                },
                child: Text(
                  e.toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
