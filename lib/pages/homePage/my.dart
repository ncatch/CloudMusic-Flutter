/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-05-28 16:40:09
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/components/Base/HeightRefresh.dart';
import 'package:cloudmusic_flutter/components/ModelComponent.dart';
import 'package:cloudmusic_flutter/components/SongListItem.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:cloudmusic_flutter/model/MenuInfo.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/pages/userInfo.dart';
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
  PlayListModel likePlayList = PlayListModel();
  List<PlayListModel> playList = [];
  double appbarOpacity = 0;

  List<List<MenuInfoModel>> menus = [];

  @override
  void initState() {
    super.initState();

    menus = [
      [
        MenuInfoModel('本地/下载', icon: Icons.library_music),
        MenuInfoModel('云盘', icon: Icons.cloud_upload),
        MenuInfoModel('已购', icon: Icons.shopping_bag),
        MenuInfoModel('最近播放', icon: Icons.play_circle),
      ],
      [
        MenuInfoModel('我的好友', icon: Icons.supervised_user_circle),
        MenuInfoModel('收藏和赞', icon: Icons.star_rounded),
        MenuInfoModel('我的博客', icon: Icons.rss_feed_outlined),
        MenuInfoModel('音乐应用',
            icon: Icons.add_circle_outlined, color: Colors.grey.shade200),
      ],
    ];
  }

  init(userStore) {
    // 获取用户歌单
    getPayList(userStore.userInfo.userId);
    isInit = true;
  }

  getPayList(id) {
    getUserPlayList(id).then((res) {
      if (res['code'] == 200) {
        var tmp = List<PlayListModel>.from(res['playlist']
            .map<PlayListModel>((ele) => PlayListModel.fromData(ele)));

        this.setState(() {
          playList = tmp.where((element) => element.specialType != 5).toList();

          likePlayList = tmp.firstWhere((element) => element.specialType == 5);

          likePlayList.title = "我喜欢的音乐";
        });
      }
    });
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
          title: Text(''),
          backgroundColor: Colors.white.withOpacity(appbarOpacity),
          elevation: 0,
          brightness: systemInfo.brightNess,
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
                                            size: 36,
                                          ),
                                          text: e.text,
                                          onPressed: () {
                                            e.onPressed();
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
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            icon ?? Container(),
            Text(text),
          ],
        ),
      ),
    );
  }
}
