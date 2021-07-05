/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-07-05 13:43:47
 * @LastEditTime: 2021-07-05 13:45:51
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/pages/userInfo.dart';
import 'package:cloudmusic_flutter/store/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeadMenu extends StatelessWidget {
  userClick(context, User userStore) {
    if (userStore.userInfo.userId > 0) {
      // 跳转用户信息页面
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
        return UserInfo(id: userStore.userInfo.userId);
      }));
    } else {
      // 登录
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<User>(context);

    return Container(
      padding: EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          userClick(context, userStore);
        },
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(right: 15),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    image: NetworkImage(userStore.userInfo.avatarUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            userStore.userInfo.userId > 0
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userStore.userInfo.nickname,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.fromLTRB(12, 2, 12, 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white60,
                          ),
                          child: Text(
                            'Lv.${userStore.userInfo.level}',
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    child: Text(
                      '立即登录',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
            Container(
              child: Icon(Icons.navigate_next),
            )
          ],
        ),
      ),
    );
  }
}
