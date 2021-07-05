/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-07-05 13:47:59
 * @LastEditTime: 2021-07-05 15:46:17
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/components/ModelComponent.dart';
import 'package:cloudmusic_flutter/libs/extends/Toast.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:cloudmusic_flutter/model/MenuInfo.dart';
import 'package:cloudmusic_flutter/pages/friend.dart';
import 'package:cloudmusic_flutter/store/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeadMenu extends StatefulWidget {
  HeadMenu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HeadMenuState();
  }
}

class HeadMenuState extends State<HeadMenu> {
  List<List<MenuInfoModel>> menus = [];

  @override
  initState() {
    super.initState();

    menus = [
      [
        MenuInfoModel('本地/下载',
            icon: Icons.library_music, onPressed: localMusicClick),
        MenuInfoModel('云盘',
            icon: Icons.cloud_upload, onPressed: cloudStorageClick),
        MenuInfoModel('已购', icon: Icons.shopping_bag),
        MenuInfoModel('最近播放', icon: Icons.play_circle),
      ],
      [
        MenuInfoModel('我的好友',
            icon: Icons.supervised_user_circle, onPressed: myFriendClick),
        MenuInfoModel('收藏和赞',
            icon: Icons.star_rounded, onPressed: subListClick),
        MenuInfoModel('我的博客', icon: Icons.rss_feed_outlined),
        MenuInfoModel('音乐应用',
            icon: Icons.add_circle_outlined, color: Colors.grey.shade200),
      ],
    ];
  }

  localMusicClick(context, User userStore) {
    if (userStore.checkLogin()) Navigator.pushNamed(context, '/localMusic');
  }

  cloudStorageClick(context, User userStore) {
    if (userStore.checkLogin()) Navigator.pushNamed(context, '/cloudStorage');
  }

  subListClick(context, User userStore) {
    if (userStore.checkLogin()) Navigator.pushNamed(context, '/subList');
  }

  myFriendClick(context, User userStore) {
    if (userStore.checkLogin())
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
        return Friend(
          userId: userStore.userInfo.userId,
        );
      }));
  }

  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<User>(context);

    return ModelComponent(children: [
      Column(
        children: menus
            .map((row) => Container(
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: row
                        .map((e) => Expanded(
                              flex: 1,
                              child: MenuComponent(
                                icon: Icon(
                                  e.icon,
                                  color: e.color ?? primaryColor,
                                  size: 30,
                                ),
                                text: e.text,
                                onPressed: () {
                                  e.onPressed(context, userStore);
                                },
                              ),
                            ))
                        .toList(),
                  ),
                ))
            .toList(),
      )
    ]);
  }
}

class MenuComponent extends StatelessWidget {
  String text = '';
  final void Function() onPressed;
  final Icon? icon;
  double? width;

  MenuComponent({
    Key? key,
    required this.onPressed,
    this.text = '',
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: Alignment.center,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon ?? Container(),
            Text(
              text,
              style: TextStyle(color: Colors.black87, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
