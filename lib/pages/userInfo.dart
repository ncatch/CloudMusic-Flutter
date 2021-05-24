/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-20 10:35:17
 * @LastEditTime: 2021-05-24 15:15:10
 * @LastEditors: Walker
 */
import 'dart:ui';

import 'package:cloudmusic_flutter/components/PlayMini.dart';
import 'package:cloudmusic_flutter/libs/extends/Toast.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
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
                          width: size.width,
                          height: 500,
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
                                      Container(
                                        margin: EdgeInsets.only(top: 15),
                                        padding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
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
                                          onTap: showAllBasicInfo,
                                          child: Center(
                                            child: Text(
                                              '查看全部 >',
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ModelComponent(
                                    title: '音乐品味',
                                    children: [],
                                  ),
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

class TitleComponent extends StatelessWidget {
  final String title;
  final String descript;

  TitleComponent({Key? key, required this.title, this.descript = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
      margin: EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
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
