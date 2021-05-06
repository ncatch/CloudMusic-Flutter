/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-06 14:36:18
 * @LastEditTime: 2021-05-06 15:57:17
 * @LastEditors: Walker
 */

class UserInfo {
  int userId = 0;
  String nickname = "";
  int vipType = 0;
  int userType = 0;
  String avatarUrl = "";
  String backgroundUrl = "";

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
  }

  Map toJson() {
    Map map = new Map();
    map["userId"] = this.userId;
    map["nickname"] = this.nickname;
    map["vipType"] = this.vipType;
    map["userType"] = this.userType;
    map["avatarUrl"] = this.avatarUrl;
    map["backgroundUrl"] = this.backgroundUrl;
    return map;
  }
}
