/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-07-05 13:56:38
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/components/Base/HeightRefresh.dart';
import 'package:cloudmusic_flutter/components/Base/IconRow.dart';
import 'package:cloudmusic_flutter/components/ModelComponent.dart';
import 'package:cloudmusic_flutter/components/SongListItem.dart';
import 'package:cloudmusic_flutter/model/MenuInfo.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/pages/homePage/my/headMenu.dart';
import 'package:cloudmusic_flutter/pages/homePage/my/userInfo.dart'
    as Component;
import 'package:cloudmusic_flutter/pages/playList/index.dart';
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
  double appbarOpacity = 0;

  List<List<MenuInfoModel>> menus = [];

  @override
  void initState() {
    super.initState();
  }

  songClick(context, id) {
    if (id > 0) {
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
        return PlayList(
          songId: id,
        );
      }));
    }
  }

  getRowObject(ele) {
    return IconRow(
      image: ele.coverImgUrl,
      title: ele.title.overFlowString(12),
      descript: '${ele.trackCount}首, 播放${ele.playCount.toMyriadString(1)}次',
      onTap: () {
        songClick(context, ele.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<User>(context);

    var playList = [];
    var createList = [];
    var likePlayList = new PlayListModel();

    if (userStore.playList.length > 0) {
      playList = userStore.playList
          .where((element) =>
              element.creator.userId != userStore.userInfo.userId &&
              element.specialType != 5)
          .toList();

      createList = userStore.playList
          .where((element) =>
              element.creator.userId == userStore.userInfo.userId &&
              element.specialType != 5)
          .toList();

      likePlayList =
          userStore.playList.firstWhere((element) => element.specialType == 5);
    }

    likePlayList.title = "我喜欢的音乐";

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
          title: Text(''),
          backgroundColor: Colors.white.withOpacity(appbarOpacity),
          elevation: 0,
          brightness: Brightness.light,
        ),
        backgroundColor: Colors.grey.shade100,
        body: Container(
          child: ListView(
            children: [
              Component.UserInfoWidget(),
              HeadMenu(),
              ModelComponent(
                children: [
                  getRowObject(likePlayList),
                ],
              ),
              ModelComponent(
                title: '创建歌单(${createList.length}个)',
                titleStyle: TextStyle(
                  color: Colors.grey,
                ),
                children: [
                  ...createList.map((ele) => getRowObject(ele)),
                ],
              ),
              ModelComponent(
                title: '收藏歌单(${playList.length}个)',
                titleStyle: TextStyle(
                  color: Colors.grey,
                ),
                children: [
                  ...playList.map(
                    (ele) => getRowObject(ele),
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
