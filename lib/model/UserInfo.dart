/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-06 14:36:18
 * @LastEditTime: 2021-05-20 15:30:33
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
    return map;
  }
}
