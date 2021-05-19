/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-14 09:53:41
 * @LastEditTime: 2021-05-19 16:48:06
 * @LastEditors: Walker
 */
import 'package:bot_toast/bot_toast.dart';
import 'package:cloudmusic_flutter/libs/enums.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/services/songList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../libs/extends/IntExtend.dart';
import '../../libs/enums.dart';
import '../playListComment.dart';

class PlayListMenu extends StatefulWidget {
  PlayListModel playListInfo = PlayListModel();

  PlayListMenu({Key? key, required this.playListInfo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlayListMenuState();
}

class PlayListMenuState extends State<PlayListMenu> {
  bool isSubscribed = false;

  @override
  void initState() {
    super.initState();

    isSubscribed = widget.playListInfo.subscribed;
  }

  // 收藏
  subscribed(context) async {
    // 1:收藏,2:取消收藏
    var type = widget.playListInfo.subscribed
        ? SubscribeDic.cancel
        : SubscribeDic.collect;

    if (type == SubscribeDic.cancel) {
      final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('确定不再收藏此歌单吗?'),
            actions: <Widget>[
              TextButton(
                child: Text(
                  '取消',
                  style: TextStyle(color: primaryColor),
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                child: Text(
                  '不再收藏',
                  style: TextStyle(color: primaryColor),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        },
      );
      if (!action) {
        return;
      }
    }
    BotToast.showLoading();
    subscribe(widget.playListInfo.id, SubscribeVal[type]).then((res) {
      BotToast.closeAllLoading();
      if (res['code'] == 200) {
        BotToast.showText(
            text: type == SubscribeDic.collect ? '收藏成功' : '取消收藏成功');

        var tmp = widget.playListInfo.subscribed;

        widget.playListInfo.subscribed = !tmp;
        this.setState(() {
          isSubscribed = !tmp;
        });
      } else {
        BotToast.showText(text: res['msg'] ?? '网络异常');
      }
    }, onError: (err) {
      print(err);
      BotToast.closeAllLoading();
    });
  }

  // 评论
  comment() {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return PlayListComment(info: widget.playListInfo);
    }));
  }

  // 分享
  share() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 40,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 2.0), //阴影xy轴偏移量
            blurRadius: 10.0, //阴影模糊程度
            spreadRadius: 1, //阴影扩散程度
          ),
        ],
      ),
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.center,
        direction: Axis.horizontal,
        children: [
          // 收藏
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                subscribed(context);
              },
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Icon(
                    widget.playListInfo.subscribed
                        ? Icons.check_circle_outline
                        : Icons.library_add_outlined,
                    size: 18,
                  ),
                  Text(
                    ' ' + widget.playListInfo.subscribedCount.toMyriadString(),
                  ),
                ],
              ),
            ),
          ),
          Text(
            '|',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade300,
            ),
          ),
          // 评论
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: comment,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Icon(
                    Icons.comment_outlined,
                    size: 18,
                  ),
                  Text(
                    ' ' + widget.playListInfo.commentCount.toMyriadString(),
                  ),
                ],
              ),
            ),
          ),
          Text(
            '|',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade300,
            ),
          ),
          // 分享
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: share,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Icon(
                    Icons.share_outlined,
                    size: 18,
                  ),
                  Text(
                    ' ' + widget.playListInfo.shareCount.toMyriadString(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
