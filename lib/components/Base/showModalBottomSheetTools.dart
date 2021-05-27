/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-08 17:16:45
 * @LastEditTime: 2021-05-27 15:55:00
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/model/Comments.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/pages/userInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowCurrMusicList {
  getListItem(playInfoStore) {
    int playCount = playInfoStore.musicList.length;

    return ListView.builder(
      itemCount: playCount,
      itemBuilder: (context, index) {
        var tmpInfo = playInfoStore.musicList[index];

        return InkWell(
            onTap: () {
              playInfoStore.setPlayIndex(index);
              Navigator.pop(context);
            },
            child: Container(
              height: 30,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text(
                          tmpInfo.musicName,
                        ),
                        Text(
                          '-' + tmpInfo.singerName,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  showMusicList(context, playInfoStore) {
    int playCount = playInfoStore.musicList.length;

    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Container(
                height: 50,
                alignment: Alignment.centerLeft,
                child: Text(
                  '当前播放（$playCount）',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(flex: 1, child: getListItem(playInfoStore))
            ],
          ),
        );
      },
    );
  }
}

class ShowHugInfo {
  toUserDetail(context, uid) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return UserInfo(id: uid);
    }));
  }

  ShowHugInfoModal(
      context, CommentInfo commentInfo, PlayListModel playListInfo) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: InkWell(
                      onTap: () {
                        toUserDetail(context, commentInfo.user.userId);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(top: 5),
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(commentInfo.user.avatarUrl),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        toUserDetail(context, commentInfo.user.userId);
                      },
                      child: Text(commentInfo.user.nickname),
                    ),
                  ),
                  Container(
                    child: Text('收到了' +
                        (commentInfo.hugInfo?.hugTotalCounts.toString() ?? '') +
                        '个[抱抱]'),
                  )
                ],
              ),
              Container(
                child: Text(commentInfo.content),
              ),
              Container(
                child: Text('来自歌单' + playListInfo.title),
              ),
              Container(
                height: 100,
                child: ListView(
                  children: commentInfo.hugInfo != null
                      ? commentInfo.hugInfo!.hugComments
                          .map<Widget>((ele) => Container(
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        toUserDetail(context, ele.user.userId);
                                      },
                                      child: Text(ele.user.nickname),
                                    ),
                                    Text(ele.hugContent)
                                  ],
                                ),
                              ))
                          .toList()
                      : [],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
