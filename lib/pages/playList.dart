/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-11 15:56:11
 * @LastEditTime: 2021-05-12 11:13:11
 * @LastEditors: Walker
 */
import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloudmusic_flutter/libs/config.dart';
import 'package:cloudmusic_flutter/model/MusicInfo.dart';
import 'package:cloudmusic_flutter/model/PlayInfo.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/services/songList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayList extends StatefulWidget {
  var songId;

  PlayList({Key? key, this.songId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlayListState();
}

class PlayListState extends State<PlayList> {
  double headHeight = 300; // head 高度
  double appBarImgOper = 0; // appbar 透明度
  double sunkenHeight = 20; // head 凹陷高度

  PlayListModel playListInfo = PlayListModel();

  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: headHeight,
            child: Stack(
              children: <Widget>[
                Container(
                  height: headHeight,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new NetworkImage(playListInfo.headBgUrl == ""
                          ? play_img_url_default
                          : playListInfo.headBgUrl),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                        Colors.black54,
                        BlendMode.overlay,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: Positioned(
                    width: size.width,
                    bottom: 0,
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
                ),
                playListInfo.headBgUrl == ""
                    ? Container(
                        height: headHeight,
                        child: new BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Opacity(
                            opacity: 0.6,
                            child: new Container(
                              decoration: new BoxDecoration(
                                color: Colors.grey.shade900,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Container(
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
                Positioned(
                  top: 50,
                  child: Column(
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  playListInfo.coverImgUrl,
                                  fit: BoxFit.fill,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ),
                            Positioned(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.play_arrow_outlined,
                                        color: Colors.white, size: 18),
                                    Text(
                                      (playListInfo.playCount / 10000)
                                              .round()
                                              .toString() +
                                          '万',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              height: 22,
                              top: 4,
                              right: 10,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            width: size.width,
            height: size.height - headHeight + 50,
            child: ClipPath(
              clipper: HeadClipper(height: sunkenHeight),
              child: Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                child: Wrap(
                  children: [],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HeadClipper extends CustomClipper<Path> {
  double height;

  HeadClipper({Key? key, this.height = 0});

  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0); //第一个点

    var firstControlPoint = Offset(size.width / 2, height); //曲线开始点
    var firstendPoint = Offset(size.width, 0); // 曲线结束点

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
