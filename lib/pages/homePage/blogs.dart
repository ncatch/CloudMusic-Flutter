/*
 * @Description: 
 * @Author: nocatch
 * @Date: 2021-04-03 15:50:55
 * @LastEditTime: 2021-05-19 21:59:24
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/store/SystemInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:provider/provider.dart';

class Blogs extends StatefulWidget {
  Blogs({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BlogsState();
  }
}

class BlogsState extends State<Blogs> {
  bool init = false;
  List<DisplayMode> modes = [];
  DisplayMode? active;

  @override
  void initState() {
    super.initState();

    initModelData();
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

    return Container(
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
    );
  }
}
