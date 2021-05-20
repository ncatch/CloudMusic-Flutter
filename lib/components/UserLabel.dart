/*
 * @Description: 用户标签 【头像 昵称 关注按钮】
 * @Author: Walker
 * @Date: 2021-05-19 15:15:35
 * @LastEditTime: 2021-05-20 17:19:37
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/model/Creator.dart';
import 'package:cloudmusic_flutter/pages/userInfo.dart';
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../libs/extends/StringExtend.dart';

class UserLabel extends StatefulWidget {
  final Creator userInfo;

  UserLabel({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserLabelState();
  }
}

class UserLabelState extends State<UserLabel> {
  // 关注 anchor
  attention() {
    attentionUser(widget.userInfo.userId, 1);
  }

  // 跳转用户信息页
  userClick() {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return UserInfo(id: widget.userInfo.userId);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: InkWell(
        onTap: userClick,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.userInfo.avatarUrl,
                        fit: BoxFit.fill,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  widget.userInfo.avatarDetail.identityIconUrl != ""
                      ? Positioned(
                          bottom: 0,
                          right: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              widget.userInfo.avatarDetail.identityIconUrl,
                              fit: BoxFit.fill,
                              width: 12,
                              height: 12,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            Text(
              widget.userInfo.nickname.overFlowString(10),
              style: TextStyle(color: Colors.white70),
            ),
            // 暂时无法判断有没有关注 先注释
            // InkWell(
            //   onTap: attention,
            //   child: Container(
            //     margin: EdgeInsets.fromLTRB(5, 2, 0, 0),
            //     padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       color: Colors.grey.shade300,
            //     ),
            //     child: Icon(
            //       Icons.add,
            //       color: Colors.white,
            //       size: 16,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
