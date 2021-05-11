/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-11 15:56:11
 * @LastEditTime: 2021-05-11 19:35:37
 * @LastEditors: Walker
 */
import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloudmusic_flutter/model/MusicInfo.dart';
import 'package:cloudmusic_flutter/model/PlayInfo.dart';
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
  double headHeight = 300;
  List<MusicInfo> playlist = [];
  var songInfo = {};

  @override
  void initState() {
    super.initState();

    getPlayListById(widget.songId).then((res) {
      if (res['code'] == 200) {
        this.setState(() {
          songInfo = res['playlist'];
          playlist = res['playlist']['tracks']
              .map<MusicInfo>((ele) => MusicInfo.fromData(ele))
              .toList();
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
                      image: new NetworkImage(songInfo['coverImgUrl']),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                        Colors.black54,
                        BlendMode.overlay,
                      ),
                    ),
                  ),
                ),
                Container(
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
                ),
                Container(
                  child: AppBar(
                    leading: BackButton(),
                    leadingWidth: 30,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text(
                      songInfo['name'] ?? '',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            width: size.width,
            height: size.height - headHeight + 50,
            child: ClipPath(
              clipper: HeadClipper(height: 20),
              child: Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                child: Wrap(
                  children: [Text('123')],
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
