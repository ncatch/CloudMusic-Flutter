/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-05-21 19:45:13
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:cloudmusic_flutter/store/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class My extends StatefulWidget {
  My({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyState();
}

class MyState extends State<My> {
  bool isInit = false;
  List<PlayListModel> playList = [];

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
    if (!isInit) {
      init(userStore);
    }

    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: playList.length,
            itemBuilder: (context, index) {
              return Container(
                child: Text(playList[index].title),
              );
            }),
      ),
    );
  }
}
