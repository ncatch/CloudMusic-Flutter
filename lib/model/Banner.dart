/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-07 15:40:01
 * @LastEditTime: 2021-05-08 10:51:55
 * @LastEditors: Walker
 */
class BannerModel {
  String imageUrl = "";
  int musicId = 0;
  int type = 0;
  String url = "";

  BannerModel(String imageUrl, int musicId, int type, String url) {
    this.imageUrl = imageUrl;
    this.musicId = musicId;
    this.type = type;
    this.url = url;
  }

  BannerModel.fromJson(Map<String, dynamic> jsonstr) {
    this.musicId = jsonstr["targetId"];
    this.imageUrl = jsonstr["pic"];
    this.type = jsonstr["targetType"];
    this.url = jsonstr["url"];
  }
}
