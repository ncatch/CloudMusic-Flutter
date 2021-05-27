/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-05-27 19:40:30
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/components/Base/HeightRefresh.dart';
import 'package:cloudmusic_flutter/components/ModelComponent.dart';
import 'package:cloudmusic_flutter/components/SongListItem.dart';
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
          title: Text('用户信息'),
          backgroundColor: Colors.white.withOpacity(appbarOpacity),
          elevation: 0,
          brightness: systemInfo.brightNess,
        ),
        backgroundColor: Colors.grey.shade100,
        body: Container(
          child: ListView(
            children: [
              Container(
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            userStore.userInfo.avatarUrl,
                            fit: BoxFit.fill,
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(userStore.userInfo.nickname),
                          Text('Lv${userStore.levelInfo.level}'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ModelComponent(
                title: '收藏歌单(${playList.length}个)',
                titleStyle: TextStyle(
                  color: Colors.grey,
                ),
                children: [
                  ...playList.take(10).map(
                        (ele) => SongListItem(
                          info: ele,
                        ),
                      ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
