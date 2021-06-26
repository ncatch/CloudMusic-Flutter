/*
 * @Description: 收藏用户列表
 * @Author: Walker
 * @Date: 2021-05-13 13:49:07
 * @LastEditTime: 2021-06-11 14:03:50
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/model/UserInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Subscribers extends StatelessWidget {
  final List<UserInfo> subscribers;
  final int? subscribedCount;

  Subscribers({Key? key, required this.subscribers, this.subscribedCount});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    int length = subscribers.length > 5 ? 5 : subscribers.length;

    for (var i = 0; i < length; i++) {
      var ele = subscribers[i];

      items.add(Container(
        width: 30,
        height: 30,
        margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(ele.avatarUrl),
            fit: BoxFit.cover,
          ),
        ),
      ));
    }

    return Container(
      height: 40,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          ...items,
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
              alignment: Alignment.centerRight,
              child: Text(
                (subscribedCount ?? subscribers.length).toString() + '人收藏 >',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
