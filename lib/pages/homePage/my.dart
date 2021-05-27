/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-05-27 16:55:03
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/components/Base/HeightRefresh.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:cloudmusic_flutter/store/SystemInfo.dart';
import 'package:cloudmusic_flutter/store/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class My extends StatefulWidget {
  final GlobalKey<ScaffoldState> mainScaffoldKey;

  My({Key? key, required this.mainScaffoldKey}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyState();
}

class MyState extends State<My> {
  bool isInit = false;
  List<PlayListModel> playList = [];
  double appbarOpacity = 0;

  @override
  void initState() {
    super.initState();
  }

  init(userStore) {
    // 获取用户歌单
    getPayList(userStore.userInfo.userId);
    isInit = true;
  }

  getPayList(id) {
    getUserPlayList(id).then((res) {
      if (res['code'] == 200) {
        this.setState(() {
          playList = List<PlayListModel>.from(res['playlist']
              .map<PlayListModel>((ele) => PlayListModel.fromData(ele)));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<User>(context);
    var systemInfo = Provider.of<SystemInfo>(context);

    if (!isInit) {
      init(userStore);
    }

    return HeightRefresh(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              widget.mainScaffoldKey.currentState?.openDrawer();
            },
          ),
          title: Container(
            child: Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(userStore.userInfo.avatarUrl),
                    ),
                  ),
                ),
                Text(userStore.userInfo.nickname),
              ],
            ),
          ),
          backgroundColor: Colors.white.withOpacity(appbarOpacity),
          brightness: systemInfo.brightNess,
        ),
        body: Container(),
      ),
    );
  }
}
