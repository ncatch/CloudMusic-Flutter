/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-12 14:37:24
 * @LastEditTime: 2021-05-19 15:28:06
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/model/UserInfo.dart';

class Creator extends UserInfo {
  AvatarDetail avatarDetail = AvatarDetail();

  Creator() {}

  Creator.fromData(Map<String, dynamic> data) {
    this.userId = data["userId"];
    this.nickname = data["nickname"];
    this.vipType = data["vipType"];
    this.userType = data["userType"];
    this.avatarUrl = data["avatarUrl"];
    this.backgroundUrl = data["backgroundUrl"];

    if (data['avatarDetail'] != null) {
      this.avatarDetail = AvatarDetail.fromData(data['avatarDetail']);
    }
  }
}

class AvatarDetail {
  String identityIconUrl = "";
  int identityLevel = 0;
  int userType = 0;

  AvatarDetail() {}

  AvatarDetail.fromData(Map<String, dynamic> data) {
    this.identityIconUrl = data['identityIconUrl'];

    this.identityLevel = data['identityLevel'];
    this.userType = data['userType'];
  }
}
