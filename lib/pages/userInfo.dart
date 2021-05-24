/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-20 10:35:17
 * @LastEditTime: 2021-05-24 19:33:24
 * @LastEditors: Walker
 */
import 'dart:ui';

import 'package:cloudmusic_flutter/components/PlayMini.dart';
import 'package:cloudmusic_flutter/libs/extends/Toast.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/pages/playList/index.dart';
import 'package:cloudmusic_flutter/services/music.dart';
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:cloudmusic_flutter/libs/extends/StringExtend.dart';
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

  @override
  initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.offset > 150) {
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

  dynamicClick() {}

  showAllBasicInfo() {}

  showAllSongList(type) {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
    double contentHeight = 250;

    if (playListModes.length > 0) {
      likeList =
          playListModes.firstWhere((element) => element.specialType == 5);
      likeList.title = "我喜欢的音乐";

      contentHeight += 65;

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
            65 + 65 * (createList.length > 10 ? 10 : createList.length);

        if (createList.length > 10) {
          contentHeight += 40;
        }
      }
      if (collectList.length > 0) {
        contentHeight +=
            65 + 65 * (collectList.length > 10 ? 10 : collectList.length);
        if (collectList.length > 10) {
          contentHeight += 40;
        }
      }
    }

    return Scaffold(
      body: Container(
        color: Colors.grey.shade100,
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
                          colors: <Color>[
                            Colors.white10,
                            Colors.grey.shade100,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    child: ListView(
                      controller: _controller,
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
                        Container(
                          height: 40,
                          width: size.width / 2,
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
                        Container(
                          height: contentHeight,
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
                                              padding:
                                                  EdgeInsets.only(left: 15),
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
                                children: [
                                  ModelComponent(
                                    title: '动态',
                                    children: [],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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

class SongListItem extends StatelessWidget {
  final PlayListModel info;

  SongListItem({Key? key, required this.info});

  songClick(context, id) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return PlayList(
        songId: id,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        songClick(context, info.id);
      },
      child: Row(
        children: [
          Container(
            width: 80,
            height: 55,
            padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                info.coverImgUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                info.title.overFlowString(12),
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '${info.trackCount}首, 播放${info.playCount.toMyriadString(1)}次',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
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
            color: Colors.grey.shade200,
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

class ModelComponent extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final String descript;

  ModelComponent(
      {Key? key,
      required this.children,
      required this.title,
      this.descript = ''});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
      padding: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
