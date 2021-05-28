/*
 * @Description: 评论页面
 * @Author: Walker
 * @Date: 2021-05-14 15:29:00
 * @LastEditTime: 2021-05-27 15:47:01
 * @LastEditors: Walker
 */
import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloudmusic_flutter/components/Base/PrimaryScrollBehavior.dart';
import 'package:cloudmusic_flutter/components/Base/HeightRefresh.dart';
import 'package:cloudmusic_flutter/components/Base/ShowModalBottomSheetTools.dart';
import 'package:cloudmusic_flutter/libs/extends/Toast.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:cloudmusic_flutter/model/Comments.dart';
import 'package:cloudmusic_flutter/model/Hug.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/pages/playList/index.dart';
import 'package:cloudmusic_flutter/services/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './userInfo.dart';
import '../libs/enums.dart';

class CommentList extends StatefulWidget {
  final PlayListModel info;
  final ResourceType type;

  CommentList({
    Key? key,
    required this.info,
    required this.type,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CommentListState();
}

class CommentListState extends State<CommentList>
    with SingleTickerProviderStateMixin, ShowHugInfo {
  double total = 0;
  int offset = 1;
  CommentSortType sortType = CommentSortType.time;

  Comments comments = Comments();

  bool disChildScroll = true;
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

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _customScrollController.dispose();
    tabController?.dispose();
  }

  getComments({isLoad = false, showLoading = false}) {
    var before = '';
    if (isLoad) {
      before =
          comments.commentList[comments.commentList.length - 1].time.toString();
    }

    // TODO loading颜色
    if (showLoading) BotToast.showLoading();

    getCommentList(
      widget.info.id,
      widget.type.index,
      sortType.index + 1,
      offset,
      cursor: before,
    ).then((res) {
      BotToast.closeAllLoading();
      if (res['code'] == 200) {
        if (isLoad) {
          this.setState(() {
            comments.commentList.addAll(List<CommentInfo>.from(res['data']
                    ['comments']
                .map<CommentInfo>((ele) => CommentInfo.fromData(ele))));
          });
        } else {
          this.setState(() {
            comments = Comments.fromData(res['data']);
          });
        }
      }
    });
  }

  loadComments() {
    if (offset * 20 > widget.info.commentCount) {
      return;
    }
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
        Toast(res['msg'] ?? '网络异常');
      }
    });
  }

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

  userClick(CommentInfo comment) async {
    if (comment.hugInfo == null) {
      await getCommentHugList(
              comment.user.userId, comment.commentId, widget.info.id)
          .then((value) {
        if (value['code'] == 200) {
          comment.hugInfo = HugInfo.fromJson(value['data']);
        }
        return value;
      });
    }

    ShowHugInfoModal(context, comment, widget.info);
  }

  sortTypeClick(CommentSortType type) {
    this.setState(() {
      this.sortType = type;
    });

    this.getComments(showLoading: true);
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.topCenter,
              child: InkWell(
                onTap: () {
                  userClick(ele);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  margin: EdgeInsets.only(top: 5),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(ele.user.avatarUrl),
                    ),
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
                        height: 20,
                        child: InkWell(
                          onTap: () {
                            likeCommentClick(ele);
                          },
                          child: Icon(
                            ele.liked ? Icons.favorite : Icons.favorite_border,
                            color: ele.liked ? primaryColor : Colors.grey,
                            size: 18,
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
    var sortMenuSplit = Container(
      height: 14,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
    );

    return HeightRefresh(
      child: Scaffold(
        body: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: ScrollConfiguration(
                behavior: PrimaryScrollBehavior(),
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
                                      image:
                                          NetworkImage(widget.info.coverImgUrl),
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
                                          onTap: () {
                                            toUserDetail(context,
                                                widget.info.creator.userId);
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                'by ',
                                                style: TextStyle(
                                                    color: Colors.grey),
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
                                      width: 152,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            child: TextButton(
                                              onPressed: () {
                                                sortTypeClick(
                                                    CommentSortType.recommend);
                                              },
                                              child: Text(
                                                '推荐',
                                                style: TextStyle(
                                                  color: sortType ==
                                                          CommentSortType
                                                              .recommend
                                                      ? Colors.black
                                                      : Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                          sortMenuSplit,
                                          Container(
                                            width: 50,
                                            child: TextButton(
                                              onPressed: () {
                                                sortTypeClick(
                                                    CommentSortType.hot);
                                              },
                                              child: Text(
                                                '最热',
                                                style: TextStyle(
                                                  color: sortType ==
                                                          CommentSortType.hot
                                                      ? Colors.black
                                                      : Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                          sortMenuSplit,
                                          Container(
                                            width: 50,
                                            child: TextButton(
                                              onPressed: () {
                                                sortTypeClick(
                                                    CommentSortType.time);
                                              },
                                              child: Text(
                                                '最新',
                                                style: TextStyle(
                                                  color: sortType ==
                                                          CommentSortType.time
                                                      ? Colors.black
                                                      : Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
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
                        ],
                      ),
                    ),
                  ],
                ),
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
