/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-07-02 10:43:54
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/components/Base/HeightRefresh.dart';
import 'package:cloudmusic_flutter/components/ModelComponent.dart';
import 'package:cloudmusic_flutter/components/SongListItem.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:cloudmusic_flutter/model/MenuInfo.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/pages/friend.dart';
import 'package:cloudmusic_flutter/pages/userInfo.dart';
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

    menus = [
      [
        MenuInfoModel('本地/下载',
            icon: Icons.library_music, onPressed: localMusicClick),
        MenuInfoModel('云盘',
            icon: Icons.cloud_upload, onPressed: cloudStorageClick),
        MenuInfoModel('已购', icon: Icons.shopping_bag),
        MenuInfoModel('最近播放', icon: Icons.play_circle),
      ],
      [
        MenuInfoModel('我的好友',
            icon: Icons.supervised_user_circle, onPressed: myFriendClick),
        MenuInfoModel('收藏和赞',
            icon: Icons.star_rounded, onPressed: subListClick),
        MenuInfoModel('我的博客', icon: Icons.rss_feed_outlined),
        MenuInfoModel('音乐应用',
            icon: Icons.add_circle_outlined, color: Colors.grey.shade200),
      ],
    ];
  }

  localMusicClick(context, User userStore) {
    Navigator.pushNamed(context, '/localMusic');
  }

  cloudStorageClick(context, User userStore) {
    Navigator.pushNamed(context, '/cloudStorage');
  }

  subListClick(context, User userStore) {
    Navigator.pushNamed(context, '/subList');
  }

  myFriendClick(context, User userStore) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return Friend(
        userId: userStore.userInfo.userId,
      );
    }));
  }

  userClick(User userStore) {
    if (userStore.userInfo.userId > 0) {
      // 跳转用户信息页面
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
        return UserInfo(id: userStore.userInfo.userId);
      }));
    } else {
      // 登录
      Navigator.pushNamed(context, '/login');
    }
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
              Container(
                padding: EdgeInsets.all(20),
                child: InkWell(
                  onTap: () {
                    userClick(userStore);
                  },
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(right: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: NetworkImage(userStore.userInfo.avatarUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      userStore.userInfo.userId > 0
                          ? Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userStore.userInfo.nickname,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    padding: EdgeInsets.fromLTRB(12, 2, 12, 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white60,
                                    ),
                                    child: Text(
                                      'Lv.${userStore.userInfo.level}',
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              child: Text(
                                '立即登录',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                      Container(
                        child: Icon(Icons.navigate_next),
                      )
                    ],
                  ),
                ),
              ),
              ModelComponent(children: [
                Column(
                  children: menus
                      .map((row) => Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: row
                                  .map((e) => Expanded(
                                        flex: 1,
                                        child: MenuComponent(
                                          icon: Icon(
                                            e.icon,
                                            color: e.color ?? primaryColor,
                                            size: 30,
                                          ),
                                          text: e.text,
                                          onPressed: () {
                                            e.onPressed(context, userStore);
                                          },
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ))
                      .toList(),
                )
              ]),
              ModelComponent(
                children: [
                  SongListItem(
                    info: likePlayList,
                  ),
                ],
              ),
              ModelComponent(
                title: '创建歌单(${createList.length}个)',
                titleStyle: TextStyle(
                  color: Colors.grey,
                ),
                children: [
                  ...createList.map(
                    (ele) => SongListItem(
                      info: ele,
                    ),
                  ),
                ],
              ),
              ModelComponent(
                title: '收藏歌单(${playList.length}个)',
                titleStyle: TextStyle(
                  color: Colors.grey,
                ),
                children: [
                  ...playList.map(
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

class MenuComponent extends StatelessWidget {
  String text = '';
  final void Function() onPressed;
  final Icon? icon;
  double? width;

  MenuComponent({
    Key? key,
    required this.onPressed,
    this.text = '',
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: Alignment.center,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon ?? Container(),
            Text(
              text,
              style: TextStyle(color: Colors.black87, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
