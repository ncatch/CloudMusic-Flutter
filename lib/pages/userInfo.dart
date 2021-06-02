/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-20 10:35:17
 * @LastEditTime: 2021-06-02 16:52:30
 * @LastEditors: Walker
 */
import 'dart:ui';

import 'package:cloudmusic_flutter/components/ModelComponent.dart';
import 'package:cloudmusic_flutter/components/PlayMini.dart';
import 'package:cloudmusic_flutter/components/SongListItem.dart';
import 'package:cloudmusic_flutter/libs/extends/Toast.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:flutter/material.dart';
import '../model/UserInfo.dart' as model;
import '../libs/extends/IntExtend.dart';
import '../libs/extends/DateTime.dart';

class UserInfo extends StatefulWidget {
  final int id;
  UserInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserInfoState();
}

class UserInfoState extends State<UserInfo>
    with SingleTickerProviderStateMixin {
  double headHeight = 250;
  ScrollController _controller = ScrollController();
  TabController? _tabController;

  model.UserInfo userInfo = new model.UserInfo();

  TextStyle numStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  Color appbarColor = Colors.transparent;
  Color appColor = Colors.white;

  double scrollTop = 0;

  List<PlayListModel> playListModes = [];

  int currTabIndex = 0;

  @override
  initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.offset > 200) {
        if (_controller.offset < 350) {
          this.setState(() {
            scrollTop = _controller.offset;
          });
        }

        return;
      }
      double t = _controller.offset / 150;
      if (t < 0.0) {
        t = 0.0;
      } else if (t > 1.0) {
        t = 1.0;
      }

      var rgb = (255 * (1 - t)).round();

      this.setState(() {
        appbarColor = Colors.white.withOpacity(t);
        appColor = Color.fromRGBO(rgb, rgb, rgb, 1);
        scrollTop = _controller.offset;
      });
    });

    _tabController = new TabController(length: 2, vsync: this);

    _tabController?.addListener(() {
      if (currTabIndex != _tabController?.index) {
        this.setState(() {
          currTabIndex = _tabController!.index;
        });
      }
    });

    getUserDetail(widget.id).then((res) {
      if (res['code'] == 200) {
        this.setState(() {
          res['profile']['level'] = res['level'];
          userInfo = model.UserInfo.fromJson(res['profile']);
        });
      }
    });

    getUserPlayList(widget.id).then((res) {
      if (res['code'] == 200) {
        setState(() {
          playListModes = List<PlayListModel>.from(res['playlist']
              .map<PlayListModel>((ele) => PlayListModel.fromData(ele)));
        });
      } else {
        Toast(res['msg'] ?? '网络异常');
      }
    });

    this.getUserEventList();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _tabController?.dispose();
  }

  attention() {
    attentionUser(userInfo.userId, userInfo.followed ? 2 : 1).then((res) {
      if (res['code'] == 200) {
        this.setState(() {
          if (userInfo.followed) {
            Toast('谢谢关注');
          } else {
            Toast('已取消关注');
          }
          if (userInfo.followeds < 10000) {
            userInfo.followeds += userInfo.followed ? -1 : 1;
          }
          userInfo.followed = !userInfo.followed;
        });
      } else {
        Toast(res['msg'] ?? '网络异常');
      }
    });
  }

  getUserEventList() {
    // 用户动态
    getUserEvent(widget.id).then((res) {});
  }

  dynamicClick() {}

  showAllBasicInfo() {}

  showAllSongList(type) {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var bgColor = Colors.grey.shade100;
    var headColors = <Color>[
      Colors.white10,
      Colors.grey.shade100,
    ];

    if (currTabIndex != 0) {
      headColors = <Color>[
        Colors.white10,
        Colors.white,
      ];
      bgColor = Colors.white;
    }

    var now = DateTime.now();
    var createTime = DateTime.fromMillisecondsSinceEpoch(
      userInfo.createTime,
    );

    var birthday = DateTime.fromMillisecondsSinceEpoch(
      userInfo.birthday,
    );

    var descRow = userInfo.mainAuthType.desc != ""
        ? Row(
            children: [
              userInfo.avatarDetail.identityIconUrl != ""
                  ? Image.network(
                      userInfo.avatarDetail.identityIconUrl,
                      width: 16,
                      height: 16,
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.only(left: 8),
                child: Text(userInfo.mainAuthType.desc),
              ),
            ],
          )
        : null;

    var likeList;
    List<PlayListModel> createList = [];
    List<PlayListModel> collectList = [];
    double contentHeight = 260;

    if (playListModes.length > 0) {
      likeList =
          playListModes.firstWhere((element) => element.specialType == 5);
      likeList.title = "我喜欢的音乐";

      contentHeight += 150;

      createList = playListModes
          .where((element) =>
              element.creator.userId == widget.id && element.specialType != 5)
          .toList();
      collectList = playListModes
          .where((element) =>
              element.creator.userId != widget.id && element.specialType != 5)
          .toList();

      if (createList.length > 0) {
        contentHeight +=
            60 + 60 * (createList.length > 10 ? 10 : createList.length);

        if (createList.length > 10) {
          contentHeight += 40;
        }
      }
      if (collectList.length > 0) {
        contentHeight +=
            60 + 60 * (collectList.length > 10 ? 10 : collectList.length);

        if (collectList.length > 10) {
          contentHeight += 40;
        }
      }
    }

    return Scaffold(
      body: Container(
        color: bgColor,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  // 头部背景
                  Positioned(
                    width: size.width,
                    height: headHeight,
                    top: -scrollTop / 2,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: new NetworkImage(userInfo.backgroundUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  // 头部渐变
                  Positioned(
                    width: size.width,
                    height: headHeight + 100,
                    top: -scrollTop,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                          begin: const Alignment(0.0, -0.2),
                          end: const Alignment(0.0, 0.3),
                          colors: headColors,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    width: size.width,
                    height: headHeight + 100,
                    top: -scrollTop,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: headHeight - 60),
                          height: 90,
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.network(
                                    userInfo.avatarUrl,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Wrap(
                                  children: [
                                    Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Text(
                                                '${userInfo.followeds.toMyriadString(1)}',
                                                style: numStyle,
                                              ),
                                              Text('粉丝')
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Text(
                                                '${userInfo.follows}',
                                                style: numStyle,
                                              ),
                                              Text('关注')
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Text(
                                                'Lv.${userInfo.level}',
                                                style: numStyle,
                                              ),
                                              Text('等级')
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10),
                                            padding:
                                                EdgeInsets.fromLTRB(0, 5, 0, 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: userInfo.followed
                                                  ? Colors.grey.shade300
                                                  : primaryColor,
                                            ),
                                            child: InkWell(
                                              onTap: attention,
                                              child: Text(
                                                userInfo.followed
                                                    ? '已关注'
                                                    : '+ 关注',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: userInfo.followed
                                                      ? Colors.grey
                                                      : Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 8),
                                          child: IconButton(
                                            icon: Icon(Icons.email_outlined),
                                            onPressed: dynamicClick,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: userInfo.mainAuthType.desc != "" ? 40 : 0,
                          padding: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          child: descRow,
                        ),
                      ],
                    ),
                  ),
                  ListView(
                    controller: _controller,
                    children: [
                      Container(
                        height: headHeight + 80,
                      ),
                      Container(
                        width: size.width,
                        height: contentHeight,
                        color: bgColor,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Column(
                              children: [
                                ModelComponent(
                                  title: '基本信息',
                                  children: [
                                    userInfo.mainAuthType.desc != ''
                                        ? Container(
                                            padding: EdgeInsets.only(left: 15),
                                            child: descRow,
                                          )
                                        : Container(),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 10, 15, 0),
                                      child: Text(
                                        '村龄：${now.year - createTime.year} (${createTime.format('yyyy年MM月注册')})',
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 10, 15, 0),
                                      child: Text(
                                          '年龄：${now.year - birthday.year}'),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 10, 15, 0),
                                      child: Text('地区：${userInfo.city}'),
                                    ),
                                    ShowAllBtn(
                                      onTap: showAllBasicInfo,
                                    ),
                                  ],
                                ),
                                likeList != null
                                    ? ModelComponent(
                                        title: '音乐品味',
                                        children: [
                                          SongListItem(
                                            info: likeList,
                                          ),
                                        ],
                                      )
                                    : Container(),
                                createList.length > 0
                                    ? ModelComponent(
                                        title: '创建的歌单',
                                        children: [
                                          ...createList.take(10).map(
                                                (ele) => SongListItem(
                                                  info: ele,
                                                ),
                                              ),
                                          createList.length > 10
                                              ? ShowAllBtn(
                                                  onTap: () {
                                                    showAllSongList(1);
                                                  },
                                                )
                                              : Container()
                                        ],
                                      )
                                    : Container(),
                                collectList.length > 0
                                    ? ModelComponent(
                                        title: '收藏的歌单',
                                        children: [
                                          ...collectList.take(10).map(
                                                (ele) => SongListItem(
                                                  info: ele,
                                                ),
                                              ),
                                          collectList.length > 10
                                              ? ShowAllBtn(
                                                  onTap: () {
                                                    showAllSongList(2);
                                                  },
                                                )
                                              : Container()
                                        ],
                                      )
                                    : Container(),
                              ],
                            ),
                            Column(
                              children: [],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    width: size.width,
                    height: 40,
                    top: scrollTop < headHeight - 10
                        ? (headHeight + 40) - scrollTop
                        : 90,
                    child: Container(
                      width: size.width / 2,
                      color: scrollTop < headHeight ? bgColor : Colors.white,
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.transparent,
                        labelColor: Colors.black,
                        tabs: [
                          Tab(text: '主页'),
                          Tab(text: '动态'),
                        ],
                      ),
                    ),
                  ),
                  // appbar
                  Positioned(
                    height: 90,
                    width: size.width,
                    child: AppBar(
                      title: Text(
                        userInfo.nickname,
                        style: TextStyle(color: appColor), // 跟随滚动条改变颜色
                      ),
                      leading: BackButton(
                        color: appColor,
                      ),
                      leadingWidth: 30,
                      backgroundColor: appbarColor,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              child: PlayMini(),
            )
          ],
        ),
      ),
    );
  }
}

class ShowAllBtn extends StatelessWidget {
  final void Function() onTap;
  final String text;

  ShowAllBtn({Key? key, required this.onTap, this.text = "显示全部 >"});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.only(
        top: 10,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Colors.grey.withOpacity(0.1),
          ),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

// class DynamicItem extends StatelessWidget {}
