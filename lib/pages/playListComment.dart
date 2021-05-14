/*
 * @Description: 评论页面
 * @Author: Walker
 * @Date: 2021-05-14 15:29:00
 * @LastEditTime: 2021-05-14 17:59:48
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/pages/playList/index.dart';
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

    getComments();
  }

  getComments() {
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

  toUserDetail() {}

  toPlayList() {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return PlayList(
        songId: widget.info.id,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        leadingWidth: 30,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "评论(${commentList.length})",
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 90,
            child: InkWell(
              onTap: toPlayList,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.info.coverImgUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Wrap(
                      children: [
                        Container(
                          child: Text(
                            widget.info.title,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          child: InkWell(
                            onTap: toUserDetail,
                            child: Row(
                              children: [
                                Text(
                                  'by ',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  widget.info.creator.nickname,
                                  style: TextStyle(color: Colors.blue[400]),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 30,
                    child: Icon(
                      Icons.navigate_next,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...commentComponents(),
        ],
      ),
    );
  }
}
