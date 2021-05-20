/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-11 15:56:11
 * @LastEditTime: 2021-05-20 17:45:16
 * @LastEditors: Walker
 */
import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloudmusic_flutter/components/Base/PrimaryScrollBehavior.dart';
import 'package:cloudmusic_flutter/components/Base/RefreshRate.dart';
import 'package:cloudmusic_flutter/components/Play.dart';
import 'package:cloudmusic_flutter/components/PlayMini.dart';
import 'package:cloudmusic_flutter/components/UserLabel.dart';
import 'package:cloudmusic_flutter/libs/config.dart';
import 'package:cloudmusic_flutter/libs/extends/Toast.dart';
import 'package:cloudmusic_flutter/model/MusicInfo.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/pages/playList/detail.dart';
import 'package:cloudmusic_flutter/pages/playList/playListMenu.dart';
import 'package:cloudmusic_flutter/pages/playList/playMenu.dart';
import 'package:cloudmusic_flutter/pages/playList/subscribers.dart';
import 'package:cloudmusic_flutter/pages/playList/HeadClipPath.dart';
import 'package:cloudmusic_flutter/services/music.dart';
import 'package:cloudmusic_flutter/services/songList.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:cloudmusic_flutter/store/SystemInfo.dart';
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

class PlayListState extends State<PlayList> with RefreshRate {
  double headHeight = 270; // head 高度
  double appBarImgOper = 0; // appbar 透明度
  double sunkenHeight = 20; // head 凹陷高度
  double headImgTop = 0;

  PlayListModel playListInfo = PlayListModel();

  ScrollController _scrollController = ScrollController();

  int pageIndex = 1;
  int pageSize = 20;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double t = _scrollController.offset / 200;
      if (t < 0.0) {
        t = 0.0;
      } else if (t > 1.0) {
        t = 1.0;
      }
      setState(() {
        appBarImgOper = t;
        headImgTop = _scrollController.offset;
        sunkenHeight = 20 - 20 * t;
      });
    });

    pageIndex = 1;
    getPlayListById(widget.songId).then((res) {
      if (res['code'] == 200) {
        playListInfo = PlayListModel.fromData(res['playlist']);

        this.getMusicList();
      } else {
        Toast(res['msg'] ?? '网络异常');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  getMusicList() {
    int min = (pageIndex - 1) * pageSize;
    int max = pageIndex * pageSize;

    if (min >= playListInfo.musicIds.length) {
      return;
    }

    if (max > playListInfo.musicIds.length) {
      max = playListInfo.musicIds.length;
    }

    List<int> ids = playListInfo.musicIds.sublist(min, max);
    getMusicDetail(ids).then((res) {
      this.setState(() {
        playListInfo.musicList
            .addAll(res.map<MusicInfo>((ele) => MusicInfo.fromData(ele)));
      });
    });
  }

  // 显示简介详情
  showDescript() {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return PlayListDetail(
        playListInfo: playListInfo,
      );
    }));
  }

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

  List<Widget> getMusicListWidget(playInfoStore) {
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
                      ele.musicName.overFlowString(18),
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      ele.singerName + '-' + ele.tip.overFlowString(15),
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
    super.refreshRateInit();

    var size = MediaQuery.of(context).size;
    var playInfoStore = Provider.of<PlayInfoStore>(context);
    var systemInfo = Provider.of<SystemInfo>(context);
    var playMenuComponent = PlayMenu(playListInfo: playListInfo);
    var hasHeadImg = playListInfo.headBgUrl != "";
    var bgUrl = hasHeadImg ? playListInfo.headBgUrl : playListInfo.coverImgUrl;

    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Positioned(
                    top: -headImgTop,
                    height: headHeight,
                    child: Container(
                      width: size.width,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(bgUrl),
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(
                            Colors.black54,
                            BlendMode.overlay,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -headImgTop,
                    height: headHeight,
                    child: Container(
                      child: hasHeadImg
                          ? null
                          : new BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                              child: Opacity(
                                opacity: 0.6,
                                child: new Container(
                                  decoration: new BoxDecoration(
                                    color: Colors.grey.shade900,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                  Container(
                    child: ScrollConfiguration(
                      behavior: PrimaryScrollBehavior(),
                      child: NotificationListener(
                        onNotification: (notification) {
                          if (notification.runtimeType ==
                              OverscrollNotification) {
                            if (_scrollController.offset > 0) {
                              pageIndex++;
                              getMusicList();
                            }
                          }
                          return true;
                        },
                        child: ListView(
                          controller: _scrollController,
                          children: [
                            Container(
                              height: headHeight,
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
                                          margin:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 5),
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .play_arrow_outlined,
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
                                            padding: EdgeInsets.fromLTRB(
                                                4, 0, 20, 0),
                                            height: headHeight,
                                            child: Wrap(
                                              alignment: WrapAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    playListInfo.title
                                                        .overFlowString(20),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                UserLabel(
                                                  userInfo:
                                                      playListInfo.creator,
                                                ),
                                                Container(
                                                  child: InkWell(
                                                    onTap: () {
                                                      showDescript();
                                                    },
                                                    child: Text(
                                                      playListInfo.descript ==
                                                                  null ||
                                                              playListInfo
                                                                      .descript ==
                                                                  ""
                                                          ? '暂无简介'
                                                          : (playListInfo.descript ??
                                                                      "")
                                                                  .split(
                                                                      '\n')[0]
                                                                  .overFlowString(
                                                                      20) +
                                                              ' >',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
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
                                    height: 40,
                                    child: HeadClipPath(
                                      valNotifier: ValueNotifier(sunkenHeight),
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
                            ...getMusicListWidget(playInfoStore),
                            Subscribers(
                              playListInfo: playListInfo,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 90,
                    child: Opacity(
                        opacity: appBarImgOper,
                        child: Stack(
                          children: [
                            Positioned(
                              child: Image(
                                width: size.width,
                                image: NetworkImage(bgUrl),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            hasHeadImg
                                ? Container(
                                    height: 90,
                                  )
                                : Positioned(
                                    child: ClipRect(
                                      clipper: AppBarRect(),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 50.0,
                                          sigmaY: 50.0,
                                        ),
                                        child: Opacity(
                                          opacity: 0.6,
                                          child: new Container(
                                            height: 90,
                                            // decoration: new BoxDecoration(
                                            //   color: Colors.grey.shade900,
                                            // ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        )),
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
                      brightness: systemInfo.brightNess,
                    ),
                  ),
                  Positioned(
                    top: 90,
                    height: 50,
                    width: size.width,
                    child: headImgTop >= 217 ? playMenuComponent : Container(),
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

class AppBarRect extends CustomClipper<Rect> {
  double height = 90;

  AppBarRect({Key? key, this.height = 90});

  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width, height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
