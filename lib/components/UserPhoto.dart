/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-06-02 17:47:36
 * @LastEditTime: 2021-06-02 17:49:30
 * @LastEditors: Walker
 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmusic_flutter/model/UserInfo.dart';
import 'package:flutter/material.dart';

class UserPhoto extends StatelessWidget {
  final UserInfo userInfo;
  double size;
  double iconSize;

  UserPhoto(
      {Key? key, required this.userInfo, this.size = 50, this.iconSize = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Stack(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size / 2),
              child: Image.network(
                userInfo.avatarUrl,
                fit: BoxFit.fill,
                width: size,
                height: size,
              ),
            ),
          ),
          userInfo.avatarDetail.identityIconUrl != ""
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(iconSize / 2),
                    child: CachedNetworkImage(
                      imageUrl: userInfo.avatarDetail.identityIconUrl,
                      fit: BoxFit.fill,
                      width: iconSize,
                      height: iconSize,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
