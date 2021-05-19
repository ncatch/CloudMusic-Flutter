/*
 * @Description: 评论页面
 * @Author: Walker
 * @Date: 2021-05-14 15:29:00
 * @LastEditTime: 2021-05-19 17:55:36
 * @LastEditors: Walker
 */
import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloudmusic_flutter/components/Base/PrimaryScrollBehavior.dart';
import 'package:cloudmusic_flutter/libs/config.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:cloudmusic_flutter/model/Comments.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/pages/playList/index.dart';
import 'package:cloudmusic_flutter/services/comment.dart';
import 'package:cloudmusic_flutter/services/songList.dart';
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import '../libs/enums.dart';

class PlayListComment extends StatefulWidget {
  final PlayListModel info;
  final ResourceType type;

  PlayListComment({
    Key? key,
    required this.info,
    required this.type,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlayListCommentState();
}

class PlayListCommentState extends State<PlayListComment>
    with SingleTickerProviderStateMixin {
  double total = 0;
  int offset = 1;

  Comments comments = Comments();

  bool disChildScroll = true;
  bool isInit = false;
  var time;

  ScrollController _scrollController = ScrollController();
  ScrollController _customScrollController = ScrollController();

  TabController? tabController;

  TextEditingController commentText = TextEditingController();
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      var innerPos = _scrollController.position.pixels; // 内容滚动的距离
      var maxOuterPos =
          _customScrollController.position.maxScrollExtent; // 头部最大滚动高度

      if (innerPos > 0 && innerPos < maxOuterPos) {
        _customScrollController.position.moveTo(innerPos);
      }
    });

    tabController = TabController(length: 1, vsync: this);

    getComments();
  }

  init() {
    if (isMobile) {
      FlutterDisplayMode.setHighRefreshRate(); // 设置最高刷新率 最高分辨率
    }

    isInit = true;
  }

  getComments({isLoad = false}) {
    var before = '';
    if (isLoad) {
      before =
          comments.commentList[comments.commentList.length - 1].time.toString();
    }

    if (offset * 20 > widget.info.commentCount) {
      return;
    }

    getPlayListComment(
      widget.info.id,
      offset: (offset - 1) * 20,
      before: before,
    ).then((res) {
      if (res['code'] == 200) {
        if (isLoad != '') {
          this.setState(() {
            comments.commentList.addAll(List<CommentInfo>.from(res['comments']
                .map<CommentInfo>((ele) => CommentInfo.fromData(ele))));
          });
        } else {
          this.setState(() {
            comments = Comments.fromData(res);
          });
        }
      }
    });
  }

  loadComments() {
    if (time != null) {
      time.cancel();
      time = null;
    }

    time = new Timer(Duration(milliseconds: 50), () {
      offset++;
      getComments(isLoad: true);
      time.cancel();
      time = null;
    });
  }

  // 查看评论的回复
  commentReply() {}

  // 评论点赞
  likeCommentClick(CommentInfo ele) {
    int type = 1;
    if (ele.liked) {
      type = 0;
    }
    likeComment(
      widget.info.id,
      ele.commentId,
      type,
      widget.type.index,
    ).then((res) {
      if (res['code'] == 200) {
        this.setState(() {
          if (ele.liked) {
            ele.likedCount--;
          } else {
            ele.likedCount++;
          }
          ele.liked = !ele.liked;
        });
      } else {
        BotToast.showText(text: res['msg'] ?? '网络异常');
      }
    });
  }

  toUserDetail() {}

  toPlayList() {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return PlayList(
        songId: widget.info.id,
      );
    }));
  }

  sendComment() {
    // comment(widget.type.index, CommentType.send, commentText.value,
    //         id: widget.info.id)
    //     .then((res) {});
  }

  List<Widget> commentComponents() {
    List<Widget> result = [];

    for (var i = 0; i < comments.commentList.length; i++) {
      var ele = comments.commentList[i];

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
                    image: NetworkImage(ele.user.avatarUrl),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Text(ele.user.nickname),
                      ),
                      Container(
                        width: 60,
                        child: Text(
                          ele.likedCount.toString(),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        width: 35,
                        child: IconButton(
                          onPressed: () {
                            likeCommentClick(ele);
                          },
                          icon: Icon(
                            ele.liked ? Icons.favorite : Icons.favorite_border,
                            color: ele.liked ? primaryColor : Colors.grey,
                          ), // favorite
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      DateTime.fromMillisecondsSinceEpoch(
                        ele.time,
                      ).toLocal().toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Text(ele.content),
                  ele.beReplieds.length > 0
                      ? TextButton(
                          onPressed: commentReply,
                          child: Text('${ele.beReplieds.length}条回复 >'),
                        )
                      : Container()
                ],
              ),
            ),
          ],
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

    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 1,
            child: CustomScrollView(
              controller: _customScrollController,
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  expandedHeight: 140,
                  leading: BackButton(
                    color: Colors.black,
                  ),
                  foregroundColor: Colors.black,
                  title: Text(
                    "评论($total)",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  backgroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      height: 100,
                      margin: EdgeInsets.only(top: 70),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 10, color: Colors.grey.shade100),
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
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            widget.info.creator.nickname,
                                            style: TextStyle(
                                                color: Colors.blue[400]),
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
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: StickyTabBarDelegate(
                    child: TabBar(
                      indicatorColor: Colors.white,
                      labelColor: Colors.black,
                      controller: tabController,
                      tabs: <Widget>[
                        Tab(
                          child: Container(
                            height: 50,
                            color: Colors.white,
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
                        )
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: TabBarView(
                    controller: tabController,
                    children: <Widget>[
                      Container(
                        child: ScrollConfiguration(
                          behavior: PrimaryScrollBehavior(),
                          child: NotificationListener(
                            onNotification: (notification) {
                              if (notification.runtimeType ==
                                  OverscrollNotification) {
                                if (_scrollController.offset <= 0) {
                                  _customScrollController.position.moveTo(0);
                                } else {
                                  // 加载数据
                                  loadComments();
                                }
                              }
                              return true;
                            },
                            child: ListView(
                              controller: _scrollController,
                              children: commentComponents(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: 50,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
                      child: TextField(
                        controller: commentText,
                        decoration: InputDecoration(
                          hintText: '写评论...',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    child: TextButton(
                      onPressed: sendComment,
                      child: Text('发送'),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
