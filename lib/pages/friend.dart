/*
 * @Description: 朋友页面
 * @Author: Walker
 * @Date: 2021-06-02 17:02:08
 * @LastEditTime: 2021-07-02 11:14:58
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/components/Base/HeightRefresh.dart';
import 'package:cloudmusic_flutter/components/UserPhoto.dart';
import 'package:cloudmusic_flutter/libs/enums.dart';
import 'package:cloudmusic_flutter/model/UserInfo.dart';
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:cloudmusic_flutter/pages/userInfo.dart' as page;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Friend extends StatefulWidget {
  final int userId;
  FriendType type = FriendType.follow;

  Friend({Key? key, this.type = FriendType.follow, required this.userId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => FriendState();
}

class FriendState extends State<Friend> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  List<UserInfo> flowList = [];
  List<UserInfo> flowedList = [];

  @override
  initState() {
    super.initState();

    _tabController = new TabController(length: 2, vsync: this);

    _tabController?.index = widget.type.index;

    getUserFollows(widget.userId).then((res) {
      if (res['code'] == 200) {
        setState(() {
          flowList = List<UserInfo>.from(
              res["follow"].map((ele) => UserInfo.fromJson(ele)));
        });
      }
    });
    getUserFolloweds(widget.userId).then((res) {
      if (res['code'] == 200) {
        setState(() {
          flowedList = List<UserInfo>.from(
              res["followeds"].map((ele) => UserInfo.fromJson(ele)));
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _tabController?.dispose();
  }

  searchClick() {}

  @override
  Widget build(BuildContext build) {
    return HeightRefresh(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          leadingWidth: 50,
          title: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.transparent,
                    labelColor: Colors.black,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle:
                        TextStyle(fontWeight: FontWeight.w400),
                    tabs: [
                      // Tab(text: '推荐'),
                      Tab(text: '关注'),
                      Tab(text: '粉丝'),
                    ],
                  ),
                ),
              ),
              Container(
                width: 50,
                child: IconButton(
                  onPressed: searchClick,
                  icon: Icon(Icons.search, color: Colors.black),
                ),
              )
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          brightness: Brightness.light,
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // Container(
            //   child: Text('推荐'),
            // ),
            Container(
              child: FollowList(
                list: flowList,
              ),
            ),
            Container(
              child: FollowedList(
                list: flowedList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FollowList extends StatelessWidget {
  List<UserInfo> list;

  FollowList({Key? key, required this.list}) : super(key: key);

  // 跳转用户信息页
  userClick(context, UserInfo userInfo) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return page.UserInfo(id: userInfo.userId);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        var info = list[index];

        return Container(
            margin: EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () {
                userClick(context, info);
              },
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: UserPhoto(
                      userInfo: info,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          info.nickname,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '昵称: ${info.nickname}',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

class FollowedList extends StatelessWidget {
  List<UserInfo> list;

  FollowedList({Key? key, required this.list}) : super(key: key);

  // 跳转用户信息页
  userClick(context, UserInfo userInfo) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return page.UserInfo(id: userInfo.userId);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        var info = list[index];

        return Container(
            margin: EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () {
                userClick(context, info);
              },
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: UserPhoto(
                      userInfo: info,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          info.nickname,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50,
                    child: RightMenu(info: info),
                  )
                ],
              ),
            ));
      },
    );
  }
}

class RightMenu extends StatelessWidget {
  UserInfo info;

  RightMenu({
    Key? key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    List<PopupMenuEntry<String>> btns = [];

    btns.add(PopupMenuItem<String>(
      value: 'remove',
      child: Text('移除粉丝'),
    ));

    return PopupMenuButton<String>(
      onSelected: (val) {
        switch (val) {
          case 'remove':
            break;
          default:
        }
      },
      itemBuilder: (context) {
        return btns;
      },
    );
  }
}
