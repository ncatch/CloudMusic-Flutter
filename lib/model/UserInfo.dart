/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-06 14:36:18
 * @LastEditTime: 2021-05-20 17:14:56
 * @LastEditors: Walker
 */

class UserInfo {
  int userId = 0;
  String nickname = "";
  int vipType = 0;
  int userType = 0;
  String avatarUrl = "";
  String backgroundUrl = "";

  bool followed = false; // 是否关注
  int followeds = 0; // 粉丝数
  int follows = 0; // 关注数

  int level = 0;

  MainAuthType mainAuthType = MainAuthType();
  AvatarDetail avatarDetail = AvatarDetail();

  UserInfo({
    int userId = 0,
    String nickname = "",
    int vipType = 0,
    int userType = 0,
    String avatarUrl = "",
    String backgroundUrl = "",
  }) {
    this.userId = userId;
    this.nickname = nickname;
    this.vipType = vipType;
    this.userType = userType;
    this.avatarUrl = avatarUrl;
    this.backgroundUrl = backgroundUrl;
  }

  UserInfo.fromJson(Map<String, dynamic> jsonstr) {
    this.userId = jsonstr["userId"];
    this.nickname = jsonstr["nickname"];
    this.vipType = jsonstr["vipType"];
    this.userType = jsonstr["userType"];
    this.avatarUrl = jsonstr["avatarUrl"];
    this.backgroundUrl = jsonstr["backgroundUrl"];
    this.followeds = jsonstr["followeds"];
    this.followed = jsonstr["followed"];
    this.follows = jsonstr["follows"];
    this.level = jsonstr["level"] ?? 0;

    if (jsonstr['mainAuthType'] != null) {
      this.mainAuthType = MainAuthType.fromJson(jsonstr['mainAuthType']);
    }

    if (jsonstr['avatarDetail'] != null) {
      this.avatarDetail = AvatarDetail.fromData(jsonstr['avatarDetail']);
    }
  }

  Map toJson() {
    Map map = new Map();
    map["userId"] = this.userId;
    map["nickname"] = this.nickname;
    map["vipType"] = this.vipType;
    map["userType"] = this.userType;
    map["avatarUrl"] = this.avatarUrl;
    map["backgroundUrl"] = this.backgroundUrl;
    map["followeds"] = this.followeds;
    map["followed"] = this.followed;
    map["follows"] = this.follows;
    map["level"] = this.level;
    map["mainAuthType"] = this.mainAuthType;
    return map;
  }
}

class MainAuthType {
  String desc = '';
  List<String> tags = [];
  int type = 0;

  MainAuthType() {}

  MainAuthType.fromJson(Map<String, dynamic> data) {
    this.desc = data['desc'];
    this.type = data['type'];
    this.tags = data['tags'] ?? [];
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
