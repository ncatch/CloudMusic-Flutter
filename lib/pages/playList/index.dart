/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-11 15:56:11
 * @LastEditTime: 2021-05-14 20:44:03
 * @LastEditors: Walker
 */
import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloudmusic_flutter/components/Play.dart';
import 'package:cloudmusic_flutter/components/PlayMini.dart';
import 'package:cloudmusic_flutter/libs/config.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/pages/playList/playListMenu.dart';
import 'package:cloudmusic_flutter/pages/playList/playMenu.dart';
import 'package:cloudmusic_flutter/pages/playList/subscribers.dart';
import 'package:cloudmusic_flutter/services/songList.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloudmusic_flutter/libs/extends/StringExtend.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:provider/provider.dart';

class PlayList extends StatefulWidget {
  final songId;

  PlayList({Key? key, this.songId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlayListState();
}

class PlayListState extends State<PlayList> {
  bool isInit = false;
  double headHeight = 250; // head 高度
  double appBarImgOper = 0; // appbar 透明度
  double sunkenHeight = 20; // head 凹陷高度

  PlayListModel playListInfo = PlayListModel();

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double t = _scrollController.offset / 150;
      if (t < 0.0) {
        t = 0.0;
      } else if (t > 1.0) {
        t = 1.0;
      }
      if (appBarImgOper != t) {
        setState(() {
          appBarImgOper = t;
          // sunkenHeight = 20 - 20 * t;
        });
      }
    });

    getPlayListById(widget.songId).then((res) {
      if (res['code'] == 200) {
        this.setState(() {
          playListInfo = PlayListModel.fromData(res['playlist']);
        });
      } else {
        BotToast.showText(text: res['msg'] ?? '网络异常');
      }
    });
  }

  init() {
    if (isMobile) {
      FlutterDisplayMode.setHighRefreshRate(); // 设置最高刷新率 最高分辨率
    }

    isInit = true;
  }

  // 显示简介详情
  showDescript() {}

  // 关注
  attention() {}

  // 下载音乐
  downloadMusic() {}

  // 选择
  selectClich() {}

  musicMenu() {}

  musicClick(playInfoStore, index) {
    playInfoStore.setPlayList(playListInfo.musicList, index);

    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return Play();
    }));
  }

  List<Widget> getMusicList(playInfoStore) {
    List<Widget> result = [];
    for (var i = 0; i < playListInfo.musicList.length; i++) {
      var ele = playListInfo.musicList[i];

      result.add(Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: InkWell(
          onTap: () {
            musicClick(playInfoStore, i);
          },
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Container(
                width: 40,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  (i + 1).toString(),
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Expanded(
                flex: 1,
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      ele.musicName,
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      ele.singerName + '-' + ele.tip,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: musicMenu,
                icon: Icon(Icons.more_vert),
              )
            ],
          ),
        ),
      ));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (!isInit) {
      init();
    }

    var size = MediaQuery.of(context).size;
    var playInfoStore = Provider.of<PlayInfoStore>(context);
    var playMenuComponent = PlayMenu(playListInfo: playListInfo);

    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    child: ListView(
                      controller: _scrollController,
                      children: [
                        Container(
                          height: headHeight,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new NetworkImage(
                                  playListInfo.headBgUrl == ""
                                      ? play_img_url_default
                                      : playListInfo.headBgUrl),
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(
                                Colors.black54,
                                BlendMode.overlay,
                              ),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 60,
                                width: size.width,
                                height: headHeight - 140,
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Container(
                                      width: 130,
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 5),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                playListInfo.coverImgUrl,
                                                fit: BoxFit.fill,
                                                width: 114,
                                                height: 114,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  6, 0, 6, 0),
                                              decoration: BoxDecoration(
                                                color: Colors.black38,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                      Icons.play_arrow_outlined,
                                                      color: Colors.white,
                                                      size: 18),
                                                  Text(
                                                    (playListInfo.playCount /
                                                                10000)
                                                            .round()
                                                            .toString() +
                                                        '万',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            height: 22,
                                            top: 4,
                                            right: 25,
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(4, 0, 20, 0),
                                        height: headHeight,
                                        child: Wrap(
                                          alignment: WrapAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                playListInfo.title,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 15, 0, 15),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 6, 0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      child: Image.network(
                                                        playListInfo
                                                            .creator.avatarUrl,
                                                        fit: BoxFit.fill,
                                                        width: 24,
                                                        height: 24,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    playListInfo
                                                        .creator.nickname,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  InkWell(
                                                    onTap: attention,
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              5, 2, 0, 0),
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              8, 0, 8, 0),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors
                                                            .grey.shade300,
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                        size: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: InkWell(
                                                onTap: () {
                                                  showDescript();
                                                },
                                                child: Text(
                                                  playListInfo.descript
                                                          .split('\n')[0]
                                                          .overFlowString(10) +
                                                      ' >',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                width: size.width,
                                height: headHeight + 20,
                                child: ClipPath(
                                  clipper: HeadClipper(
                                    height: sunkenHeight,
                                    headHeight: headHeight,
                                  ),
                                  child: Container(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                child: Container(
                                  width: size.width,
                                  alignment: Alignment.center,
                                  child: Opacity(
                                    opacity: 1 - appBarImgOper,
                                    child: PlayListMenu(
                                      playListInfo: playListInfo,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        playMenuComponent,
                        ...getMusicList(playInfoStore),
                        Subscribers(
                          playListInfo: playListInfo,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 90,
                    child: Opacity(
                      opacity: appBarImgOper,
                      child: Image(
                        width: size.width,
                        image: NetworkImage(playListInfo.headBgUrl == ""
                            ? play_img_url_default
                            : playListInfo.headBgUrl),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    child: AppBar(
                      leading: BackButton(),
                      leadingWidth: 30,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: Text(
                        "歌单",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              )),
          Container(
            height: 50,
            child: PlayMini(),
          )
        ],
      ),
    );
  }
}

class HeadClipper extends CustomClipper<Path> {
  double height;
  double headHeight;

  HeadClipper({Key? key, this.height = 0, this.headHeight = 0});

  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, headHeight - height); //第一个点

    var firstControlPoint = Offset(size.width / 2, headHeight); //曲线开始点
    var firstendPoint = Offset(size.width, headHeight - height); // 曲线结束点

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstendPoint.dx, firstendPoint.dy);

    path.lineTo(size.width, size.height); //第二个点
    path.lineTo(0, size.height); //第四个点
    path.lineTo(0, 0); // 第五个点
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
