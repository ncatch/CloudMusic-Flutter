/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-20 10:35:17
 * @LastEditTime: 2021-05-20 16:08:43
 * @LastEditors: Walker
 */
import 'dart:html';
import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloudmusic_flutter/components/PlayMini.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:flutter/material.dart';
import '../model/UserInfo.dart' as model;
import '../libs/extends/IntExtend.dart';

class UserInfo extends StatefulWidget {
  final int id;
  UserInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserInfoState();
}

class UserInfoState extends State<UserInfo> {
  double headHeight = 250;

  model.UserInfo userInfo = new model.UserInfo();

  TextStyle numStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  @override
  initState() {
    super.initState();

    getUserDetail(widget.id).then((res) {
      if (res['code'] == 200) {
        this.setState(() {
          res['profile']['level'] = res['level'];
          userInfo = model.UserInfo.fromJson(res['profile']);
        });
      }
    });
  }

  attention() {
    attentionUser(userInfo.userId, userInfo.followed ? 0 : 1).then((res) {
      if (res['code'] == 200) {
        this.setState(() {
          if (userInfo.followeds < 10000) {
            userInfo.followeds += userInfo.followed ? -1 : 1;
          }
          userInfo.followed = !userInfo.followed;
        });
      } else {
        BotToast.showText(text: res['msg'] ?? '网络异常');
      }
    });
  }

  dynamicClick() {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
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
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: new NetworkImage(userInfo.backgroundUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    width: size.width,
                    height: headHeight + 100,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                          begin: const Alignment(0.0, -0.5),
                          end: const Alignment(0.0, 0.2),
                          colors: <Color>[
                            Colors.white10,
                            Colors.white,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: headHeight - 40,
                    width: size.width,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 100,
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
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: primaryColor,
                                              ),
                                              child: InkWell(
                                                onTap: attention,
                                                child: Text(
                                                  userInfo.followed
                                                      ? '已关注'
                                                      : '+ 关注',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
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
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    height: 90,
                    width: size.width,
                    child: AppBar(
                      title: Text(
                        userInfo.nickname,
                        // style: TextStyle(color: Colors.black), // 跟随滚动条改变颜色
                      ),
                      leading: BackButton(),
                      leadingWidth: 30,
                      backgroundColor: Colors.white.withOpacity(0),
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
