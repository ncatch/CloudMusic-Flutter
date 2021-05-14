/*
 * @Description: 评论页面
 * @Author: Walker
 * @Date: 2021-05-14 15:29:00
 * @LastEditTime: 2021-05-14 15:58:36
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/services/songList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayListComment extends StatefulWidget {
  final PlayListModel info;

  PlayListComment({Key? key, required this.info}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlayListCommentState();
}

class PlayListCommentState extends State<PlayListComment> {
  var commentList = [];
  var hotCommentList = [];

  @override
  void initState() {
    super.initState();

    getPlayListComment(widget.info.id).then((res) {
      if (res['code'] == 200) {
        this.setState(() {
          commentList = res['comments'];
          hotCommentList = res['hotComments'];
        });
      }
    });
  }

  commentComponents() {
    List<Widget> result = [];

    for (var i = 0; i < commentList.length; i++) {
      var ele = commentList[i];

      result.add(Container(
        child: Text(ele['content']),
      ));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 200,
            child: Text(widget.info.title),
          ),
          ...commentComponents(),
        ],
      ),
    );
  }
}
