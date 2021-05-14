/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-14 09:53:41
 * @LastEditTime: 2021-05-14 10:34:22
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../libs/extends/IntExtend.dart';

class PlayListMenu extends StatelessWidget {
  PlayListModel playListInfo = PlayListModel();

  PlayListMenu({Key? key, required this.playListInfo});

  // 收藏
  subscribed() {}

  // 评论
  comment() {}

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
              onTap: subscribed,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Icon(
                    Icons.library_add_outlined,
                    size: 18,
                  ),
                  Text(
                    ' ' + playListInfo.subscribedCount.toMyriadString(),
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
                    ' ' + playListInfo.commentCount.toMyriadString(),
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
                    ' ' + playListInfo.shareCount.toMyriadString(),
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
