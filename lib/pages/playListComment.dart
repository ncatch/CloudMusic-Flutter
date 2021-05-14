/*
 * @Description: 评论页面
 * @Author: Walker
 * @Date: 2021-05-14 15:29:00
 * @LastEditTime: 2021-05-14 19:40:33
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
  bool disChildScroll = true;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      var tmp = _scrollController.offset < 110;

      if (disChildScroll != tmp) {
        this.setState(() {
          disChildScroll = tmp;
        });
      }
    });

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
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.grey.shade200,
            ),
          ),
        ),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Container(
              width: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                width: 30,
                height: 30,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(ele['user']['avatarUrl']),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ele['user']['nickname']),
                  Text(DateTime.fromMillisecondsSinceEpoch(ele['time'])
                      .toLocal()
                      .toString()),
                  Text(ele['content']),
                ],
              ),
            ),
          ],
        ),
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
    var size = MediaQuery.of(context).size;

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
        controller: _scrollController,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 10, color: Colors.grey.shade100),
              ),
            ),
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
          Container(
            height: 40,
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 1,
                  child: Text('评论'),
                ),
                Container(
                  width: 100,
                  child: Row(
                    children: [
                      Text('推荐'),
                      Text('最热'),
                      Text('最新'),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: size.height - 40,
            child: ListView(
              shrinkWrap: true,
              physics: disChildScroll
                  ? NeverScrollableScrollPhysics()
                  : AlwaysScrollableScrollPhysics(),
              children: commentComponents(),
            ),
          ),
        ],
      ),
    );
  }
}
