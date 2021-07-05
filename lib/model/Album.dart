/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-07-02 11:07:04
 * @LastEditTime: 2021-07-02 11:13:37
 * @LastEditors: Walker
 */

class AlbumInfo {
  int id = 0;
  String name = "";
  int size = 0;
  String creater = "";
  String picUrl = "";
  int subTime = 0;

  AlbumInfo() {}

  AlbumInfo.fromJson(Map<String, dynamic> jsonstr) {
    this.id = jsonstr["id"];
    this.name = jsonstr["name"];
    this.size = jsonstr["size"];
    this.picUrl = jsonstr["picUrl"];
    this.subTime = jsonstr["subTime"];

    this.creater = jsonstr["artists"]?[0]["name"];
  }
}
