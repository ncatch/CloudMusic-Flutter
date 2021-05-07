/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-07 15:40:01
 * @LastEditTime: 2021-05-07 15:25:37
 * @LastEditors: Walker
 */
class BannerModel {
  String imageUrl = "";
  int musicId = 0;
  int type = 0;

  BannerModel(String imageUrl, int musicId) {
    this.imageUrl = imageUrl;
    this.musicId = musicId;
  }

  BannerModel.fromJson(Map<String, dynamic> jsonstr) {
    this.musicId = jsonstr["targetId"];
    this.imageUrl = jsonstr["pic"];
    this.type = jsonstr["targetType"];
  }
}
