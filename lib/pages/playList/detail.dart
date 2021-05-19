/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-18 16:50:09
 * @LastEditTime: 2021-05-19 15:54:49
 * @LastEditors: Walker
 */
import 'dart:ui';

import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/store/SystemInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PlayListDetail extends StatelessWidget {
  PlayListModel playListInfo;

  PlayListDetail({Key? key, required this.playListInfo});

  @override
  Widget build(BuildContext context) {
    var hasHeadImg = playListInfo.headBgUrl != "";
    var bgUrl = hasHeadImg ? playListInfo.headBgUrl : playListInfo.coverImgUrl;
    var systemInfo = Provider.of<SystemInfo>(context);

    return AnnotatedRegion<Brightness>(
      value: systemInfo.brightNess,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Container(
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
              Container(
                child: new BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
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
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: ListView(
                  children: [
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        margin: EdgeInsets.only(top: 100),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        playListInfo.title,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Text(
                            '标签：',
                            style: TextStyle(color: Colors.white),
                          ),
                          ...playListInfo.tags.map<Widget>(
                            (ele) => Container(
                              margin: EdgeInsets.fromLTRB(5, 2, 0, 0),
                              padding: EdgeInsets.fromLTRB(12, 2, 12, 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade800,
                              ),
                              child: Text(
                                ele,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        playListInfo.descript ?? "暂无简介",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 30,
                right: 10,
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
