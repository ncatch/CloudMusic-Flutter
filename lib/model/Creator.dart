/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-12 14:37:24
 * @LastEditTime: 2021-05-12 14:50:41
 * @LastEditors: Walker
 */
class Creator {
  String avatarUrl = "";
  String backgroundUrl = "";
  String nickname = "";

  AvatarDetail avatarDetail = AvatarDetail();

  Creator() {}

  Creator.fromData(Map<String, dynamic> data) {
    this.avatarUrl = data['avatarUrl'];
    this.backgroundUrl = data['backgroundUrl'];
    this.nickname = data['nickname'];
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
