/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-07 15:40:01
 * @LastEditTime: 2021-04-07 15:51:07
 * @LastEditors: Walker
 */
class BannerModel {
  String imageUrl = "";
  String titleColor = "";
  String typeTitle = "";
  String url = "";
  String scm = "";

  BannerModel(String imageUrl, String titleColor, String typeTitle, String url,
      String scm) {
    this.imageUrl = imageUrl;
    this.titleColor = titleColor;
    this.typeTitle = typeTitle;
    this.url = url;
    this.scm = scm;
  }
}
